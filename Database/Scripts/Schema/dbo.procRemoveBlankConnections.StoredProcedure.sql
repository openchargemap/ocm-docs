USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procRemoveBlankConnections]
AS

delete from
	ConnectionInfo 
where 
	(ConnectionTypeID IS NULL OR ConnectionTypeID =0)
	AND (StatusTypeID IS NULL OR StatusTypeID=0) 
	AND Reference IS NULL AND Amps IS NULL AND Voltage IS NULL
	AND (Quantity IS NULL OR Quantity=1)
		AND (LevelTypeID IS NULL --OR LevelTypeID=1
	)
GO
