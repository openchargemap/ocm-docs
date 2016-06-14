Data Model Migration
--------------------


Current Model (API V2):
```json
[
  {
    "ID": 18321,
    "UUID": "C741AA0E-8660-4CD6-B00E-7EB23ECC7CAF",
    "ParentChargePointID": null,
    "DataProviderID": 1,
    "DataProvider": {
      //...optional reference data
    },
    "DataProvidersReference": null,
    "OperatorID": 20,
    "OperatorInfo": {
      //Optional OperatorInfo reference data
    },
    "OperatorsReference": "50585",
    "UsageTypeID": 4,
    "UsageType": {
     //Optional UsageType reference data
    },
    "UsageCost": "Free",
    "AddressInfo": {
      "ID": 18666,
      "Title": "Gallowgate Car Park",
      "AddressLine1": "Gallowgate",
      "AddressLine2": null,
      "Town": "Aberdeen",
      "StateOrProvince": null,
      "Postcode": "AB10 1LU",
      "CountryID": 1,
      "Country": {
        //Optional Country reference data 
      },
      "Latitude": 57.15087,
      "Longitude": -2.0984,
      "ContactTelephone1": "01224 346952",
      "ContactTelephone2": null,
      "ContactEmail": null,
      "AccessComments": "Twin 7kW unit is to left as you enter, rapid charger is next to the exit (opposite the location of the 7kW unit)",
      "RelatedURL": null,
      "Distance": null,
      "DistanceUnit": 0
    },
    "NumberOfPoints": 4,
    "GeneralComments": "Free to use, but parking charges apply. APT Evolt rapid charger.",
    "DatePlanned": null,
    "DateLastConfirmed": null,
    "StatusTypeID": 50,
    "StatusType": {
     //Optional
    },
    "DateLastStatusUpdate": "2016-06-10T20:14:00Z",
    "DataQualityLevel": 1,
    "DateCreated": "2013-07-17T07:26:00Z",
    "SubmissionStatusTypeID": 200,
    "SubmissionStatus": {
      //optional SubmissionStatus reference data
    },
    "MetadataValues": null,
    "IsRecentlyVerified": true,
    "DateLastVerified": "2016-05-03T08:29:27.263Z"
  }
]
```

Optional Property expansions turn reference data IDs into full reference data:
```json
"DataProvider": {
      "WebsiteURL": "http://openchargemap.org",
      "Comments": null,
      "DataProviderStatusType": {
        "IsProviderEnabled": true,
        "ID": 1,
        "Title": "Manual Data Entry"
      },
      "IsRestrictedEdit": false,
      "IsOpenDataLicensed": true,
      "IsApprovedImport": true,
      "License": "Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)",
      "DateLastImported": null,
      "ID": 1,
      "Title": "Open Charge Map Contributors"
    }
```

```json
"OperatorInfo": {
      "WebsiteURL": "http://www.chargeyourcar.org.uk/",
      "Comments": null,
      "PhonePrimaryContact": "0191 26 50 500",
      "PhoneSecondaryContact": null,
      "IsPrivateIndividual": false,
      "AddressInfo": null,
      "BookingURL": null,
      "ContactEmail": "admin@chargeyourcar.org.uk",
      "FaultReportEmail": "admin@chargeyourcar.org.uk",
      "IsRestrictedEdit": false,
      "ID": 20,
      "Title": "Charge Your Car"
    }
```

```json
"UsageType": {
      "IsPayAtLocation": false,
      "IsMembershipRequired": true,
      "IsAccessKeyRequired": true,
      "ID": 4,
      "Title": "Public - Membership Required"
    }
```
```json
"Country": {
        "ISOCode": "GB",
        "ContinentCode": "EU",
        "ID": 1,
        "Title": "United Kingdom"
      }
```

```json
"SubmissionStatus": {
      "IsLive": true,
      "ID": 200,
      "Title": "Submission Published"
    }
```
```json
"StatusType": {
      "IsOperational": true,
      "IsUserSelectable": true,
      "ID": 50,
      "Title": "Operational"
    }
```


Changes;
Station
    - Primary Network Operator
        - Additional Network Operators
    - Usage type
    - ConnectionInfo
        - equipmentt
            - status (current + history)
