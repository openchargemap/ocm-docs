select * from [User] WHERE [Permissions] IS NOT NULL
--emergency and public charging requests
insert into UserSubscription (UserID,Title,Latitude,Longitude,DistanceKM, IsEnabled, DateCreated, NotifyGeneralChargingRequests, NotifyEmergencyChargingRequests, NotificationFrequencyMins)
SELECT ID, 'Local Charging Requests', Latitude, Longitude, 100, CONVERT(bit,1), GETUTCDATE(),CONVERT(bit,1),CONVERT(bit,1), 5 FROM [User]
WHERE Latitude IS NOT NULL and IsEmergencyChargingProvider=1 and IsPublicChargingProvider=1

--emergency charging requests
insert into UserSubscription (UserID,Title,Latitude,Longitude,DistanceKM, IsEnabled, DateCreated, NotifyGeneralChargingRequests, NotifyEmergencyChargingRequests, NotificationFrequencyMins)
SELECT ID, 'Local Charging Requests', Latitude, Longitude, 100, CONVERT(bit,1), GETUTCDATE(),CONVERT(bit,0),CONVERT(bit,1), 5 FROM [User]
WHERE Latitude IS NOT NULL and IsEmergencyChargingProvider=1 and IsPublicChargingProvider=0

--country editors
insert into UserSubscription (UserID,Title,CountryID, IsEnabled, DateCreated, NotificationFrequencyMins, NotifyComments, NotifyMedia, NotifyPOIAdditions, NotifyPOIUpdates, NotifyPOIEdits)
SELECT ID, 'Country Editor - Location Updates', 
SUBSTRING([Permissions],CHARINDEX('=',[Permissions])+1,(CHARINDEX(']',[Permissions]))-CHARINDEX('=',[Permissions])-1),
CONVERT(bit,1), 
GETUTCDATE(), 720, CONVERT(bit,1),CONVERT(bit,1), CONVERT(bit,1),CONVERT(bit,1),CONVERT(bit,1)  FROM [User]
WHERE [Permissions] LIKE '%Country%;' AND [Permissions] NOT LIKE '%All%' AND [Permissions] NOT LIKE '%Administrator%'

/*
select [Permissions],CHARINDEX('=',[Permissions]),
CHARINDEX(']',[Permissions]),
CHARINDEX(']',[Permissions])-CHARINDEX('=',[Permissions])-1,
SUBSTRING([Permissions],CHARINDEX('=',[Permissions])+1,(CHARINDEX(']',[Permissions]))-CHARINDEX('=',[Permissions])-1 )
from [User] where [Permissions] LIKE '%Country%;'
*/
