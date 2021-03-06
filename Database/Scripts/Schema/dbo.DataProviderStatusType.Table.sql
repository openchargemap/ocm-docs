USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataProviderStatusType](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[IsProviderEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_DataProviderStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[DataProviderStatusType] ADD  CONSTRAINT [DF_DataProviderStatus_IsEnabled]  DEFAULT ((1)) FOR [IsProviderEnabled]
GO
