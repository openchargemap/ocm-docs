USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procDeduplicateAddressInfo]
 (
	@MasterAddressInfoID int, --ID of address info to use as master and replace any close duplicates,
	@PerformDeduplication bit =0
 )
 AS
 
 /*
 --find duplicates
 SELECT COUNT(*), Title FROM dbo.AddressInfo
 GROUP BY Title
 HAVING COUNT(*)>=2
 
 --examine dups
 SELECT * FROM dbo.AddressInfo WHERE Title='Ancira Nissan'
 
 --merge duplicates
 EXEC procDeduplicateAddressInfo @MasterAddressInfoID=3401, @PerformDeduplication=0
 
 */
 
 
 DECLARE @DupList TABLE (AddressInfoID INT)
 
 INSERT INTO @DupList(AddressInfoID)
 SELECT 
	a.ID 
 FROM 
	AddressInfo a 
	INNER JOIN dbo.AddressInfo m ON a.Title=m.Title AND a.Latitude=m.Latitude AND a.Longitude=m.Longitude
 WHERE m.ID=@MasterAddressInfoID AND a.ID!=@MasterAddressInfoID
 
 IF @PerformDeduplication=1 
 BEGIN
	PRINT 'Deduplicating based on '+CONVERT(VARCHAR(10),@MasterAddressInfoID)
	
	--update charge points
	UPDATE ChargePoint SET AddressInfoID=@MasterAddressInfoID
	WHERE AddressInfoID IN (SELECT AddressInfoID FROM @DupList)
	
	--update operator info
	UPDATE Operator SET AddressInfoID=@MasterAddressInfoID
	WHERE AddressInfoID IN (SELECT AddressInfoID FROM @DupList)
	
	--remove duplicate addresses
	DELETE FROM AddressInfo WHERE ID IN (SELECT AddressInfoID FROM @DupList)
 END
 ELSE
 BEGIN
	PRINT 'Deduplicating would remove the following based on '+CONVERT(VARCHAR(10),@MasterAddressInfoID)
	
	SELECT * FROM AddressInfo WHERE ID IN (SELECT AddressInfoID FROM @DupList)
	SELECT * FROM ChargePoint WHERE AddressInfoID IN (SELECT AddressInfoID FROM @DupList) OR dbo.ChargePoint.AddressInfoID=@MasterAddressInfoID
 END
 

GO
