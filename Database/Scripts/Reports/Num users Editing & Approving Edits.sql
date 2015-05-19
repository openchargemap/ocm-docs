SELECT  
	YEAR(DateProcessed),MONTH(DateProcessed), 
	count(distinct(UserID)) as NumSubmitters,count(distinct(ProcessedByUserID)) AS NumEditors 
FROM EditQueueItem 
GROUP BY YEAR(DateProcessed),MONTH(DateProcessed)
ORDER BY YEAR(DateProcessed) DESC,MONTH(DateProcessed) DESC

SELECT  
	YEAR(DateSubmitted),MONTH(DateSubmitted), 
	count(distinct(UserID)) as NumSubmitters,count(distinct(ProcessedByUserID)) AS NumEditors 
FROM EditQueueItem 
GROUP BY YEAR(DateSubmitted),MONTH(DateSubmitted)
ORDER BY YEAR(DateSubmitted) DESC,MONTH(DateSubmitted) DESC

select COUNt(DISTINCT(ProcessedByUserID)) from EditQueueItem

--number of registered users not contributing info
select * from [User] 
where NOT EXISTS (SELECT 1 FROM EditQueueItem WHERE UserID=[User].ID) 
AND NOT EXISTS(SELECT 1 FROM MediaItem) AND NOT EXISTS (SELECT 1 FROM UserComment WHERE UserID=[User].ID)