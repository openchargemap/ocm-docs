
delete from ConnectionInfo WHERE ChargePointID IN (SELECT ID FROM  ChargePoint WHERE SubmissionStatusTypeID=1010)
delete from UserComment WHERE ChargePointID IN (SELECT ID FROM  ChargePoint WHERE SubmissionStatusTypeID=1010)
delete from MetadataValue WHERE ChargePointID IN (SELECT ID FROM  ChargePoint WHERE SubmissionStatusTypeID=1010)
delete from ChargePoint WHERE SubmissionStatusTypeID=1010

--clean up unused AddressInfo
DELETE from AddressInfo WHERE NOT EXISTS(SELECT AddressInfoID FROM ChargePoint WHERE AddressInfoID=AddressInfo.ID)