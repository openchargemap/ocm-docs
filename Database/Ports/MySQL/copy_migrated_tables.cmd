REM Workbench Table Data copy script
REM 
REM Execute this to copy table data from a source RDBMS to MySQL.
REM Edit the options below to customize it. You will need to provide passwords, at least.
REM 
REM Source DB: Mssql@OCM (Microsoft SQL Server)
REM Target DB: Mysql@localhost:3306


@ECHO OFF
REM Source and target DB passwords
set arg_source_password=
set arg_target_password=

IF [%arg_source_password%] == [] (
    IF [%arg_target_password%] == [] (
        ECHO WARNING: Both source and target RDBMSes passwords are empty. You should edit this file to set them.
    )
)
set arg_worker_count=2
REM Uncomment the following options according to your needs

REM Whether target tables should be truncated before copy
set arg_truncate_target=--truncate-target
REM Enable debugging output
REM set arg_debug_output=--log-level=debug3


REM Creation of file with table definitions for copytable

set table_file="%TMP%\wb_tables_to_migrate.txt"
TYPE NUL > "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[MetadataField]	`OCM_Clone`	`MetadataField`	[ID], [MetadataGroupID], [Title], [DataTypeID] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[DataProvider]	`OCM_Clone`	`DataProvider`	[ID], [Title], [WebsiteURL], [Comments], [DataProviderStatusTypeID], [IsRestrictedEdit] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[User]	`OCM_Clone`	`User`	[ID], [IdentityProvider], [Identifier], [Username], [CurrentSessionToken], [Profile], [Location], [WebsiteURL], [ReputationPoints], [Permissions], [PermissionsRequested], [DateCreated], [DateLastLogin], [EmailAddress], [IsEmergencyChargingProvider], [IsProfilePublic], [IsPublicChargingProvider], [APIKey], [Latitude], [Longitude] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[ChargerType]	`OCM_Clone`	`ChargerType`	[ID], [Title], [Comments], [IsFastChargeCapable], [DisplayOrder] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[Country]	`OCM_Clone`	`Country`	[ID], [Title], CAST([ISOCode] as NVARCHAR(100)) as [ISOCode] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[MetadataValue]	`OCM_Clone`	`MetadataValue`	[ID], [ChargePointID], [MetadataFieldID], [ItemValue], [MetadataFieldOptionID] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[ConnectionInfo]	`OCM_Clone`	`ConnectionInfo`	[ID], [ChargePointID], [ConnectionTypeID], [Reference], [StatusTypeID], [Amps], [Voltage], [PowerKW], [LevelTypeID], [Quantity], [Comments], [CurrentTypeID] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[EditQueueItem]	`OCM_Clone`	`EditQueueItem`	[ID], [UserID], [Comment], [IsProcessed], [ProcessedByUserID], [DateSubmitted], [DateProcessed], [EditData], [PreviousData], [EntityID], [EntityTypeID] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[DataProviderUser]	`OCM_Clone`	`DataProviderUser`	[ID], [DataProviderID], [UserID], [IsDataProviderAdmin] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[ChargePoint]	`OCM_Clone`	`ChargePoint`	[ID], [UUID], [ParentChargePointID], [DataProviderID], [DataProvidersReference], [OperatorID], [OperatorsReference], [UsageTypeID], [AddressInfoID], [NumberOfPoints], [GeneralComments], [DatePlanned], [DateLastConfirmed], [StatusTypeID], [DateLastStatusUpdate], [DataQualityLevel], [DateCreated], [SubmissionStatusTypeID], [UsageCost], [ContributorUserID] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[UsageType]	`OCM_Clone`	`UsageType`	[ID], [Title], [IsPayAtLocation], [IsMembershipRequired], [IsAccessKeyRequired] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[StatusType]	`OCM_Clone`	`StatusType`	[ID], [Title], [IsOperational] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[tmp_bulkimport]	`OCM_Clone`	`tmp_bulkimport`	[ID], [LocationTitle], [AddressLine1], [AddressLine2], [Town], [StateOrProvince], [Postcode], [Country], [Latitude], [Longitude], [Addr_ContactTelephone1], [Addr_ContactTelephone2], [Addr_ContactEmail], [Addr_AccessComments], [Addr_GeneralComments], [Addr_RelatedURL], [UsageType], [NumberOfPoints], [GeneralComments], [DateLastConfirmed], [StatusType], [DateLastStatusUpdate], [UsageCost], [Connection1_Type], [Connection1_Amps], [Connection1_Volts], [Connection1_Level], [Connection1_Quantity], [Connection2_Type], [Connection2_Amps], [Connection2_Volts], [Connection2_Level], [Connection2_Quantity], [Connection3_Type], [Connection3_Amps], [Connection3_Volts], [Connection3_Level], [Connection3_Quantity], [Connection4_Type], [Connection4_Amps], [Connection4_Volts], [Connection4_Level], [Connection4_Quantity], [Connection5_Type], [Connection5_Amps], [Connection5_Volts], [Connection5_Level], [Connection5_Quantity] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[CheckinStatusType]	`OCM_Clone`	`CheckinStatusType`	[ID], [Title], [IsPositive], [IsAutomatedCheckin] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[DataProviderStatusType]	`OCM_Clone`	`DataProviderStatusType`	[ID], [Title], [IsProviderEnabled] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[SystemConfig]	`OCM_Clone`	`SystemConfig`	[ConfigKeyName], [ConfigValue], [DataTypeID] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[EntityType]	`OCM_Clone`	`EntityType`	[ID], [Title] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[MediaItem]	`OCM_Clone`	`MediaItem`	[ID], [ItemURL], [ItemThumbnailURL], [Comment], [ChargePointID], [UserID], [DateCreated], [IsEnabled], [IsVideo], [IsFeaturedItem], [MetadataValue], [IsExternalResource] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[CurrentType]	`OCM_Clone`	`CurrentType`	[ID], [Title], [Description] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[UserCommentType]	`OCM_Clone`	`UserCommentType`	[ID], [Title] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[AuditLog]	`OCM_Clone`	`AuditLog`	[ID], [EventDate], [UserID], [EventDescription], [Comment] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[DataType]	`OCM_Clone`	`DataType`	[ID], [Title] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[UserComment]	`OCM_Clone`	`UserComment`	[ID], [ChargePointID], [UserCommentTypeID], [UserName], [Comment], [Rating], [RelatedURL], [DateCreated], [CheckinStatusTypeID], [UserID], [IsActionedByEditor] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[sysdiagrams]	`OCM_Clone`	`sysdiagrams`	CAST([name] as VARCHAR(160)) as [name], [principal_id], [diagram_id], [version], [definition] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[MetadataFieldOption]	`OCM_Clone`	`MetadataFieldOption`	[ID], [MetadataFieldID], [Title] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[AddressInfo]	`OCM_Clone`	`AddressInfo`	[ID], [Title], [AddressLine1], [AddressLine2], [Town], [StateOrProvince], [Postcode], [CountryID], [Latitude], [Longitude], [ContactTelephone1], [ContactTelephone2], [ContactEmail], [AccessComments], [GeneralComments], [RelatedURL] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[SubmissionStatusType]	`OCM_Clone`	`SubmissionStatusType`	[ID], [Title], [IsLive] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[Operator]	`OCM_Clone`	`Operator`	[ID], [Title], [WebsiteURL], [Comments], [PhonePrimaryContact], [PhoneSecondaryContact], [IsPrivateIndividual], [AddressInfoID], [BookingURL], [ContactEmail], [FaultReportEmail], [IsRestrictedEdit] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[ConnectionType]	`OCM_Clone`	`ConnectionType`	[ID], [Title], [FormalName], [IsDiscontinued], [IsObsolete] >> "%TMP%\wb_tables_to_migrate.txt"
ECHO [OCM_Clone]	[dbo].[MetadataGroup]	`OCM_Clone`	`MetadataGroup`	[ID], [Title], [IsRestrictedEdit], [DataProviderID], [IsPublicInterest] >> "%TMP%\wb_tables_to_migrate.txt"


wbcopytables.exe --odbc-source="DSN=OCM;DATABASE=;UID=" --target="root@localhost:3306" --source-password="%arg_source_password%" --target-password="%arg_target_password%" --table-file="%table_file%" --thread-count=%arg_worker_count% %arg_truncate_target% %arg_debug_output%

REM Removes the file with the table definitions
DEL "%TMP%\wb_tables_to_migrate.txt"


