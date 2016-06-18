USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procUpdateOCMStats]
AS
BEGIN

TRUNCATE TABLE [Statistic]

	INSERT INTO [Statistic] (StatTypeCode,UserID,NumItems)
	SELECT TOP 20 'UserPOIChangesLast90Days', UserID, COUNT(1) FROM EditQueueItem
	WHERE DateSubmitted>GETDATE()-90
	GROUP BY UserID
	ORDER BY COUNT(1) DESC


	INSERT INTO [Statistic] (StatTypeCode,UserID,NumItems)
	SELECT TOP 20 'EditorsActiveLast90Days', ProcessedByUserID, COUNT(1) FROM EditQueueItem
	WHERE DateProcessed>GETDATE()-90
	GROUP BY ProcessedByUserID
	ORDER BY COUNT(1) DESC

	/*select top 100 * from EditQueueItem 
	where ProcessedByUserID= 4575
	order by dateprocessed desc*/
		
	INSERT INTO [Statistic] (StatTypeCode,UserID,NumItems)
	SELECT TOP 20 'UserCommentsLast90Days', UserID, COUNT(1) FROM UserComment
	WHERE DateCreated>GETDATE()-90
	GROUP BY UserID
	ORDER BY COUNT(1) DESC

	INSERT INTO [Statistic] (StatTypeCode,UserID,NumItems)
	SELECT TOP 20 'UserMediaLast90Days', UserID, COUNT(1) FROM MediaItem
	WHERE DateCreated>GETDATE()-90
	GROUP BY UserID
	ORDER BY COUNT(1) DESC

	INSERT INTO [Statistic] (StatTypeCode,NumItems)
	select 'TotalCommentContributorsLast90Days', COUNT(Distinct(UserID)) FROM UserComment WHERE DateCreated>GETDATE()-90

	INSERT INTO [Statistic] (StatTypeCode,NumItems)
	select 'TotalPhotoContributorsLast90Days', COUNT(Distinct(UserID)) FROM MediaItem WHERE DateCreated>GETDATE()-90

	INSERT INTO [Statistic] (StatTypeCode,NumItems)
	select 'TotalChangeContributorsLast90Days', COUNT(Distinct(UserID)) FROM EditQueueItem WHERE DateSubmitted>GETDATE()-90
	
	INSERT INTO [Statistic] (StatTypeCode,NumItems)
	select 'ActiveEditorsLast90Days', COUNT(Distinct(ProcessedByUserID)) FROM EditQueueItem WHERE DateProcessed>GETDATE()-90
	
	INSERT INTO [Statistic] (StatTypeCode,NumItems)
	select 'StatisticsUpdated:'+CONVERT(varchar,GETUTCDATE()), 1
	
	SELECT StatTypeCode, NumItems, [User].Username FROM [Statistic] stat
	LEFT JOIN [User] ON stat.UserID=[User].ID
	ORDER BY StatTypeCode, NumItems DESC
END




GO
