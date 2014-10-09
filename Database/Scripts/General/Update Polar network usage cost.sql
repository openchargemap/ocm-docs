--select * from ViewAllLocations WHERE Operator like '%polar%' or Operator like '%chargemaster%'
--or exists (select 1 from UserComment WHERE Comment like '%polar%')

--change all uk chargemaster points to Polar
UPDATE ChargePoint SET OperatorID = 32 WHERE OperatorID=8
AND AddressInfoID IN (select ID from AddressInfo WHERE CountryID=1)

--set all polar to Public membership required
UPDATE ChargePoint SET UsageTypeID=4 WHERE UsageTypeID=0 AND OperatorID=32

UPDATE ChargePoint SET UsageCost='POLAR Standard Fees May Apply' WHERE OperatorID=32-- AND (UsageCost IS NULL OR UsageCost='Free' OR RTRIM(UsageCost)='')

UPDATE ChargePoint SET UsageCost='Free, POLAR Card Required' WHERE OperatorID=32
AND AddressInfoID IN (SELECT ID FROM AddressInfo where AddressInfo.Title like '%asda%' OR AddressInfo.Title LIKE '%waitrose%')

--
select UsageType.ID, UsageType.Title,AddressInfo.Title, AddressInfo.AddressLine1,* from ChargePoint
LEFT JOIN UsageType ON UsageType.ID=ChargePoint.UsageTypeID
LEFT JOIN AddressInfo ON AddressInfo.ID=ChargePoint.AddressInfoID
where OperatorID=32
AND (AddressInfo.Title like '%asda%' OR AddressInfo.Title LIKE '%waitrose%')

