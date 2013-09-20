-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: OCM_Clone
-- Source Schemata: OCM_Clone
-- Created: Fri Sep 20 13:42:27 2013
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;;

-- ----------------------------------------------------------------------------
-- Schema OCM_Clone
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `OCM_Clone` ;
CREATE SCHEMA IF NOT EXISTS `OCM_Clone` ;

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.ConnectionType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`ConnectionType` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(400) NOT NULL,
  `FormalName` VARCHAR(400) NULL,
  `IsDiscontinued` TINYINT(1) NULL DEFAULT 0,
  `IsObsolete` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `IX_ConnectionType_Title` (`ID` ASC));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.ConnectionInfo
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`ConnectionInfo` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ChargePointID` INT NOT NULL,
  `ConnectionTypeID` INT NOT NULL,
  `Reference` VARCHAR(200) NULL,
  `StatusTypeID` INT NULL,
  `Amps` INT NULL,
  `Voltage` INT NULL,
  `PowerKW` DOUBLE NULL,
  `LevelTypeID` INT NULL,
  `Quantity` INT NULL,
  `Comments` LONGTEXT NULL,
  `CurrentTypeID` SMALLINT NULL,
  PRIMARY KEY (`ID`),
  INDEX `IX_ConnectionInfo_ChargePointID` (`ChargePointID` ASC),
  CONSTRAINT `FK_ConnectionInfo_ChargerType`
    FOREIGN KEY (`LevelTypeID`)
    REFERENCES `OCM_Clone`.`ChargerType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ConnectionInfo_ChargePoint`
    FOREIGN KEY (`ChargePointID`)
    REFERENCES `OCM_Clone`.`ChargePoint` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ConnectionInfo_ConnectorType`
    FOREIGN KEY (`ConnectionTypeID`)
    REFERENCES `OCM_Clone`.`ConnectionType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ConnectionInfo_CurrentType`
    FOREIGN KEY (`CurrentTypeID`)
    REFERENCES `OCM_Clone`.`CurrentType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ConnectionInfo_StatusType`
    FOREIGN KEY (`StatusTypeID`)
    REFERENCES `OCM_Clone`.`StatusType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = 'List of equipment types and specifications for a given POI';

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.ChargerType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`ChargerType` (
  `ID` INT NOT NULL,
  `Title` VARCHAR(400) NOT NULL,
  `Comments` LONGTEXT NULL,
  `IsFastChargeCapable` TINYINT(1) NOT NULL,
  `DisplayOrder` INT NULL,
  PRIMARY KEY (`ID`));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.UsageType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`UsageType` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(400) NOT NULL,
  `IsPayAtLocation` TINYINT(1) NULL,
  `IsMembershipRequired` TINYINT(1) NULL,
  `IsAccessKeyRequired` TINYINT(1) NULL,
  PRIMARY KEY (`ID`));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.SystemConfig
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`SystemConfig` (
  `ConfigKeyName` VARCHAR(200) NOT NULL,
  `ConfigValue` VARCHAR(1000) NULL,
  `DataTypeID` TINYINT UNSIGNED NULL,
  PRIMARY KEY (`ConfigKeyName`),
  CONSTRAINT `FK_SystemConfig_DataType`
    FOREIGN KEY (`DataTypeID`)
    REFERENCES `OCM_Clone`.`DataType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.CheckinStatusType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`CheckinStatusType` (
  `ID` TINYINT UNSIGNED NOT NULL,
  `Title` VARCHAR(200) NOT NULL,
  `IsPositive` TINYINT(1) NULL DEFAULT 1 COMMENT 'If true, implies positive, if false, implies negative, if null implies neutral',
  `IsAutomatedCheckin` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.CurrentType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`CurrentType` (
  `ID` SMALLINT NOT NULL,
  `Title` VARCHAR(200) NOT NULL,
  `Description` VARCHAR(1000) NULL,
  PRIMARY KEY (`ID`));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.AddressInfo
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`AddressInfo` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(200) NULL,
  `AddressLine1` VARCHAR(2000) NULL,
  `AddressLine2` VARCHAR(2000) NULL,
  `Town` VARCHAR(200) NULL,
  `StateOrProvince` VARCHAR(200) NULL,
  `Postcode` VARCHAR(200) NULL,
  `CountryID` INT NULL,
  `Latitude` DOUBLE NULL,
  `Longitude` DOUBLE NULL,
  `ContactTelephone1` VARCHAR(400) NULL,
  `ContactTelephone2` VARCHAR(400) NULL,
  `ContactEmail` VARCHAR(1000) NULL,
  `AccessComments` LONGTEXT NULL,
  `GeneralComments` LONGTEXT NULL,
  `RelatedURL` VARCHAR(1000) NULL,
  PRIMARY KEY (`ID`),
  INDEX `IX_AddressLocation` (`Latitude` ASC, `Longitude` ASC),
  CONSTRAINT `FK_AddressInfo_Country`
    FOREIGN KEY (`CountryID`)
    REFERENCES `OCM_Clone`.`Country` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.DataType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`DataType` (
  `ID` TINYINT UNSIGNED NOT NULL,
  `Title` VARCHAR(200) NULL,
  PRIMARY KEY (`ID`));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.EntityType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`EntityType` (
  `ID` SMALLINT NOT NULL,
  `Title` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`ID`));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.Operator
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`Operator` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(500) NULL,
  `WebsiteURL` VARCHAR(1000) NULL,
  `Comments` LONGTEXT NULL,
  `PhonePrimaryContact` VARCHAR(200) NULL,
  `PhoneSecondaryContact` VARCHAR(200) NULL,
  `IsPrivateIndividual` TINYINT(1) NULL,
  `AddressInfoID` INT NULL,
  `BookingURL` VARCHAR(1000) NULL,
  `ContactEmail` VARCHAR(1000) NULL,
  `FaultReportEmail` VARCHAR(1000) NULL,
  `IsRestrictedEdit` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_Operator_AddressInfo`
    FOREIGN KEY (`AddressInfoID`)
    REFERENCES `OCM_Clone`.`AddressInfo` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.ChargePoint
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`ChargePoint` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `UUID` VARCHAR(200) NOT NULL,
  `ParentChargePointID` INT NULL,
  `DataProviderID` INT NOT NULL,
  `DataProvidersReference` VARCHAR(200) NULL,
  `OperatorID` INT NULL,
  `OperatorsReference` VARCHAR(200) NULL,
  `UsageTypeID` INT NULL,
  `AddressInfoID` INT NULL,
  `NumberOfPoints` INT NULL,
  `GeneralComments` LONGTEXT NULL,
  `DatePlanned` DATETIME NULL,
  `DateLastConfirmed` DATETIME NULL,
  `StatusTypeID` INT NULL DEFAULT 0,
  `DateLastStatusUpdate` DATETIME NULL,
  `DataQualityLevel` INT NULL,
  `DateCreated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `SubmissionStatusTypeID` INT NULL,
  `UsageCost` VARCHAR(400) NULL,
  `ContributorUserID` INT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `IX_ChargePoint` (`UUID` ASC),
  INDEX `IX_ChargePoint_ParentID` (`ParentChargePointID` ASC),
  INDEX `IX_ChargePointAddressID` (`AddressInfoID` ASC, `ID` ASC),
  CONSTRAINT `FK_ChargePoint_AddressInfo`
    FOREIGN KEY (`AddressInfoID`)
    REFERENCES `OCM_Clone`.`AddressInfo` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ChargePoint_DataProvider`
    FOREIGN KEY (`DataProviderID`)
    REFERENCES `OCM_Clone`.`DataProvider` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ChargePoint_Operator`
    FOREIGN KEY (`OperatorID`)
    REFERENCES `OCM_Clone`.`Operator` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ChargePoint_ChargePoint`
    FOREIGN KEY (`ParentChargePointID`)
    REFERENCES `OCM_Clone`.`ChargePoint` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ChargePoint_UsageType`
    FOREIGN KEY (`UsageTypeID`)
    REFERENCES `OCM_Clone`.`UsageType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ChargePoint_StatusType`
    FOREIGN KEY (`StatusTypeID`)
    REFERENCES `OCM_Clone`.`StatusType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ChargePoint_User`
    FOREIGN KEY (`ContributorUserID`)
    REFERENCES `OCM_Clone`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ChargePoint_SubmissionStatusType`
    FOREIGN KEY (`SubmissionStatusTypeID`)
    REFERENCES `OCM_Clone`.`SubmissionStatusType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.EditQueueItem
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`EditQueueItem` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `UserID` INT NULL COMMENT 'User who submitted this edit',
  `Comment` LONGTEXT NULL,
  `IsProcessed` TINYINT(1) NOT NULL DEFAULT 0,
  `ProcessedByUserID` INT NULL COMMENT 'Editor who approved/processed this edit',
  `DateSubmitted` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DateProcessed` DATETIME NULL,
  `EditData` LONGTEXT NULL,
  `PreviousData` LONGTEXT NULL,
  `EntityID` INT NULL,
  `EntityTypeID` SMALLINT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_EditQueueItem_EntityType`
    FOREIGN KEY (`EntityTypeID`)
    REFERENCES `OCM_Clone`.`EntityType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_EditQueue_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `OCM_Clone`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_EditQueue_User1`
    FOREIGN KEY (`ProcessedByUserID`)
    REFERENCES `OCM_Clone`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.MetadataGroup
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`MetadataGroup` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(200) NOT NULL,
  `IsRestrictedEdit` TINYINT(1) NOT NULL DEFAULT 0,
  `DataProviderID` INT NOT NULL,
  `IsPublicInterest` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_MetadataGroup_DataProvider`
    FOREIGN KEY (`DataProviderID`)
    REFERENCES `OCM_Clone`.`DataProvider` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.MetadataField
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`MetadataField` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `MetadataGroupID` INT NOT NULL,
  `Title` VARCHAR(200) NOT NULL,
  `DataTypeID` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_MetadataField_DataType`
    FOREIGN KEY (`DataTypeID`)
    REFERENCES `OCM_Clone`.`DataType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MetadataField_MetadataGroup`
    FOREIGN KEY (`MetadataGroupID`)
    REFERENCES `OCM_Clone`.`MetadataGroup` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.MetadataValue
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`MetadataValue` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ChargePointID` INT NOT NULL COMMENT 'ID of POI',
  `MetadataFieldID` INT NOT NULL COMMENT 'Metadata Field value relates to',
  `ItemValue` LONGTEXT NULL,
  `MetadataFieldOptionID` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `IX_MetadataValue_ChargePointID` (`ChargePointID` ASC),
  CONSTRAINT `FK_MetadataValue_ChargePoint`
    FOREIGN KEY (`ChargePointID`)
    REFERENCES `OCM_Clone`.`ChargePoint` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MetadataValue_MetadataField`
    FOREIGN KEY (`MetadataFieldID`)
    REFERENCES `OCM_Clone`.`MetadataField` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MetadataValue_MetadataFieldOption`
    FOREIGN KEY (`MetadataFieldOptionID`)
    REFERENCES `OCM_Clone`.`MetadataFieldOption` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = 'Holds custom defined meta data values for a given POI';

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.sysdiagrams
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`sysdiagrams` (
  `name` VARCHAR(160) NOT NULL,
  `principal_id` INT NOT NULL,
  `diagram_id` INT NOT NULL AUTO_INCREMENT,
  `version` INT NULL,
  `definition` LONGBLOB NULL,
  PRIMARY KEY (`diagram_id`),
  UNIQUE INDEX `UK_principal_name` (`principal_id` ASC, `name` ASC));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.MediaItem
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`MediaItem` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ItemURL` VARCHAR(1000) NOT NULL,
  `ItemThumbnailURL` VARCHAR(1000) NULL,
  `Comment` VARCHAR(2000) NULL,
  `ChargePointID` INT NOT NULL,
  `UserID` INT NOT NULL,
  `DateCreated` DATETIME NOT NULL,
  `IsEnabled` TINYINT(1) NOT NULL DEFAULT 1,
  `IsVideo` TINYINT(1) NOT NULL,
  `IsFeaturedItem` TINYINT(1) NOT NULL DEFAULT 0,
  `MetadataValue` VARCHAR(2000) NULL,
  `IsExternalResource` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  INDEX `IX_MediaItem_ChargePointID` (`ChargePointID` ASC),
  CONSTRAINT `FK_MediaItem_ChargePoint`
    FOREIGN KEY (`ChargePointID`)
    REFERENCES `OCM_Clone`.`ChargePoint` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MediaItem_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `OCM_Clone`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.StatusType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`StatusType` (
  `ID` INT NOT NULL,
  `Title` VARCHAR(200) NOT NULL,
  `IsOperational` TINYINT(1) NULL,
  PRIMARY KEY (`ID`));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.User
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`User` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `IdentityProvider` VARCHAR(200) NOT NULL,
  `Identifier` VARCHAR(400) NOT NULL,
  `Username` VARCHAR(200) NULL,
  `CurrentSessionToken` VARCHAR(200) NULL,
  `Profile` LONGTEXT NULL,
  `Location` VARCHAR(1000) NULL,
  `WebsiteURL` VARCHAR(1000) NULL,
  `ReputationPoints` INT NULL DEFAULT 0,
  `Permissions` LONGTEXT NULL,
  `PermissionsRequested` LONGTEXT NULL,
  `DateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DateLastLogin` DATETIME NULL,
  `EmailAddress` VARCHAR(1000) NULL,
  `IsEmergencyChargingProvider` TINYINT(1) NOT NULL DEFAULT 0,
  `IsProfilePublic` TINYINT(1) NOT NULL DEFAULT 1,
  `IsPublicChargingProvider` TINYINT(1) NOT NULL DEFAULT 0,
  `APIKey` VARCHAR(200) NULL,
  `Latitude` DOUBLE NULL,
  `Longitude` DOUBLE NULL,
  PRIMARY KEY (`ID`));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.SubmissionStatusType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`SubmissionStatusType` (
  `ID` INT NOT NULL,
  `Title` VARCHAR(200) NOT NULL,
  `IsLive` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.UserComment
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`UserComment` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ChargePointID` INT NOT NULL,
  `UserCommentTypeID` INT NOT NULL,
  `UserName` VARCHAR(200) NULL,
  `Comment` LONGTEXT NULL,
  `Rating` TINYINT UNSIGNED NULL,
  `RelatedURL` VARCHAR(1000) NULL,
  `DateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CheckinStatusTypeID` TINYINT UNSIGNED NULL,
  `UserID` INT NULL,
  `IsActionedByEditor` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  INDEX `IDX_CommentChargePointID` (`ChargePointID` ASC, `DateCreated` ASC),
  CONSTRAINT `FK_UserComment_CheckinStatusType`
    FOREIGN KEY (`CheckinStatusTypeID`)
    REFERENCES `OCM_Clone`.`CheckinStatusType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserComment_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `OCM_Clone`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserComment_ChargePoint`
    FOREIGN KEY (`ChargePointID`)
    REFERENCES `OCM_Clone`.`ChargePoint` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserComment_UserCommentType`
    FOREIGN KEY (`UserCommentTypeID`)
    REFERENCES `OCM_Clone`.`UserCommentType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.DataProviderUser
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`DataProviderUser` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DataProviderID` INT NOT NULL,
  `UserID` INT NOT NULL,
  `IsDataProviderAdmin` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_DataProviderUser_DataProvider`
    FOREIGN KEY (`DataProviderID`)
    REFERENCES `OCM_Clone`.`DataProvider` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataProviderUser_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `OCM_Clone`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.MetadataFieldOption
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`MetadataFieldOption` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `MetadataFieldID` INT NOT NULL,
  `Title` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_MetadataFieldOption_MetadataField`
    FOREIGN KEY (`MetadataFieldID`)
    REFERENCES `OCM_Clone`.`MetadataField` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.UserCommentType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`UserCommentType` (
  `ID` INT NOT NULL,
  `Title` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`ID`));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.tmp_bulkimport
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`tmp_bulkimport` (
  `ID` VARCHAR(510) NULL,
  `LocationTitle` VARCHAR(510) NULL,
  `AddressLine1` VARCHAR(510) NULL,
  `AddressLine2` VARCHAR(510) NULL,
  `Town` VARCHAR(510) NULL,
  `StateOrProvince` VARCHAR(510) NULL,
  `Postcode` VARCHAR(510) NULL,
  `Country` VARCHAR(510) NULL,
  `Latitude` DOUBLE NULL,
  `Longitude` DOUBLE NULL,
  `Addr_ContactTelephone1` VARCHAR(510) NULL,
  `Addr_ContactTelephone2` VARCHAR(510) NULL,
  `Addr_ContactEmail` VARCHAR(510) NULL,
  `Addr_AccessComments` LONGTEXT NULL,
  `Addr_GeneralComments` LONGTEXT NULL,
  `Addr_RelatedURL` VARCHAR(510) NULL,
  `UsageType` VARCHAR(510) NULL,
  `NumberOfPoints` DOUBLE NULL,
  `GeneralComments` LONGTEXT NULL,
  `DateLastConfirmed` DATETIME NULL,
  `StatusType` VARCHAR(510) NULL,
  `DateLastStatusUpdate` VARCHAR(510) NULL,
  `UsageCost` VARCHAR(510) NULL,
  `Connection1_Type` VARCHAR(510) NULL,
  `Connection1_Amps` INT NULL,
  `Connection1_Volts` INT NULL,
  `Connection1_Level` VARCHAR(510) NULL,
  `Connection1_Quantity` INT NULL,
  `Connection2_Type` VARCHAR(510) NULL,
  `Connection2_Amps` INT NULL,
  `Connection2_Volts` INT NULL,
  `Connection2_Level` VARCHAR(510) NULL,
  `Connection2_Quantity` INT NULL,
  `Connection3_Type` VARCHAR(510) NULL,
  `Connection3_Amps` INT NULL,
  `Connection3_Volts` INT NULL,
  `Connection3_Level` VARCHAR(510) NULL,
  `Connection3_Quantity` INT NULL,
  `Connection4_Type` VARCHAR(510) NULL,
  `Connection4_Amps` INT NULL,
  `Connection4_Volts` INT NULL,
  `Connection4_Level` VARCHAR(510) NULL,
  `Connection4_Quantity` INT NULL,
  `Connection5_Type` VARCHAR(510) NULL,
  `Connection5_Amps` INT NULL,
  `Connection5_Volts` INT NULL,
  `Connection5_Level` VARCHAR(510) NULL,
  `Connection5_Quantity` INT NULL);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.AuditLog
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`AuditLog` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `EventDate` DATETIME NOT NULL,
  `UserID` INT NOT NULL,
  `EventDescription` LONGTEXT NULL,
  `Comment` LONGTEXT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_AuditLog_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `OCM_Clone`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.DataProvider
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`DataProvider` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(500) NOT NULL,
  `WebsiteURL` VARCHAR(1000) NULL,
  `Comments` LONGTEXT NULL,
  `DataProviderStatusTypeID` INT NULL,
  `IsRestrictedEdit` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_DataProvider_DataProviderStatus`
    FOREIGN KEY (`DataProviderStatusTypeID`)
    REFERENCES `OCM_Clone`.`DataProviderStatusType` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.DataProviderStatusType
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`DataProviderStatusType` (
  `ID` INT NOT NULL,
  `Title` VARCHAR(400) NOT NULL,
  `IsProviderEnabled` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`));

-- ----------------------------------------------------------------------------
-- Table OCM_Clone.Country
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `OCM_Clone`.`Country` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(200) NOT NULL,
  `ISOCode` VARCHAR(100) NULL,
  PRIMARY KEY (`ID`));
SET FOREIGN_KEY_CHECKS = 1;;
