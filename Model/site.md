
**OCM Site Data Model**


## 1. Summary

The Site model defines a group of one or more EVSE (Electric Vehilce Supply Equipment) present in a geographic location. 

The purpose of this information is to:
- Provide electric vehicle drivers with information to plan their immediate and future journeys.
- Provide data for statistical analysis regarding public EVSE infrastructure currently available globally.

A Site (aka ChargePoint in prior model versions) comprises:
- Summary level information about a site [Mandatory]
- An AddressInfo object (representing the Geographic location of the site) [Mandatory]
- A list of ConnectionInfo objects (equipment summary information) [Mandatory] may be generated from EVSE information or manually populated
- A list of EVSE objects [Optional]: Distinct charging stations present at the site comprising:
	- Specific information on the primary Network Operator
	- The network operators reference for this EVSE
	- Overall Status for the unit.
	- A list of ConnectionInfo objects detailing the exact specification of the unit outputs.

For the purposes of this specification:
- An EVSE is defined as a unit of equipment, having an overall operational status, which is capable of providing a charging connection to one or more vehicles. The device may offer multiple connection Ports which may at any given time have an operational status independent of each other. The unit as a whole may be considered operational whilst one or more of it's connection ports are out of service.
- If communication with an EVSE has failed, the last known operational status of connection ports will be considered current and the overall status of the unit will reflect

## 2. Open Charge Map API Data Model V4.0-alpha

### 2.1 _Site_ Object

The *Site* object provides summary level information about a charging site with a group of EVSE present. 

All fields should be treated as nullable and optional until otherwise specified.

| Field		                        | Data Type		        | Description                                                                           |
|-----------------------------------|-----------------------|---------------------------------------------------------------------------------------|
| ID                                | integer           	| Unique ID for this Site in the Open Charge Map registry. 	|
| UUID                           	| string		       	| Additional globally unique identifier for further disambiguation. |
| ParentChargePointID               | integer				| Parent item this data is derived from.                                       			|
| DataProviderID                    | integer               | OCM Data Provider ID for this information            |
| DataProvidersReference            | integer               | Data Providers own reference for this site   |
| GeneralComments                   | string               	| Comment for guidance relating to general usage |
| DateLastConfirmed                 | datetime              | Date last confirmed correct by a user. |
| DataQualityLevel                  | integer               | Automated Data Quality score |
| DateCreated                    	| datetime              | Date site information was added |
| DateLastVerified                  | datetime              | Date information was last confirmed accurate by an OCM user        |
| DateModified                  	| datetime              | Date this site or any related info was last updated        |
| SubmissionStatusTypeID            | integer               | OCM Submission Status Type ID           |
| EquipmentSummary                  | EquipmentSummary      | Deprecated summary level information. Superceded by SupplyEquipment info where available and may be computed from SupplyEquipment information for compatibility.|
| SupplyEquipment                   | SupplyEquipment (list)| Details of EVSE present at site, with specific addressable connector information |
| MetadataValues                    | MetadataValue (list) 	| Optional list of Metadata Values providing extended information     |


