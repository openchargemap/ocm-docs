SELECT COUNT(1) as NumberOfPOIs, 
	DataProvider.ID as DataProviderID,
	DataProvider.Title,
	DataProvider.IsOpenDataLicensed,
	DataProvider.License
FROM ChargePoint inner join DataProvider ON DataProvider.ID=ChargePoint.DataProviderID
where SubmissionStatusTypeID IN (100,200)

group by DataProvider.ID,DataProvider.title, 	DataProvider.IsOpenDataLicensed, DataProvider.License

