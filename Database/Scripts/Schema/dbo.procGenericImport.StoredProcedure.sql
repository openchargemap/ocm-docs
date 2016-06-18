USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procGenericImport]
(
	@ImportType varchar(10) = 'BULK',
	@ImportFilePath varchar(500) = NULL,
	@ImportFileName varchar(500) = NULL,
	@CountryID INT = NULL,
	@DataProviderID int,
	@OperatorID int
)
AS

SET XACT_ABORT ON
BEGIN TRANSACTION
IF @OperatorID IS NULL BEGIN
	PRINT 'Operator ID Not Set'
	RETURN
END

IF @DataProviderID IS NULL BEGIN
	PRINT 'Data Provider ID Not Set'
	RETURN
END

--Location Details
DECLARE @CountryName nvarchar(200)
DECLARE @LocationTitle nvarchar(100)
DECLARE @AddressLine1 nvarchar(1000)
DECLARE @AddressLine2 nvarchar(1000)
DECLARE @Town nvarchar(100)
DECLARE @StateOrProvince NVARCHAR(100)
DECLARE @Postcode nvarchar(100)
DECLARE @Latitude float
DECLARE @Longitude float
DECLARE @AccessComments nvarchar(max)
DECLARE @ContactTelephone1 NVARCHAR(200)
DECLARE @ContactTelephone2 NVARCHAR(200)
DECLARE @ContactEmail NVARCHAR(255)
DECLARE @LocationGeneralComments nvarchar(max)
DECLARE @LocationRelatedURL nvarchar(500)

--Equipment details
DECLARE @Connection1_TypeID INT
DECLARE @Connection1_LevelID INT
DECLARE @Connection1_Amps INT
DECLARE @Connection1_Voltage INT
DECLARE @Connection1_Quantity INT

DECLARE @Connection2_TypeID INT
DECLARE @Connection2_LevelID INT
DECLARE @Connection2_Amps INT
DECLARE @Connection2_Voltage INT
DECLARE @Connection2_Quantity INT

DECLARE @Connection3_TypeID INT
DECLARE @Connection3_LevelID INT
DECLARE @Connection3_Amps INT
DECLARE @Connection3_Voltage INT
DECLARE @Connection3_Quantity INT

DECLARE @Connection4_TypeID INT
DECLARE @Connection4_LevelID INT
DECLARE @Connection4_Amps INT
DECLARE @Connection4_Voltage INT
DECLARE @Connection4_Quantity INT

DECLARE @Connection5_TypeID INT
DECLARE @Connection5_LevelID INT
DECLARE @Connection5_Amps INT
DECLARE @Connection5_Voltage INT
DECLARE @Connection5_Quantity INT

DECLARE @UsageTypeID INT = 1
DECLARE @UsageCost NVARCHAR(200)
DECLARE @NumberOfPoints INT

DECLARE @DataProvidersReference nvarchar(100)
DECLARE @OperatorsReference nvarchar(100)
DECLARE @GeneralComments nvarchar(max)
DECLARE @DateLastConfirmed DATETIME
DECLARE @ChargePointComments nvarchar(max)
DECLARE @StatusTypeID INT
DECLARE @DateLastStatusUpdate DATETIME

-----------------------------------------------------

