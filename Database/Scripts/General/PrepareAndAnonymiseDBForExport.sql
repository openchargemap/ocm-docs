--remove unnecessary or sensitive data for distribution of database to interested parties
DECLARE @DBName nvarchar(100)='OCM_Clone'

TRUNCATE TABLE AuditLog
TRUNCATE TABLE EditQueueItem

UPDATE [User] SET Identifier=SUBSTRING(HASHBYTES('SHA1', Identifier),0,16), Username=SUBSTRING(HASHBYTES('SHA1', Username),0,16), CurrentSessionToken='****Anon****', DateLastLogin=NULL,EmailAddress='anon@openchargemap.org', Location=NULL, APIKey=NULL, Latitude=NULL, Longitude=NULL

CHECKPOINT

DBCC SHRINKDATABASE(@DBName )

BACKUP DATABASE [OCM_Clone] TO  DISK = N'C:\Temp\OCM_Clone.bak' WITH NOFORMAT, INIT,  NAME = N'OCM_Clone Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10

declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=@DBName and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=@DBName )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'C:\Temp\OCM_Clone.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO
