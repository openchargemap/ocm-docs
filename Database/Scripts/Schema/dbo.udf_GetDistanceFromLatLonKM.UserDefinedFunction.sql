USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_GetDistanceFromLatLonKM]
    (
      @Latitude1 FLOAT ,
      @Longitude1 FLOAT ,
      @Latitude2 FLOAT ,
      @Longitude2 FLOAT
    )
RETURNS FLOAT
AS 
    BEGIN
        DECLARE @distanceKM FLOAT ;
        IF @Latitude1 IS NULL OR @Longitude1 IS NULL OR @Latitude2 IS NULL OR @Longitude2 IS NULL RETURN NULL
        
        DECLARE @sourceLocation GEOGRAPHY = GEOGRAPHY::Point(@Latitude1,@Longitude1, 4326) ;

        SELECT  @distanceKM = @sourceLocation.STDistance(GEOGRAPHY::Point(@Latitude2, @Longitude2, 4326))/1000; 
        RETURN @distanceKM ;
    END
GO