SET DATEFORMAT DMY
DECLARE db_cursor CURSOR FOR  
SELECT 
	import.ID, LocationTitle, AddressLine1, AddressLine2, Town, StateOrProvince,PostCode, Country,
	Latitude, Longitude, Addr_ContactTelephone1, Addr_ContactTelephone2, Addr_ContactEmail,
	Addr_AccessComments, Addr_GeneralComments, Addr_RelatedURL,
	CASE WHEN con1.ID IS NOT NULL THEN con1.ID WHEN Connection1_Type LIKE '% 13%Socket%' THEN 3	WHEN Connection1_Type LIKE '%CHAdeMO%' THEN 2 ELSE 0 END AS Connection1_Type,
	CASE WHEN con1_level.ID IS NOT NULL THEN con1_level.ID ELSE NULL END AS Connection1_Level,
	Connection1_Amps, Connection1_Volts, Connection1_Quantity,
	CASE WHEN con2.ID IS NOT NULL THEN con2.ID WHEN Connection2_Type LIKE '% 13%Socket%' THEN 3	WHEN Connection2_Type LIKE '%CHAdeMO%' THEN 2 ELSE 0 END AS Connection2_Type,
	CASE WHEN con2_level.ID IS NOT NULL THEN con2_level.ID ELSE NULL END AS Connection2_Level,
	Connection2_Amps, Connection2_Volts, Connection2_Quantity,
	CASE WHEN con3.ID IS NOT NULL THEN con3.ID WHEN Connection3_Type LIKE '% 13%Socket%' THEN 3	WHEN Connection3_Type LIKE '%CHAdeMO%' THEN 2 ELSE 0 END AS Connection3_Type,
	CASE WHEN con3_level.ID IS NOT NULL THEN con3_level.ID ELSE NULL END AS Connection3_Level,
	Connection3_Amps, Connection3_Volts, Connection3_Quantity,
	CASE WHEN con4.ID IS NOT NULL THEN con4.ID WHEN Connection4_Type LIKE '% 13%Socket%' THEN 3	WHEN Connection4_Type LIKE '%CHAdeMO%' THEN 2 ELSE 0 END AS Connection4_Type,
	CASE WHEN con4_level.ID IS NOT NULL THEN con4_level.ID ELSE NULL END AS Connection4_Level,
	Connection4_Amps, Connection4_Volts, Connection4_Quantity,
	CASE WHEN con5.ID IS NOT NULL THEN con5.ID WHEN Connection5_Type LIKE '% 13%Socket%' THEN 3	WHEN Connection5_Type LIKE '%CHAdeMO%' THEN 2 ELSE 0 END AS Connection5_Type,
	CASE WHEN con5_level.ID IS NOT NULL THEN con5_level.ID ELSE NULL END AS Connection5_Level,
	Connection5_Amps, Connection5_Volts, Connection5_Quantity,
	CASE 
		WHEN usg.ID IS NOT NULL THEN usg.ID
		WHEN UsageType='Public' THEN 1 --public
		WHEN UsageType='Private' THEN 2 --private restricted access
		WHEN UsageType='Private Individual' THEN 3 -- Privately Owned - Notice Required
		WHEN UsageType='Privately Owned' THEN 3 
		ELSE NULL 
	END AS UsageType,
	UsageCost,
	CONVERT(INT,[NumberOfPoints]) AS NumberOfPoints,
	GeneralComments,
	CONVERT(datetime,DateLastConfirmed),
	CASE 
		WHEN stat.ID IS NOT NULL THEN stat.ID
		WHEN StatusType='Unknown' THEN 0
		WHEN StatusType='Available' THEN 10
		WHEN StatusType='In Use' THEN 20
		WHEN StatusType='Unavailable' THEN 20
		WHEN StatusType='Temporarily Unavailable' THEN 30
		WHEN StatusType='Operational' THEN 50
		WHEN StatusType='Not Operational' THEN 100
		ELSE NULL 
	END AS StatusTypeID,
	CONVERT(datetime,DateLastStatusUpdate)
 FROM tmp_bulkimport import
	 LEFT JOIN ConnectionType con1 ON con1.Title=import.Connection1_Type
	 LEFT JOIN ChargerType con1_level ON con1_level.Title=import.Connection1_Level
	 LEFT JOIN ConnectionType con2 ON con2.Title=import.Connection2_Type
	 LEFT JOIN ChargerType con2_level ON con2_level.Title=import.Connection2_Level
	 LEFT JOIN ConnectionType con3 ON con3.Title=import.Connection3_Type
	 LEFT JOIN ChargerType con3_level ON con3_level.Title=import.Connection3_Level
	 LEFT JOIN ConnectionType con4 ON con4.Title=import.Connection4_Type
	 LEFT JOIN ChargerType con4_level ON con4_level.Title=import.Connection4_Level
	 LEFT JOIN ConnectionType con5 ON con5.Title=import.Connection5_Type
	 LEFT JOIN ChargerType con5_level ON con5_level.Title=import.Connection5_Level
	 LEFT JOIN UsageType usg on usg.Title = import.UsageType
	 LEFT JOIN StatusType stat on stat.Title = import.StatusType
 WHERE 
	LocationTitle IS NOT NULL


OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO 
	@DataProvidersReference, @LocationTitle, @AddressLine1,  @AddressLine2, @Town, @StateOrProvince, 
	@Postcode, @CountryName, @Latitude, @Longitude,  @ContactTelephone1, @ContactTelephone2, @ContactEmail,
	@AccessComments, @LocationGeneralComments, @LocationRelatedURL, 
	@Connection1_TypeID, @Connection1_LevelID, @Connection1_Amps, @Connection1_Voltage, @Connection1_Quantity, 
	@Connection2_TypeID, @Connection2_LevelID, @Connection2_Amps, @Connection2_Voltage, @Connection2_Quantity, 
	@Connection3_TypeID, @Connection3_LevelID, @Connection3_Amps, @Connection3_Voltage, @Connection3_Quantity, 
	@Connection4_TypeID, @Connection4_LevelID, @Connection4_Amps, @Connection4_Voltage, @Connection4_Quantity, 
	@Connection5_TypeID, @Connection5_LevelID, @Connection5_Amps, @Connection5_Voltage, @Connection5_Quantity, 
	@UsageTypeID, @UsageCost, @NumberOfPoints, @GeneralComments, @DateLastConfirmed, @StatusTypeID,@DateLastStatusUpdate

