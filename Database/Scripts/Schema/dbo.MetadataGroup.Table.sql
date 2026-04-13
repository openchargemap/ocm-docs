USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MetadataGroup](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[IsRestrictedEdit] [bit] NOT NULL,
	[DataProviderID] [int] NOT NULL,
	[IsPublicInterest] [bit] NOT NULL,
 CONSTRAINT [PK_MetadataGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MetadataGroup] ADD  CONSTRAINT [DF_MetadataGroup_IsEditRestricted]  DEFAULT ((0)) FOR [IsRestrictedEdit]
GO
ALTER TABLE [dbo].[MetadataGroup] ADD  CONSTRAINT [DF_MetadataGroup_IsPublicInterest]  DEFAULT ((0)) FOR [IsPublicInterest]
GO
ALTER TABLE [dbo].[MetadataGroup]  WITH CHECK ADD  CONSTRAINT [FK_MetadataGroup_DataProvider] FOREIGN KEY([DataProviderID])
REFERENCES [dbo].[DataProvider] ([ID])
GO
ALTER TABLE [dbo].[MetadataGroup] CHECK CONSTRAINT [FK_MetadataGroup_DataProvider]
GO
