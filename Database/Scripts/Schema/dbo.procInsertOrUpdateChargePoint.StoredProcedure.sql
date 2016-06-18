USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[procInsertOrUpdateChargePoint]
(
	@DataProviderID INT,
	@DataProvidersReference nvarchar(100),
	@OperatorID int, 
	@OperatorsReference nvarchar(100),
	@LocationTitle nvarchar(100),
	@AddressLine1 nvarchar(1000) = NULL,
	@AddressLine2 nvarchar(1000) = NULL,
	@Town nvarchar(100) = NULL,
	@StateOrProvince NVARCHAR(100) = NULL,
	@Postcode nvarchar(100) = NULL,
	@CountryID int = NULL,
	@Latitude float = NULL,
	@Longitude float = NULL,
	@AccessComments nvarchar(max) = NULL,
	@ContactTelephone1 NVARCHAR(200) = NULL,
	@ContactTelephone2 NVARCHAR(200) = NULL,
	@ContactEmail NVARCHAR(255) = NULL,
	@LocationGeneralComments nvarchar(max) = NULL,
	@LocationRelatedURL nvarchar(500) = NULL,
	@Connection1_TypeID int =NULL, @Connection1_LevelID int =NULL, @Connection1_Amps int =NULL,@Connection1_Voltage int = NULL, @Connection1_Quantity int = NULL,
	@Connection2_TypeID int =NULL, @Connection2_LevelID int =NULL, @Connection2_Amps int =NULL,@Connection2_Voltage int = NULL, @Connection2_Quantity int = NULL,
	@Connection3_TypeID int =NULL, @Connection3_LevelID int =NULL, @Connection3_Amps int =NULL,@Connection3_Voltage int = NULL, @Connection3_Quantity int = NULL,
	@Connection4_TypeID int =NULL, @Connection4_LevelID int =NULL, @Connection4_Amps int =NULL,@Connection4_Voltage int = NULL, @Connection4_Quantity int = NULL,
	@Connection5_TypeID int =NULL, @Connection5_LevelID int =NULL, @Connection5_Amps int =NULL,@Connection5_Voltage int = NULL, @Connection5_Quantity int = NULL,
	@UsageTypeID int =NULL,
	@UsageCost NVARCHAR(200) = NULL,
	@NumberOfPoints int =1,
	@ChargePointComments nvarchar(max) = NULL,
	@DateLastConfirmed smalldatetime = NULL,
	@DatePlanned smalldatetime = NULL,
	@StatusTypeID INT,
	@DateLastStatusUpdate smalldatetime = NULL,
	@AvoidDuplicateAddressInfo bit =1
)
AS

DECLARE @ChargePointID int

--check if charge point exists already based on Operator reference or DataProvider ref
SELECT @ChargePointID =ID FROM ChargePoint 
WHERE OperatorID=@OperatorID AND OperatorsReference=@OperatorsReference

IF @ChargePointID IS NULL BEGIN
	SELECT @ChargePointID =ID FROM ChargePoint 
	WHERE DataProviderID=@DataProviderID AND DataProvidersReference=@DataProvidersReference
END

--if chargepoint doesn't exist, add new charge point details
IF @ChargePointID IS NULL
BEGIN
	--add new charge point
	INSERT INTO ChargePoint(
		DataProviderID, DataProvidersReference, OperatorID, OperatorsReference,  
		UsageTypeID, UsageCost, AddressInfoID, NumberOfPoints, 
		GeneralComments, DatePlanned, DateLastConfirmed, StatusTypeID, DateLastStatusUpdate, DateCreated, SubmissionStatusTypeID)
	VALUES (
		@DataProviderID, @DataProvidersReference, @OperatorID, @OperatorsReference, 
		@UsageTypeID, @UsageCost, NULL, @NumberOfPoints, 
		@ChargePointComments, @DatePlanned, @DateLastConfirmed, @StatusTypeID, @DateLastStatusUpdate, GETDATE(), 100 --imported and published
	)
	
	SET @ChargePointID=SCOPE_IDENTITY()
	
	--connection 1
	EXEC dbo.procInsertConnectionInfo 
		@ChargePointID, 
		@Connection1_TypeID, @Connection1_LevelID, @Connection1_Amps, @Connection1_Voltage, @Connection1_Quantity, 
		@Reference=NULL, @StatusTypeID=NULL
	
	--connection 2
	EXEC dbo.procInsertConnectionInfo 
		@ChargePointID, 
		@Connection2_TypeID, @Connection2_LevelID, @Connection2_Amps, @Connection2_Voltage, @Connection2_Quantity, 
		@Reference=NULL, @StatusTypeID=NULL
		
	--connection 3
		EXEC dbo.procInsertConnectionInfo 
		@ChargePointID, 
		@Connection3_TypeID, @Connection3_LevelID, @Connection3_Amps, @Connection3_Voltage, @Connection3_Quantity, 
		@Reference=NULL, @StatusTypeID=NULL
		
	--connection 4
		EXEC dbo.procInsertConnectionInfo 
		@ChargePointID, 
		@Connection4_TypeID, @Connection4_LevelID, @Connection4_Amps, @Connection4_Voltage, @Connection4_Quantity, 
		@Reference=NULL, @StatusTypeID=NULL
	
	--connection 5
		EXEC dbo.procInsertConnectionInfo 
		@ChargePointID, 
		@Connection5_TypeID, @Connection5_LevelID, @Connection5_Amps, @Connection5_Voltage, @Connection5_Quantity, 
		@Reference=NULL, @StatusTypeID=NULL