#### Example
```json
  {
    "ID": 9797,
    "UUID": "0B28C975-E15E-410C-B553-0D78C2734795",
    "ParentChargePointID": null,
    "DataProviderID": 1,
    "DataProvidersReference": null,
    "GeneralComments": null,
    "DataQualityLevel": 1,
    "DateCreated": "2012-04-17T09:36:00Z",
	"DateModified": "2016-06-24T18:40:01.75Z",
	"DateLastVerified": "2016-06-24T18:40:01.75Z",
    "SubmissionStatusTypeID": 200,
		"SupplyEquipment":[
		{
			"OperatorID": 1234,
			"OperatorsReference":"ABC1234",
			"Latitude": 123.4567,
			"Longitude": 56.73737,
			"Comments": "Upper level parking",
			"Status": {
						"StatusTypeID": 50,
						"DateLastStatusUpdate":"2016-06-24T18:40:01.75Z",
						"IsAutomatedStatus": true
					},
			"ConnectionInfo" : [
				{
					"ID": 7630,
					"ConnectionTypeID": 3,     
					"IsTethered": true,   
					"Reference": "1",
					"StatusTypeID": 50,          
					"Amps": 13,
					"Voltage": 230,
					"PowerKW": 2.4,
					"CurrentTypeID": 10,
					"Comments": null,
					"Status": {
						"StatusTypeID": 50,
						"DateLastStatusUpdate":"2016-06-24T18:40:01.75Z",
						"IsAutomatedStatus": true
					}
				},
				{
					"ID": 7631,
					"ConnectionTypeID": 25,
					"IsTethered": true,
					"Reference": "2",
					"Amps": 32,
					"Voltage": 230,
					"PowerKW": 7.0,
					"CurrentTypeID": 10,   
					"Quantity": 1,
					"Comments": null,
					"Status": {
						"StatusTypeID": 50,
						"DateLastStatusUpdate":"2016-06-24T18:40:01.75Z",
						"IsAutomatedStatus": true
					}
				}
			]
		}
	],
    "EquipmentSummary":{ 

		//deprecated approximate summary info. 
		//To be superceded by Supply Equipment, may be computed 
		//by summarising SupplyEquipment

		"OperatorID": 19, 
		"UsageTypeID": 1, 
		"UsageCost": "Free",
		"NumberOfPoints": 2,
 		"StatusTypeID": 50,
    	"DateLastStatusUpdate": "2016-06-25T20:52:00Z",
		"DateLastConfirmed": null,
		"ConnectionInfo":	 [
			{
				"ID": 7630,
				"ConnectionTypeID": 3,
				"StatusTypeID": 50,
				"LevelID": 2,
				"Amps": 13,
				"Voltage": 230,
				"PowerKW": null,
				"CurrentTypeID": null,
				"Quantity": 1,
				"Comments": null
			},
			{
				"ID": 7631,
				"ConnectionTypeID": 25,
				"StatusTypeID": 50,
				"LevelID": 2,
				"Amps": 32,
				"Voltage": 230,
				"PowerKW": 7.0,
				"CurrentTypeID": 10,
				"Quantity": 1,
				"Comments": null
			}
		]
	},
    "MetadataValues": null
  }
]
```
# SupplyEquipment *class*
A SupplyEquipment object specifies information about a specific addressable physical EVSE. present on a Site. Position information should be "ground truth" physically collected with a GPS enabled device to a within a resolution of a few meters:

| Field		                        | Data Type		        | Description                                                                           |
|-----------------------------------|-----------------------|---------------------------------------------------------------------------------------|
| ID                                | integer           	| Unique ID for this EVSE in the Open Charge Map registry. 	|
| OperatorID                 		| integer		       	| OCM ID for this Operator |
| OperatorsReference                | string           		| Operators own reference for this equipment/unit	|
| PhysicalTag                		| string           		| Uniqueu Identifier tag/number visible on device (if different to Operators Reference)	|
| Latitude                         	| float		       		| Latitude of physical location |
| Longitude                         | float		       		| Longitude of physical location |
| Comments                          | string		       	| General usage or access notes |
| Status                          	| Status		       	| Overall unit operational status |

# ConnectionInfo *reference data class*
A ConnectionInfo object specifies information about a specific addressable physical EVSE connection (a.k.a Port) present on an EVSE and it's associated output power specifications:

| Field		                        | Data Type		        | Description                                                                           |
|-----------------------------------|-----------------------|---------------------------------------------------------------------------------------|
| ID                                | integer           	| Unique ID for this Connection in the Open Charge Map registry. 	|
| ConnectionTypeID                 	| integer		       	| OCM ID for this ConnectionType |
| IsTethered                        | boolean           	| True if connection has a fixed cable, false if the user is expected to plug in their own cable/adaptor	|
| Reference                         | string		       	| Ooperators reference for this connection/port |
| Status	                        | Status           		| Connection/Port Status information	|
| Amps                              | integer           	| Max. operational output Amperage for charging	|
| Voltage                           | integer		       	| Max. operational output Voltage for charging |
| PowerKW                           | float         	  	| Max. operational output Power in kilowatts for charging 	|
| CurrentTypeID                     | integer		       	| OCM ID of the CurrentType (output supply type e.g. Single-Phase AC, DC etc) |


```json 
{
	"ID": 7630,
	"ConnectionTypeID": 3,     
	"IsTethered": true,   
	"Reference": "1",
	"StatusTypeID": 50,          
	"Amps": 13,
	"Voltage": 230,
	"PowerKW": 2.4,
	"CurrentTypeID": 10,
	"Comments": null,
	"Status": {
		"StatusTypeID": 50,
		"DateLastStatusUpdate":"2016-06-24T18:40:01.75Z",
		"IsAutomatedStatus": true
	}
}
```
# TODO:
- Status Information per Connection:
	- Overall current status
	- Projected status at a given date
		- Based on historical availability, scheduled availablity, current status
- Availability Times (per evse)
	- Include notes of when reserved?


# /status/?siteid=1234
```json
{
	"SiteID":1234,
	"SupplyEquipment":[
		{
			"OperatorID": 1234,
			"OperatorsReference":"ABC1234",
			"Latitude": 123.4567,
			"Longitude": 56.73737,
			"Comments": "Upper level parking",
			"ConnectionInfo" : [
				{
					"ID": 7630,
					"ConnectionTypeID": 3,        
					"Reference": "1",
					"StatusTypeID": 50,      
					"LevelID": 2,       
					"Amps": 13,
					"Voltage": 230,
					"PowerKW": 2.4,
					"CurrentTypeID": 10,
					"Comments": null
				},
				{
					"ID": 7631,
					"ConnectionTypeID": 25,
					"Reference": "2",
					"StatusTypeID": 50,
					"LevelID": 2,
					"Amps": 32,
					"Voltage": 230,
					"PowerKW": 7.0,
					"CurrentTypeID": 10,   
					"Quantity": 1,
					"Comments": null
				}
			]
		}
	]
}
```

# ConnectionType *reference data class*

| Field		                        | Data Type		        | Description                                                                           |
|-----------------------------------|-----------------------|---------------------------------------------------------------------------------------|
| ID                                | integer           	| Unique ID for this Connection Type in the Open Charge Map registry. 					|
| Title                           	| string		       	| Common name for this connection type. |
| Formal Name               		| string				| Official title for this type of connection                                    	|

```json
 "ConnectionType": {
          "ID": 3,
          "Title": "BS1363 3 Pin 13 Amp",
		  "FormalName": "BS1363 / Type G",
          "IsDiscontinued": false,
          "IsObsolete": false
        },
```

```json
 "StatusType": {
          "IsOperational": true,
          "IsUserSelectable": true,
          "ID": 50,
          "Title": "Operational"
        },
```
```json
  "Level": {
          "Comments": "Over 2 kW, usually non-domestic socket type",
          "IsFastChargeCapable": false,
          "ID": 2,
          "Title": "Level 2 : Medium (Over 2kW)"
        },
```

```json
 "CurrentType": {
          "Description": "Alternating Current - Single Phase",
          "ID": 10,
          "Title": "AC (Single-Phase)"
        },
```
### x.x AddressInfo *class*
```json
{
      "ID": 9694,
      "Title": "Centre for Alternative Technology",
      "AddressLine1": "Llwyngwern Quarry",
      "AddressLine2": "Pantperthog",
      "Town": "Machynlleth",
      "StateOrProvince": "Powys",
      "Postcode": "SY20 9AZ",
      "CountryID": 1,
      "Latitude": 52.624063643991583,
      "Longitude": -3.8384196759185407,
      "ContactTelephone1": "01654 705950",
      "ContactTelephone2": null,
      "ContactEmail": "info@cat.org.uk",
      "AccessComments": "Charging availability Mon to Sun 10.00 to 17.30",
      "RelatedURL": "http://www.cat.org.uk",
      "Distance": null,
      "DistanceUnit": 0
    }
```

### x.x Country *class*
```json
{
        "ID": 1,
        "Title": "United Kingdom",
		"ISOCode": "GB",
        "ContinentCode": "EU"
}
```

### x.x SubmissionStatus *class*
```json
{     
      "ID": 200,
      "Title": "Submission Published",
	  "IsLive": true
    }
```

### x.x StatusType *class*
```json
{
	  "ID": 50,
      "Title": "Operational",
      "IsOperational": true,
      "IsUserSelectable": true     
}
```
### x.x UsageType *class*
``` 
{
	  "ID": 1,
      "Title": "Public",
      "IsPayAtLocation": null,
      "IsMembershipRequired": null,
      "IsAccessKeyRequired": null
    }
	```

### x.x OperatorInfo *class*

```json
{
      "ID": 19,
      "Title": "Zero Carbon World",
	  "WebsiteURL": "http://zerocarbonworld.org/",
      "Comments": "UK Charity promoting carbon reduction",
      "PhonePrimaryContact": null,
      "PhoneSecondaryContact": null,
      "IsPrivateIndividual": false,
      "AddressInfo": null,
      "BookingURL": null,
      "ContactEmail": "info@zerocarbonworld.com",
      "FaultReportEmail": "info@zerocarbonworld.com",
      "IsRestrictedEdit": null
}
```
### x.x DataProvider *class*
```json
 {
	  "ID": 1,
      "Title": "Open Charge Map Contributors",
      "WebsiteURL": "http://openchargemap.org",
      "Comments": null,
      "DataProviderStatusTypeID": 1,
      "IsRestrictedEdit": false,
      "IsOpenDataLicensed": true,
      "IsApprovedImport": true,
      "License": "Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)",
      "DateLastImported": null
    }
```

### x.x DataProviderStatusType *class*
```json
{
	
	"ID": 1,
	"Title": "Manual Data Entry",
	"IsProviderEnabled": true
	}
```

```json
 //UserComment
      {
        "ID": 11701,
        "ChargePointID": 9797,
        "CommentTypeID": 10,
       
        "UserName": "ro.",
        "Comment": "Charged using type 2 socket on ZCW post opposite disabled parking. I wonder if there is another post somewhere else or if it has moved as there were no wooden buildings nearby as seen in the previous photo.",
        "Rating": 5,
        "RelatedURL": null,
        "DateCreated": "2016-06-24T18:40:01.75Z",
        "User": {
          "ID": 9125,
          "Username": "ro.",
          "ReputationPoints": 17,
          "ProfileImageURL": "http://www.gravatar.com/avatar/23782416a5ee5d13013415d37cbb4b80?s=80&d=mm"
        },
        "CheckinStatusTypeID": 10,
        
      }
```
```json
 "CommentType": {
          "ID": 10,
          "Title": "General Comment"
        },
```
```json
"CheckinStatusType": {
          "IsPositive": true,
          "IsAutomatedCheckin": false,
          "ID": 10,
          "Title": "Charged Successfully"
        }
```

```json
//"MediaItems": [
      {
        "ID": 646,
        "ChargePointID": 9797,
        "ItemURL": "https://ocm.blob.core.windows.net/images/GB/OCM9797/OCM-9797.orig.2014092221510095.jpeg",
        "ItemThumbnailURL": "https://ocm.blob.core.windows.net/images/GB/OCM9797/OCM-9797.thmb.2014092221510095.jpeg",
        "Comment": "",
        "IsEnabled": true,
        "IsVideo": false,
        "IsFeaturedItem": false,
        "IsExternalResource": false,
        "MetadataValue": null,
        "User": {
          "ID": 2306,
          "Username": "TrystanLea",
          "ReputationPoints": 6,
          "ProfileImageURL": "http://www.gravatar.com/avatar/92ea3e67eb54ddea8a0abbee3b238076?s=80&d=mm"
        },
        "DateCreated": "2014-09-22T20:51:00Z"
      }

```