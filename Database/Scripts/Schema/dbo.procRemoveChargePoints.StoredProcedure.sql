USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procRemoveChargePoints]
(
	@OperatorID INT = NULL,
	@DataProviderID INT = NULL
)
AS

DECLARE @PointList TABLE (ChargePointID int)

IF @OperatorID IS NOT NULL
BEGIN
	--remove list of points by operator id
	INSERT INTO @PointList (ChargePointID)
	SELECT ID FROM ChargePoint WHERE OperatorID=@OperatorID
END

IF @DataProviderID IS NOT NULL
BEGIN
	--remove list of points by provider id
	INSERT INTO @PointList (ChargePointID)
	SELECT ID FROM ChargePoint WHERE DataProviderID=@DataProviderID
END

--remove associated info

DELETE FROM ConnectionInfo WHERE ChargePointID IN (SELECT ChargePointID FROM @PointList)
DELETE FROM UserComment  WHERE ChargePointID IN (SELECT ChargePointID FROM @PointList)
DELETE FROM MediaItem WHERE ChargePointID IN (SELECT ChargePointID FROM @PointList)
DELETE FROM MetadataValue WHERE ChargePointID IN (SELECT ChargePointID FROM @PointList)

--remove charge points
UPDATE ChargePoint SET ParentChargePointID=NULL WHERE ParentChargePointID IN(SELECT ChargePointID FROM @PointList)
DELETE FROM ChargePoint WHERE ID IN(SELECT ChargePointID FROM @PointList)

--remove unused addresses
DECLARE @UsedAddresses TABLE (AddressInfoID INT)
INSERT INTO @UsedAddresses
SELECT AddressInfoID FROM ChargePoint
UNION ALL
SELECT AddressInfoID FROM Operator;

DELETE FROM AddressInfo WHERE NOT EXISTS (SELECT AddressInfoID FROM @UsedAddresses WHERE AddressInfoID=ID)

--procRemoveChargePoints @DataProviderID=1
--procRemoveChargePoints @OperatorID=4
--procRemoveChargePoints @OperatorID=1

GO
