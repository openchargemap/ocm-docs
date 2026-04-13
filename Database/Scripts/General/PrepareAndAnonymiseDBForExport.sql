-- Created by GitHub Copilot in SSMS - review carefully before executing

-- Script to identify and remove inactive users who have made no contributions
-- for database anonymization and size reduction

--=====================================================
-- DECLARE VARIABLES
--=====================================================
DECLARE @DBName NVARCHAR(128) = DB_NAME();
DECLARE @backupSetId INT;
DECLARE @InactiveUserCount INT;
DECLARE @SQL NVARCHAR(MAX);

--=====================================================
-- STEP 1: IDENTIFY INACTIVE USERS (FOR REVIEW)
--=====================================================
-- Users who have never contributed anything to the database
SELECT 
    u.ID,
    u.Username,
    u.DateCreated,
    u.DateLastLogin
FROM [dbo].[User] u
WHERE NOT EXISTS (
    SELECT 1 FROM [dbo].[EditQueueItemArchive] WHERE UserID = u.ID
)
AND NOT EXISTS (
    SELECT 1 FROM [dbo].[EditQueueItemArchive] WHERE ProcessedByUserID = u.ID
)
AND NOT EXISTS (
    SELECT 1 FROM [dbo].[UserComment] WHERE UserID = u.ID
)
AND NOT EXISTS (
    SELECT 1 FROM [dbo].[MediaItem] WHERE UserID = u.ID
)
AND NOT EXISTS (
    SELECT 1 FROM [dbo].[RegisteredApplication] WHERE UserID = u.ID
)
AND NOT EXISTS (
    SELECT 1 FROM [dbo].[RegisteredApplicationUser] WHERE UserID = u.ID
)
AND NOT EXISTS (
    SELECT 1 FROM [dbo].[DataSharingAgreement] WHERE UserID = u.ID
)
AND NOT EXISTS (
    SELECT 1 FROM [dbo].[Statistic] WHERE UserID = u.ID
)
ORDER BY u.DateCreated DESC;

--=====================================================
-- STEP 2: DISABLE CONSTRAINTS
--=====================================================
PRINT 'Disabling constraints...';
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

--=====================================================
-- STEP 3: REMOVE/TRUNCATE SENSITIVE OPERATIONAL DATA
--=====================================================
PRINT 'Removing sensitive operational data...';

TRUNCATE TABLE [dbo].[AuditLog];
TRUNCATE TABLE [dbo].[EditQueueItem];
TRUNCATE TABLE [dbo].[EditQueueItemArchive];
TRUNCATE TABLE [dbo].[UserSubscription];
TRUNCATE TABLE [dbo].[UserChargingRequest];
TRUNCATE TABLE [dbo].[SessionState];
TRUNCATE TABLE [dbo].[RegisteredApplicationUser];
delete from RegisteredApplication

--=====================================================
-- STEP 4: DELETE INACTIVE USERS
--=====================================================
PRINT 'Deleting inactive users...';

DELETE FROM [dbo].[User]
WHERE ID IN (
    SELECT u.ID
    FROM [dbo].[User] u
    WHERE NOT EXISTS (SELECT 1 FROM [dbo].[EditQueueItemArchive] WHERE UserID = u.ID)
    AND NOT EXISTS (SELECT 1 FROM [dbo].[EditQueueItemArchive] WHERE ProcessedByUserID = u.ID)
    AND NOT EXISTS (SELECT 1 FROM [dbo].[UserComment] WHERE UserID = u.ID)
    AND NOT EXISTS (SELECT 1 FROM [dbo].[MediaItem] WHERE UserID = u.ID)
    AND NOT EXISTS (SELECT 1 FROM [dbo].[RegisteredApplication] WHERE UserID = u.ID)
    AND NOT EXISTS (SELECT 1 FROM [dbo].[RegisteredApplicationUser] WHERE UserID = u.ID)
    AND NOT EXISTS (SELECT 1 FROM [dbo].[DataSharingAgreement] WHERE UserID = u.ID)
    AND NOT EXISTS (SELECT 1 FROM [dbo].[Statistic] WHERE UserID = u.ID)
);