END
ELSE
BEGIN
	--update existing charge point
	UPDATE ChargePoint
	SET 
		UsageTypeID =@UsageTypeID,
		NumberOfPoints= @NumberOfPoints,
		GeneralComments= @ChargePointComments,
		DateLastConfirmed=@DateLastConfirmed,
		DatePlanned = @DatePlanned,
		DataProviderID = @DataProviderID,
		DataProvidersReference = @DataProvidersReference,
		OperatorID = @OperatorID,
		OperatorsReference = @OperatorsReference,
		StatusTypeID =@StatusTypeID,
		DateLastStatusUpdate =@DateLastStatusUpdate,
		SubmissionStatusTypeID=100 --imported and published
	WHERE ID=@ChargePointID
END

--perform insert/update of charge point address info
DECLARE @AddressInfoID int
	
SELECT @AddressInfoID=AddressInfoID FROM ChargePoint WHERE ID=@ChargePointID

IF @AddressInfoID IS NULL AND @AvoidDuplicateAddressInfo=1
BEGIN
	--attempt to match addressinfo to preexisting address based on lat/lon and title
	SELECT @AddressInfoID=ID FROM AddressInfo WHERE Title=@LocationTitle AND Latitude= @Latitude AND Longitude = @Longitude
	AND @Latitude IS NOT NULL AND @Longitude IS NOT NULL
END

IF (@AddressInfoID IS NOT NULL)
BEGIN
	--update address info for charge point
	UPDATE AddressInfo
	SET
		Title=@LocationTitle,
		AddressLine1= @AddressLine1, 
		AddressLine2 =@AddressLine2, 
		Town= @Town, 
		StateOrProvince=@StateOrProvince,
		Postcode=@Postcode, 
		CountryID= @CountryID, 
		Latitude= @Latitude, 
		Longitude = @Longitude, 
		AccessComments=@AccessComments,
		GeneralComments= @LocationGeneralComments,
		RelatedURL= @LocationRelatedURL,
		ContactTelephone1 = @ContactTelephone1,
		ContactTelephone2 = @ContactTelephone2,
		ContactEmail = @ContactEmail 
	WHERE ID=@AddressInfoID
	
	UPDATE ChargePoint SET AddressInfoID=@AddressInfoID
	WHERE ID=@ChargePointID
END
ELSE
BEGIN
	--add address info for charge point
	INSERT INTO AddressInfo(Title, AddressLine1, AddressLine2, Town, StateOrProvince, Postcode, CountryID, Latitude, Longitude, ContactTelephone1,ContactTelephone2, ContactEmail, AccessComments, GeneralComments, RelatedURL)
	VALUES (@LocationTitle, @AddressLine1, @AddressLine2, @Town, @StateOrProvince, @Postcode, @CountryID, @Latitude, @Longitude, @ContactTelephone1, @ContactTelephone2, @ContactEmail, @AccessComments, @LocationGeneralComments, @LocationRelatedURL)
	
	SET @AddressInfoID=SCOPE_IDENTITY()
	
	UPDATE ChargePoint SET AddressInfoID=@AddressInfoID
	WHERE ID=@ChargePointID
END

GO
