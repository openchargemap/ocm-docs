
select count(1) as numPOI, DataProvider.Title from ChargePoint inner join DataProvider ON DataProvider.ID=ChargePoint.DataProviderID
where SubmissionStatusTypeID IN (100,200)
--where DataProvider.DataProviderStatusTypeID not in(1,10,1000)
group by DataProvider.ID,DataProvider.title

