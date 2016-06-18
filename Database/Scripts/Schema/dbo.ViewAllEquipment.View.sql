USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[ViewAllEquipment]
AS
    SELECT  dbo.ChargePoint.ID ,
			dbo.DataProvider.ID as DataProviderID,
            dbo.DataProvider.Title AS DataProvider ,
            dbo.AddressInfo.Title AS LocationTitle ,
            dbo.AddressInfo.AddressLine1 ,
            dbo.AddressInfo.AddressLine2 ,
            dbo.AddressInfo.Town ,
            dbo.AddressInfo.StateOrProvince ,
            dbo.AddressInfo.Postcode ,
            dbo.AddressInfo.Latitude ,
            dbo.AddressInfo.Longitude ,
            dbo.AddressInfo.ContactTelephone1 ,
            dbo.AddressInfo.ContactTelephone2 ,
            dbo.AddressInfo.ContactEmail ,
            dbo.AddressInfo.AccessComments ,
            dbo.AddressInfo.GeneralComments ,
            dbo.AddressInfo.RelatedURL ,
            dbo.Country.ID as CountryID,
            dbo.Country.Title AS Country ,
            dbo.Country.ISOCode ,
            dbo.UsageType.Title AS Usage ,
            dbo.UsageType.IsPayAtLocation ,
            dbo.UsageType.IsMembershipRequired ,
            dbo.UsageType.IsAccessKeyRequired ,
            dbo.Operator.ID as OperatorID,
            dbo.Operator.Title AS Operator ,
            dbo.Operator.WebsiteURL ,
            dbo.Operator.Comments ,
            dbo.Operator.PhonePrimaryContact ,
            dbo.Operator.PhoneSecondaryContact ,
            dbo.Operator.IsPrivateIndividual ,
            dbo.Operator.BookingURL ,
            dbo.DataProvider.WebsiteURL AS DataProviderURL ,
            dbo.DataProvider.Comments AS DataProviderComments ,
            dbo.ChargePoint.DataProvidersReference ,
            dbo.ChargePoint.OperatorsReference ,
            dbo.ChargePoint.NumberOfPoints ,
            dbo.ChargePoint.GeneralComments AS EquipmentGeneralComments ,
            dbo.ChargePoint.DatePlanned ,
            dbo.ChargePoint.DateLastConfirmed ,
            dbo.ChargePoint.DateLastStatusUpdate ,
            dbo.ChargePoint.DataQualityLevel ,
            dbo.ChargePoint.DateCreated ,
            dbo.SubmissionStatusType.Title AS SubmissionStatus ,
            dbo.SubmissionStatusType.IsLive ,
            dbo.StatusType.Title AS EquipmentStatus ,
            dbo.StatusType.IsOperational,
            ct1.Title as Connection1_Type
    FROM    dbo.ChargePoint
            INNER JOIN dbo.AddressInfo ON dbo.ChargePoint.AddressInfoID = dbo.AddressInfo.ID
            LEFT JOIN dbo.Country ON dbo.AddressInfo.CountryID = dbo.Country.ID
            LEFT JOIN dbo.DataProvider ON dbo.ChargePoint.DataProviderID = dbo.DataProvider.ID
            LEFT JOIN dbo.Operator ON dbo.ChargePoint.OperatorID = dbo.Operator.ID
            LEFT JOIN dbo.UsageType ON dbo.ChargePoint.UsageTypeID = dbo.UsageType.ID
            LEFT JOIN dbo.StatusType ON dbo.ChargePoint.StatusTypeID = dbo.StatusType.ID
            LEFT JOIN dbo.SubmissionStatusType ON dbo.ChargePoint.SubmissionStatusTypeID = dbo.SubmissionStatusType.ID
            LEFT JOIN ConnectionInfo con1 on con1.ChargePointID=ChargePoint.ID
            LEFT JOIN ConnectionType ct1 on ct1.ID=con1.ConnectionTypeID




GO
