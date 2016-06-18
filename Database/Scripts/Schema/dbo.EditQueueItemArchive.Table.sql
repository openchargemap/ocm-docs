USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EditQueueItemArchive](
	[ID] [int] NOT NULL,
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
 CONSTRAINT [PK_EditQueueArchive] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
