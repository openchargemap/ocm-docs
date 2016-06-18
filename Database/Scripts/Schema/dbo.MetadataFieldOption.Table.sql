USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MetadataFieldOption](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MetadataFieldID] [int] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_MetadataFieldOption] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[MetadataFieldOption]  WITH CHECK ADD  CONSTRAINT [FK_MetadataFieldOption_MetadataField] FOREIGN KEY([MetadataFieldID])
REFERENCES [dbo].[MetadataField] ([ID])
GO
ALTER TABLE [dbo].[MetadataFieldOption] CHECK CONSTRAINT [FK_MetadataFieldOption_MetadataField]
GO
