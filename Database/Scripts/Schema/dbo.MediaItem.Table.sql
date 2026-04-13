USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediaItem](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemURL] [nvarchar](500) NOT NULL,
	[ItemThumbnailURL] [nvarchar](500) NULL,
	[Comment] [nvarchar](1000) NULL,
	[ChargePointID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[IsVideo] [bit] NOT NULL,
	[IsFeaturedItem] [bit] NOT NULL,
	[MetadataValue] [nvarchar](1000) NULL,
	[IsExternalResource] [bit] NOT NULL,
 CONSTRAINT [PK_MediaItem] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_MediaItem] ON [dbo].[MediaItem]
(
	[ChargePointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MediaItem] ADD  CONSTRAINT [DF_MediaItem_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[MediaItem] ADD  CONSTRAINT [DF_MediaItem_IsEnabled]  DEFAULT ((1)) FOR [IsEnabled]
GO
ALTER TABLE [dbo].[MediaItem] ADD  CONSTRAINT [DF_MediaItem_IsFeaturedItem]  DEFAULT ((0)) FOR [IsFeaturedItem]
GO
ALTER TABLE [dbo].[MediaItem] ADD  CONSTRAINT [DF_MediaItem_IsExternalResource]  DEFAULT ((0)) FOR [IsExternalResource]
GO
ALTER TABLE [dbo].[MediaItem]  WITH CHECK ADD  CONSTRAINT [FK_MediaItem_ChargePoint] FOREIGN KEY([ChargePointID])
REFERENCES [dbo].[ChargePoint] ([ID])
GO
ALTER TABLE [dbo].[MediaItem] CHECK CONSTRAINT [FK_MediaItem_ChargePoint]
GO
ALTER TABLE [dbo].[MediaItem]  WITH CHECK ADD  CONSTRAINT [FK_MediaItem_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[MediaItem] CHECK CONSTRAINT [FK_MediaItem_User]
GO