SET @InactiveUserCount = @@ROWCOUNT;
PRINT 'Deleted ' + CAST(@InactiveUserCount AS VARCHAR(10)) + ' inactive users.';

--=====================================================
-- STEP 5: ANONYMIZE REMAINING USERS
--=====================================================
PRINT 'Anonymizing remaining active users...';

UPDATE [dbo].[User]
SET 
    Identifier = CONVERT(VARCHAR(32), HASHBYTES('SHA2_256', CAST(ID AS VARCHAR(10))), 2),
    Username = 'User_' + CAST(ID AS VARCHAR(10)),
    PasswordHash = NULL,
    CurrentSessionToken = NULL,
    DateLastLogin = NULL,
    EmailAddress = 'user' + CAST(ID AS VARCHAR(10)) + '@example.com',
    Location = NULL,
    APIKey = NULL,
    Latitude = NULL,
    Longitude = NULL,
    Profile = NULL,
    WebsiteURL = NULL,
    SyncedSettings = NULL;

--=====================================================
-- STEP 6: ANONYMIZE USER COMMENTS
--=====================================================
PRINT 'Anonymizing user comments...';

-- Update comments with user references
UPDATE [dbo].[UserComment]
SET UserName = u.Username
FROM [dbo].[User] u
WHERE [dbo].[UserComment].UserID = u.ID;

-- Update comments with no user reference
UPDATE [dbo].[UserComment]
SET UserName = 'Anonymous'
WHERE UserID IS NULL;

--=====================================================
-- STEP 7: ANONYMIZE DATA SHARING AGREEMENTS
--=====================================================
PRINT 'Anonymizing data sharing agreements...';

UPDATE [dbo].[DataSharingAgreement]
SET 
    RepresentativeName = 'Representative_' + CAST(ID AS VARCHAR(10)),
    ContactEmail = 'contact' + CAST(ID AS VARCHAR(10)) + '@example.com',
    Credentials = NULL;

--=====================================================
-- STEP 8: RE-ENABLE CONSTRAINTS
--=====================================================
PRINT 'Re-enabling constraints...';
EXEC sp_MSforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';

--=====================================================
-- STEP 9: OPTIMIZE DATABASE
--=====================================================
PRINT 'Setting recovery model to SIMPLE...';
SET @SQL = N'ALTER DATABASE [' + @DBName + N'] SET RECOVERY SIMPLE WITH NO_WAIT';
EXEC sp_executesql @SQL;

PRINT 'Performing checkpoint...';
CHECKPOINT;

PRINT 'Shrinking database...';
DBCC SHRINKDATABASE(@DBName);

--=====================================================
-- STEP 10: BACKUP DATABASE
--=====================================================
DECLARE @BackupPath NVARCHAR(500) = N'C:\Temp\' + @DBName + N'_Anonymized.bak';
PRINT 'Backing up to: ' + @BackupPath;

SET @SQL = N'BACKUP DATABASE [' + @DBName + N'] TO DISK = ''' + @BackupPath + N''' WITH NOFORMAT, INIT, NAME = ''' + @DBName + N' Anonymized Backup'', SKIP, NOREWIND, NOUNLOAD, COMPRESSION, STATS = 10';
EXEC sp_executesql @SQL;

--=====================================================
-- STEP 11: VERIFY BACKUP
--=====================================================
PRINT 'Verifying backup...';

SELECT @backupSetId = position
FROM msdb..backupset
WHERE database_name = @DBName
  AND backup_set_id = (SELECT MAX(backup_set_id) FROM msdb..backupset WHERE database_name = @DBName);

IF @backupSetId IS NULL
    RAISERROR(N'Verify failed. Backup information not found.', 16, 1);

SET @SQL = N'RESTORE VERIFYONLY FROM DISK = ''' + @BackupPath + N''' WITH FILE = ' + CAST(@backupSetId AS NVARCHAR(10)) + N', NOUNLOAD, NOREWIND';
EXEC sp_executesql @SQL;

PRINT 'Anonymization complete!';
GO