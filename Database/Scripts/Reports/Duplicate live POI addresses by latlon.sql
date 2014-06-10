select * from (
select poi1.ID as POI1, poi2.ID as POI2, DataProvider1.Title as DataProvider1, DataProvider2.Title as DataProvider2, 
a1.Title Title_A1,a2.Title Title_A2,a1.AddressLine1  A1_AddressLine1,a2.AddressLine1 A2_AddressLine1 , a1.CountryID as CountryA1, a2.CountryID as CountryA2
, 
(SELECT COUNT(1) FROM AddressInfo WHERE Latitude=a1.Latitude and Longitude=a1.Longitude) as POI1_Duplicates,
(SELECT COUNT(1) FROM UserComment WHERE ChargePointID=poi1.ID) as POI1_UserComments,
(SELECT COUNT(1) FROM UserComment WHERE ChargePointID=poi2.ID) as POI2_UserComments
from AddressInfo a1
INNER JOIN AddressInfo a2 ON a1.Latitude =a2.Latitude and a1.Longitude=a2.Longitude AND a1.ID!=a2.ID
INNER JOIN ChargePoint poi1 ON poi1.AddressInfoID=a1.ID AND poi1.SubmissionStatusTypeID in(100,200)
INNER JOIN ChargePoint poi2 ON poi2.AddressInfoID=a2.ID AND poi2.SubmissionStatusTypeID in(100,200)
INNER JOIN DataProvider DataProvider1 ON DataProvider1.ID=poi1.DataProviderID
INNER JOIN DataProvider DataProvider2 ON DataProvider2.ID=poi2.DataProviderID
where a1.CountryID=1
) dupePOI
where POI1_Duplicates>2
--and a1.title=a2.title
order by poi1

