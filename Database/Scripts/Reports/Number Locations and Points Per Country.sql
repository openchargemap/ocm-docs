SELECT 
	COUNT(1) AS NumLocations, 
	SUM(CASE WHEN NumberOfPoints=0 THEN 1 ELSE ISNULL(NumberOfPoints,1) END)  as NumPoints, 
	SUM(TmpConnections.NumConnections) as NumConnections,
	Country.Title as Country 
FROM ChargePoint 
INNER JOIN AddressInfo ON AddressInfo.ID=ChargePoint.AddressInfoID
INNER JOIN Country ON Country.ID=AddressInfo.CountryID
INNER JOIN SubmissionStatusType ON SubmissionStatusType.ID=ChargePoint.SubmissionStatusTypeID
LEFT JOIN 
(
	SELECT SUM(CASE WHEN Quantity=0 THEN 1 ELSE ISNULL(Quantity,1) END) as NumConnections, 
	ChargePointID FROM ConnectionInfo GROUP BY ChargePointID) as TmpConnections
ON TmpConnections.ChargePointID=ChargePoint.ID
WHERE SubmissionStatusType.IsLive=1
GROUP BY Country.Title
ORDER BY NumLocations DESC




