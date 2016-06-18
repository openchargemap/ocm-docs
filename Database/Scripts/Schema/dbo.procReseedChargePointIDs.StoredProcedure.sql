USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procReseedChargePointIDs]
AS
--reseed to max id, to avoid holes in IDs after multiple import attempts
DECLARE @CurrentMaxID int
SELECT @CurrentMaxID=ISNULL(MAX(ID),1) FROM ChargePoint
IF @CurrentMaxID IS NOT NULL
BEGIN
	DBCC CHECKIDENT (ChargePoint, RESEED, @CurrentMaxID)
END
GO
