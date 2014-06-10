--check distance of every address vs every other address, compile list of thoseclose to each other

--select * from DataProvider
DECLARE  @DupeList TABLE(ID1 int, ID2 int, Distance float)


INSERT INTO @DupeList (Id1,Id2,distance)
select top 1000
cp1.ID, cp2.ID,
	ad1.SpatialPosition.STDistance(ad2.SpatialPosition) Distance
from AddressInfo ad1
	INNER JOIN AddressInfo ad2 ON ad1.ID!=ad2.ID and ad1.CountryID=ad2.CountryID AND ad1.SpatialPosition.STDistance(ad2.SpatialPosition)<100 
	INNER JOIN ChargePoint cp1 on cp1.AddressInfoID=ad1.ID and cp1.SubmissionStatusTypeID IN (100,200)
	INNER JOIN ChargePoint cp2 on cp2.AddressInfoID=ad2.ID and cp2.SubmissionStatusTypeID IN (100,200)
WHERE 
	ad1.CountryID=2 and ad2.CountryID=2
	and cp1.DataProviderID=2
	
	
	
DELETE FROM @DupeList where ID1 IN(select ChargePointID FROM UserComment) OR ID1 IN (SELECT ChargePointID FROM MediaItem)
DELETE FROM @DupeList WHERE ID2 IN (SELECT ID1 FROM @DupeList) AND ID2>ID1 -- remove the higher of the duplicates from the dupe list
	
	SELECT * FROM ViewAllLocations WHERE ID IN(SELECT ID1 from @DupeList)

	UPDATE ChargePoint SET SubmissionStatusTypeID=1001 WHERE ID IN (SELECT ID1 FROM @DupeList)