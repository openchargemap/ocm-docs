select count(1) as NumAdded, Year(datecreated) as YearNum ,MONTH(dateCreated) as MonthNum FROM 
ChargePoint
GROUP BY YEAR(datecreated), MONTH(DateCreated)
ORDER BY YearNum,MonthNum