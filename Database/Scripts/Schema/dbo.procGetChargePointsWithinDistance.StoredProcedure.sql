USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 CREATE PROCEDURE [dbo].[procGetChargePointsWithinDistance]
 (
   @Latitude decimal(18,14) = 57.143187,
   @Longtitude decimal(18,14) = -2.095063,
   @DistanceUnit varchar(10) = 'KM', --KM or Miles
   @MaxDistance decimal(18,14) = NULL
 )
 AS
 	SET NOCOUNT ON;
 	
	DECLARE @ConversionFactor decimal(18,14) = 1;
	IF @DistanceUnit='Miles' SET @ConversionFactor  = 0.000621371192;
	IF @MaxDistance>0 SET @MaxDistance=@MaxDistance*@ConversionFactor;
	
	-- @p1 is the point you want to calculate the distance from which is passed as parameters
	DECLARE @sourceLocation geography = geography::Point(@latitude,@longtitude, 4326);

	SELECT 
		DISTINCT ChargePoint.ID, 
		DistanceInKilometers AS Distance,
		@DistanceUnit AS DistanceUnit
	FROM
	dbo.ChargePoint 
	INNER JOIN  (
		SELECT 
			ID, 
			@sourceLocation.STDistance(geography::Point(adr.Latitude, adr.Longitude, 4326))/1000 as [DistanceInKilometers]
		FROM 
			AddressInfo adr
		WHERE 
			adr.Latitude IS NOT NULL AND adr.Longitude IS NOT NULL
	) AdInfo 
	ON ChargePoint.AddressInfoID=AdInfo.ID
	WHERE @MaxDistance IS NULL OR (@MaxDistance IS NOT NULL AND (DistanceInKilometers*@ConversionFactor) <=@MaxDistance)
	ORDER BY 2
	

GO