WHILE @@FETCH_STATUS = 0   
BEGIN   
	
	SELECT @CountryID = ID FROM dbo.Country WHERE (ISOCode=@CountryName OR Title=@CountryName)
	IF @CountryID IS NULL BEGIN
		RAISERROR ('Country ID could not be determined from import data',10,1)
	END
	
	--insert/update data
   EXEC procInsertOrUpdateChargePoint 
		@DataProviderID = @DataProviderID,
		@DataProvidersReference= @DataProvidersReference, 
		@OperatorID = @OperatorID,
		@OperatorsReference= @OperatorsReference, 
		@LocationTitle= @LocationTitle,
		@AddressLine1=@AddressLine1,
		@AddressLine2=@AddressLine2,
		@Town=@Town,
		@StateOrProvince=@StateOrProvince,
		@Postcode=@Postcode,
		@CountryID=@CountryID,
		@Latitude=@Latitude,
		@Longitude=@Longitude,
		@ContactTelephone1=@ContactTelephone1,
		@ContactTelephone2=@ContactTelephone2,
		@ContactEmail = @ContactEmail,
		@AccessComments=@AccessComments,
		@LocationGeneralComments=@LocationGeneralComments,
		@LocationRelatedURL=@LocationRelatedURL,
		@Connection1_TypeID =@Connection1_TypeID, @Connection1_LevelID =@Connection1_LevelID, @Connection1_Amps = @Connection1_Amps,@Connection1_Voltage = @Connection1_Voltage, @Connection1_Quantity = @Connection1_Quantity,
		@Connection2_TypeID =@Connection2_TypeID, @Connection2_LevelID =@Connection2_LevelID, @Connection2_Amps = @Connection2_Amps,@Connection2_Voltage = @Connection2_Voltage, @Connection2_Quantity = @Connection2_Quantity,
		@Connection3_TypeID =@Connection3_TypeID, @Connection3_LevelID =@Connection3_LevelID, @Connection3_Amps = @Connection3_Amps,@Connection3_Voltage = @Connection3_Voltage, @Connection3_Quantity = @Connection3_Quantity,
		@Connection4_TypeID =@Connection4_TypeID, @Connection4_LevelID =@Connection4_LevelID, @Connection4_Amps = @Connection4_Amps,@Connection4_Voltage = @Connection4_Voltage, @Connection4_Quantity = @Connection4_Quantity,
		@Connection5_TypeID =@Connection5_TypeID, @Connection5_LevelID =@Connection5_LevelID, @Connection5_Amps = @Connection5_Amps,@Connection5_Voltage = @Connection5_Voltage, @Connection5_Quantity = @Connection5_Quantity,
		@UsageTypeID=@UsageTypeID,
		@UsageCost=@UsageCost,
		@NumberOfPoints=@NumberOfPoints,
		@ChargePointComments=@ChargePointComments,
		@DateLastConfirmed=@DateLastConfirmed ,
		@StatusTypeID=@StatusTypeID,
		@DateLastStatusUpdate=@DateLastStatusUpdate

       FETCH NEXT FROM db_cursor INTO 
			@DataProvidersReference, @LocationTitle, @AddressLine1,  @AddressLine2, @Town, @StateOrProvince, 
			@Postcode, @CountryName, @Latitude, @Longitude,  @ContactTelephone1, @ContactTelephone2, @ContactEmail,
			@AccessComments, @LocationGeneralComments, @LocationRelatedURL, 
			@Connection1_TypeID, @Connection1_LevelID, @Connection1_Amps, @Connection1_Voltage, @Connection1_Quantity, 
			@Connection2_TypeID, @Connection2_LevelID, @Connection2_Amps, @Connection2_Voltage, @Connection2_Quantity, 
			@Connection3_TypeID, @Connection3_LevelID, @Connection3_Amps, @Connection3_Voltage, @Connection3_Quantity, 
			@Connection4_TypeID, @Connection4_LevelID, @Connection4_Amps, @Connection4_Voltage, @Connection4_Quantity, 
			@Connection5_TypeID, @Connection5_LevelID, @Connection5_Amps, @Connection5_Voltage, @Connection5_Quantity, 
			@UsageTypeID, @UsageCost, @NumberOfPoints, @GeneralComments, @DateLastConfirmed, @StatusTypeID,@DateLastStatusUpdate

END   

CLOSE db_cursor   
DEALLOCATE db_cursor


--cleanup empty items
DELETE FROM dbo.ChargePoint WHERE AddressInfoID IN(
	SELECT ID FROM dbo.AddressInfo WHERE Title IS NULL
)

DELETE FROM dbo.AddressInfo WHERE Title IS NULL

COMMIT TRANSACTION

GO
