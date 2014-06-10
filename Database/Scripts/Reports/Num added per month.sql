--num cp added per month
select count(1) as NumAdded, Year(datecreated) as YearNum ,MONTH(dateCreated) as MonthNum FROM 
ChargePoint
GROUP BY YEAR(datecreated), MONTH(DateCreated)
ORDER BY YearNum,MonthNum

--num cp editted/added per month
select count(1) as NumEdits,YEAR(dateprocessed) as YearNum, MONTH(dateprocessed) as MonthNum 
from editQueueItem
GROUP BY YEAR(dateprocessed), MONTH(dateprocessed)
ORDER BY YearNum,MonthNum

--new new users per month
select count(1) as NumUsers,YEAR(datecreated) as YearNum, MONTH(datecreated) as MonthNum 
from [User] u
GROUP BY YEAR(datecreated), MONTH(datecreated)
ORDER BY YearNum,MonthNum

--num new comments per month
select count(1) as NumComments,YEAR(datecreated) as YearNum, MONTH(datecreated) as MonthNum 
from [UserComment] u
GROUP BY YEAR(datecreated), MONTH(datecreated)
ORDER BY YearNum,MonthNum

--num new media per month
select count(1) as NumPhotos,YEAR(datecreated) as YearNum, MONTH(datecreated) as MonthNum 
from MediaItem u
GROUP BY YEAR(datecreated), MONTH(datecreated)
ORDER BY YearNum,MonthNum
