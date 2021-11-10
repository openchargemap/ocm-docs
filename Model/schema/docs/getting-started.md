# Developing with Open Charge Map

## Accessing and using the Open Charge Map API
Open Charge Map provides an API for apps and sites to consume and contribute data. To learn more, check out the API Documentation: .

You can use this API to retrieve charging location information, user comments, checkins and photos and to submit new comments/checkins.

## Embedding Open Charge Map on your own website
Instead of developing your own map or application you can easily embed the Open Charge Map web app (https://map.openchargemap.io) into your own site using an `iframe` tag like this:

<iframe src="https://map.openchargemap.io/?mode=embedded" allow="geolocation" frameborder="0" width="100%" height="500px"></iframe>

### Optional Paramaters
You can pass &operatorid=<operator id> to set the default filter to a specific network/networks. See the Operators collection of https://api.openchargemap.io/v3/referencedata/ for reference ids.

You can pass `&latitude=` and `&longitude=` to set the start position. Otherwise the app will attempt to geolocate the user.

The web app is also designed for tablets, phones and web-enabled in-car touch screens running modern browsers.

# Example sites and apps using Open Charge Map
We've put together a partial list of apps and sites using Open Charge Map data and services. Please contact us if you want to see your site, app or service added to this list.

# Service and Data License Terms
The following terms apply to use of this OCM API, Data and Services. More information is available including privacy information

Use of the services and data hosted by us is subject to the following terms (updated 26/03/2015):

Data supplied by OpenChargeMap.org is derived from a wide variety of public sources and contributions. We accept no liability for the accuracy of this data and provide no assurances.
Data contributed to us by our users which we then redistribute is licensed under a Creative Commons Attribution-ShareAlike 4.0 International.

You agree that we may substitute this license at any point (where applicable) for an alternative Open Data license (http://opendatacommons.org/licenses/) if required by the Open Charge Map project.

By submitting data to us you are certifying that you are the originator of the data and have not copied any information which is subject to the copyright of another organisation or individual, or you are certifying that you have the authority to submit this information to us under the terms stated here.

Data imported from 3rd party Data Providers is copyright the original Data Provider in each case and is not provided under the same terms as the user-contributed data detailed above. Where possible we will attempt to only import data which has a formal and compatible Open Data license.

We will respond promptly to any DMCA or equivalent copyright protection request, please use our Contact page to lodge these requests, detailing the exact infringing items.

Use of our API or data in an application or service requires that the appropriate Data Provider attribution (including license terms) be provided in a way which is visible the end user.