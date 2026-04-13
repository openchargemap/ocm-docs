USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EditQueueItem](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[IsProcessed] [bit] NOT NULL,
	[ProcessedByUserID] [int] NULL,
	[DateSubmitted] [smalldatetime] NOT NULL,
	[DateProcessed] [smalldatetime] NULL,
	[EditData] [nvarchar](max) NULL,
	[PreviousData] [nvarchar](max) NULL,
	[EntityID] [int] NULL,
	[EntityTypeID] [smallint] NULL,
 CONSTRAINT [PK_EditQueue] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EditQueueFilters] ON [dbo].[EditQueueItem]
(
	[DateSubmitted] ASC
)
INCLUDE([IsProcessed]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_UserID_EntityID] ON [dbo].[EditQueueItem]
(
	[UserID] ASC,
	[EntityID] ASC
)
INCLUDE([IsProcessed],[EntityTypeID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EditQueueItem] ADD  CONSTRAINT [DF_EditQueue_IsProcessed]  DEFAULT ((0)) FOR [IsProcessed]
GO
ALTER TABLE [dbo].[EditQueueItem] ADD  CONSTRAINT [DF_EditQueue_DateSubmitted]  DEFAULT (getdate()) FOR [DateSubmitted]
GO
ALTER TABLE [dbo].[EditQueueItem]  WITH CHECK ADD  CONSTRAINT [FK_EditQueue_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[EditQueueItem] CHECK CONSTRAINT [FK_EditQueue_User]
GO
ALTER TABLE [dbo].[EditQueueItem]  WITH CHECK ADD  CONSTRAINT [FK_EditQueue_User1] FOREIGN KEY([ProcessedByUserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[EditQueueItem] CHECK CONSTRAINT [FK_EditQueue_User1]
GO
ALTER TABLE [dbo].[EditQueueItem]  WITH CHECK ADD  CONSTRAINT [FK_EditQueueItem_EntityType] FOREIGN KEY([EntityTypeID])
REFERENCES [dbo].[EntityType] ([ID])
GO
ALTER TABLE [dbo].[EditQueueItem] CHECK CONSTRAINT [FK_EditQueueItem_EntityType]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User who submitted this edit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EditQueueItem', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Editor who approved/processed this edit' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EditQueueItem', @level2type=N'COLUMN',@level2name=N'ProcessedByUserID'
GO
