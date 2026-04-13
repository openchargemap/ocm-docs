USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MetadataField](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MetadataGroupID] [int] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[DataTypeID] [tinyint] NOT NULL,
 CONSTRAINT [PK_MetadataField] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MetadataField]  WITH CHECK ADD  CONSTRAINT [FK_MetadataField_DataType] FOREIGN KEY([DataTypeID])
REFERENCES [dbo].[DataType] ([ID])
GO
ALTER TABLE [dbo].[MetadataField] CHECK CONSTRAINT [FK_MetadataField_DataType]
GO
ALTER TABLE [dbo].[MetadataField]  WITH CHECK ADD  CONSTRAINT [FK_MetadataField_MetadataGroup] FOREIGN KEY([MetadataGroupID])
REFERENCES [dbo].[MetadataGroup] ([ID])
GO
ALTER TABLE [dbo].[MetadataField] CHECK CONSTRAINT [FK_MetadataField_MetadataGroup]
GO
