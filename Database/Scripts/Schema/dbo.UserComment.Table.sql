USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserComment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChargePointID] [int] NOT NULL,
	[UserCommentTypeID] [int] NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[Comment] [nvarchar](max) NULL,
	[Rating] [tinyint] NULL,
	[RelatedURL] [nvarchar](500) NULL,
	[DateCreated] [datetime] NOT NULL,
	[CheckinStatusTypeID] [tinyint] NULL,
	[UserID] [int] NULL,
	[IsActionedByEditor] [bit] NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[AttachedData] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserComment_1] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_UserComment_ChargePoint] ON [dbo].[UserComment]
(
	[ChargePointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserComment] ADD  CONSTRAINT [DF_UserComment_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[UserComment] ADD  CONSTRAINT [DF_UserComment_IsActionedByEditor]  DEFAULT ((0)) FOR [IsActionedByEditor]
GO
ALTER TABLE [dbo].[UserComment]  WITH CHECK ADD  CONSTRAINT [FK_UserComment_ChargePoint] FOREIGN KEY([ChargePointID])
REFERENCES [dbo].[ChargePoint] ([ID])
GO
ALTER TABLE [dbo].[UserComment] CHECK CONSTRAINT [FK_UserComment_ChargePoint]
GO
ALTER TABLE [dbo].[UserComment]  WITH CHECK ADD  CONSTRAINT [FK_UserComment_CheckinStatusType] FOREIGN KEY([CheckinStatusTypeID])
REFERENCES [dbo].[CheckinStatusType] ([ID])
GO
ALTER TABLE [dbo].[UserComment] CHECK CONSTRAINT [FK_UserComment_CheckinStatusType]
GO
ALTER TABLE [dbo].[UserComment]  WITH CHECK ADD  CONSTRAINT [FK_UserComment_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserComment] CHECK CONSTRAINT [FK_UserComment_User]
GO
ALTER TABLE [dbo].[UserComment]  WITH CHECK ADD  CONSTRAINT [FK_UserComment_UserCommentType] FOREIGN KEY([UserCommentTypeID])
REFERENCES [dbo].[UserCommentType] ([ID])
GO
ALTER TABLE [dbo].[UserComment] CHECK CONSTRAINT [FK_UserComment_UserCommentType]
GO
