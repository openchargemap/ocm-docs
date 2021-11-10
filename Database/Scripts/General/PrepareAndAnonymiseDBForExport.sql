--remove unnecessary or sensitive data for distribution of database to interested parties
TRUNCATE TABLE AuditLog
TRUNCATE TABLE EditQueueItem
TRUNCATE TABLE UserSubscription
TRUNCATE TABLE UserChargingRequest
TRUNCATE TABLE SessionState
TRUNCATE TABLE [RegisteredApplication]

--UPDATE [User] SET Identifier=SUBSTRING(HASHBYTES('SHA1', Identifier),0,16), Username=SUBSTRING(HASHBYTES('SHA1', Username),0,16), CurrentSessionToken='****Anon****', DateLastLogin=NULL,EmailAddress='anon@openchargemap.org', Location=NULL, APIKey=NULL, Latitude=NULL, Longitude=NULL
UPDATE UserComment SET UserName = [User].Username FROM [User] WHERE UserComment.UserID=[User].ID
UPDATE UserComment Set UserName='A.N. Otheruser' WHERE UserID IS NULL

CHECKPOINT

DBCC SHRINKDATABASE(@DBName )

ALTER DATABASE [OCM_Export] SET RECOVERY SIMPLE WITH NO_WAIT

DBCC SHRINKDATABASE(@DBName )

BACKUP DATABASE [OCM_Export] TO  DISK = N'C:\Temp\OCM_Clone.bak' WITH NOFORMAT, INIT,  NAME = N'OCM_Clone Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10

declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=@DBName and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=@DBName )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'C:\Temp\OCM_Clone.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO
