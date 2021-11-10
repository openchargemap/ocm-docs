## Getting Started with the Open Charge Map API
Our API is provide as a way for your work with Open Charge Map data and include the data in your apps a services. If you just want a simple way to show a map, consider [embedding](api.md) our map instead.

Use of the OCM API is subject to terms and conditions. By using the API you indicate acceptance of these terms.

If you wish to export charging location data into your own systems or applications the most flexible way is to use our API, which provides an export in a variety of formats. If you wish to regularly refresh the entire dataset, please clone our data from GitHub. You can also opt to run your own private API mirror.

## Fair Usage Policy
The basic API is provided as a free service with no warranty or service level agreement. Providing this API to you costs us actual money for server resources and data transfer fees.

If you will be calling the API regularly (from an app or server) you must provide your API key as an `X-API-Key header` (case sensitive) or set the `key=YourAPIKey` url parameter. You should also set your http user-agent to a custom value to help identify your app and can optionally set the `client` parameter to help identify your app or service. This is especially useful to avoid being automatically blocked, which may happen if you use the same default user agent as a robot.

*To obtain a free API key Sign In and choose 'my apps' from the profile menu.*

Do not repeatedly call the API with duplicate queries. Debounce/throttle your API requests to minimise the work our API has to do. The API administrator (Open Charge Map) reserves the right to ban API callers (including automated banning) if callers make excessive/indescriminate use of the API, at the discretion of the OCM administrators.

If you need to make a high volume of queries against the API please host your own API mirror or import the data into your own API.

API V3 (documentation last updated Nov 2019)

SERVICE BASE URL:
https://api.openchargemap.io/v3/

Uptime last 7 days:  last 30 days: 

 RETRIEVING POI DATA
https://api.openchargemap.io/v3/poi/

EXAMPLE API CALLS:
Return charging location information for the US in JSON format, limited to the first 10 results: https://api.openchargemap.io/v3/poi/?output=json&countrycode=US&maxresults=10

The default output contains a lot of information. Here is the same call as above, but with the most compact output (formatting removed, reference data as IDs instead of full objects, null fields skipped): https://api.openchargemap.io/v3/poi/?output=json&countrycode=US&maxresults=100&compact=true&verbose=false

Return KML format results suitable for viewing in google earth/maps etc (UK, max 500 locations): https://api.openchargemap.io/v3/poi/?output=kml&countrycode=GB&maxresults=500

Data returned by the API has mixed licensing and applicable copyright attribution (included in results as "Data Provider"). If you require Open licensed data you currently must filter by opendata=true to return only original OCM data.
SERVICE PARAMETERS:
PARAMETER	DESCRIPTION	DEFAULT
key	Your API Key. Required for apps/services which intend to make repeated calls to the API either as a key parameter in the call URL or as an X-API-Key http header	(blank)
client	Optional custom identifier for your app or service (if you can't set a custom http User Agent header)	(blank)
output	json, geojson, xml, csv JSON format is recommended as highest fidelity	json
maxresults	limit on max number of results returned	100
countrycode	GB, US etc. Single ISO Country Code.	(blank)
countryid	exact match on a given numeric country id (comma separated list)	(blank)
latitude	latitude reference for distance calculation	(blank)
longitude	longitude reference for distance calculation	(blank)
distance	return results based on specified distance from specified latitude/longitude	(blank)
distanceunit	Miles or KM	Miles
operatorid	exact match on a given EVSE operator id (comma separated list)	(blank)
connectiontypeid	exact match on a given connection type id (comma separated list)	(blank)
levelid	exact match on a given charging level (1-3) id (comma separated list)	(blank)
minpowerkw	minimum output power in kW (this information is not known for many locations)	(blank)
usagetypeid	exact match on a given usage type id (comma separated list)	(blank)
statustypeid	exact match on a given status type id (comma separated list)	(blank)
dataproviderid	exact match on a given data provider id id (comma separated list). Use opendata=true for only OCM provided ("Open") data.	(blank)
modifiedsince	POIs modified since the given date (UTC) e.g. 2016-09-15T09:30	(blank)
opendata	true or false. Set to true to include only Open Data licensed content, false to return only non-open licensed data. By default all available data is returned. You should refer to the license of the original data provider in each case.	(blank)
includecomments	true or false. Set to true to also include user comments and media items (photos) per charging location.	false
verbose	true or false. Set to false to get a smaller result set with null items removed.	true
compact	true or false. Set to true to remove reference data objects from output (just returns IDs for common reference data such as DataProvider etc).	false
camelcase	true or false. Set to true to get a property names in camelCase format.	false
callback	specify the name of the JSONP callback (if required), JSON response type only.	(blank)
chargepointid	exact match on a given POI id (comma separated list).	(blank)
Additionally from v3 of the API onwards you can query using a bounding box, polygon or polyline (for a route etc). See here for more info on polyline encoding. :

PARAMETER	DESCRIPTION	DEFAULT
boundingbox	specify top left and bottom right box corners as: (lat,lng),(lat2,lng2)	(blank)
polygon	Specify an encoded polyline for the polygon shape. Polygon will be automatically closed from the last point to the first point.	(blank)
polyline	encoded polyline, use with distance param to increase search distance along line. Polyline is expanded into a polygon to cover the search distance.	(blank)
 RETRIEVING CORE REFERENCE DATA
Our core list of lookup values is termed Core Reference Data. This is the data you would require in order to present the user with Dropdown lists etc of possible values for Connection Type etc. This only returns content in JSON format.

https://api.openchargemap.io/v3/referencedata/

EXAMPLE API CALLS:
Return all reference data in JSON format: https://api.openchargemap.io/v3/referencedata/

Optional filter parameters:

countryid	exact match on a given numeric country id (comma separated list)	(blank)
 ADD NEW COMMENT/CHECK-IN
To submit a new comment or check-in again a specific POI, use the following API endpoint to POST a JSON format comment

https://api.openchargemap.io/v3/?action=comment_submission&format=json

Your JSON submission should be in the body of your POST and contain the following (for example):

                
{
    "ChargePointID": 12345,
    "CommentTypeID": 10,
    "UserName": "A. Nickname",
    "Comment": "This place is awesome, free cake for EV owners!",
    "Rating": 5,
    "RelatedURL": "http://awesomevplace.com",
    "CheckinStatusTypeID": 0
}
            
ChargePointID is the numeric OCM-ID of the POI in location. Values for CommentTypeID and CheckinStatusTypeID can be found in core reference data.

ChargePointID, CommentTypeID and CheckinStatusTypeID are mandatory, all other fields are optional.

COMMENT TYPES
ID	TITLE
10	General Comment
50	Important Notice (For Other Users)
100	Suggested Change (Note To Editors)
110	Suggested Changed (Actioned By Editor)
1000	Fault Report (Notice To Users And Operator)
CHECK-IN STATUS TYPES
ID	TITLE
10	Charged Successfully
15	Charged Successfully (Automated Checkin)
110	Charging Spot In Use (Non-EV Parked)
100	Charging Spot In Use (Other EV Parked)
120	Charging Spot Not Accessible (Access locked or site closed)
130	Charging Spot Not Found (Inadequate or Incorrect Details)
0	Did Not Visit Location
140	Equipment & Location Confirmed Correct
160	Equipment/Location Has Been Decommissioned
30	Failed to Charge (Equipment Not Compatible)
22	Failed to Charge (Equipment Not Fully Installed)
20	Failed to Charge (Equipment Not Operational)
25	Failed to Charge (Equipment Problem)
50	Failed to Charge (No Charging Equipment Present)
40	Failed to Charge (Required Other Access Card/Fob etc.)
150	Location Is A Duplicate
200	Other (Negative/Bad)
210	Other (Positive/Good)
 LINKING TO OCM CONTENT AND FEATURES
In addition to the API there are a number of standardised URLs which can be used to initiate certain actions, this can be useful to launch from within an app or for hyperlinking. The user can then sign in/register as required and proceed with the required action:

POI RELATED ACTIONS
ACTION	URL
View POI Details	https://openchargemap.org/site/poi/details/{OCM-ID}
Add a New POI	https://openchargemap.org/site/poi/add
Add a Comment/Check-In to an existing POI	https://openchargemap.org/site/poi/addcomment/{OCM-ID} where {OCM-ID} is the numeric ID of the POI to add a comment to.
Add a Photo to an existing POI	https://openchargemap.org/site/poi/addmediaitem/{OCM-ID}