USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataProvider](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NOT NULL,
	[WebsiteURL] [nvarchar](500) NULL,
	[Comments] [nvarchar](max) NULL,
	[DataProviderStatusTypeID] [int] NULL,
	[IsRestrictedEdit] [bit] NOT NULL,
	[IsOpenDataLicensed] [bit] NULL,
	[IsApprovedImport] [bit] NULL,
	[License] [nvarchar](250) NULL,
	[DateLastImported] [datetime] NULL,
	[ImportConfig] [nvarchar](max) NULL,
	[DataSharingAgreementID] [int] NULL,
 CONSTRAINT [PK_DataProvider] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[DataProvider] ADD  CONSTRAINT [DF_DataProvider_IsRestrictedEdit]  DEFAULT ((0)) FOR [IsRestrictedEdit]
GO
ALTER TABLE [dbo].[DataProvider] ADD  CONSTRAINT [DF_DataProvider_IsOpenDataLicensed]  DEFAULT ((0)) FOR [IsOpenDataLicensed]
GO
ALTER TABLE [dbo].[DataProvider] ADD  CONSTRAINT [DF_DataProvider_IsApprovedImport]  DEFAULT ((0)) FOR [IsApprovedImport]
GO
ALTER TABLE [dbo].[DataProvider]  WITH CHECK ADD  CONSTRAINT [FK_DataProvider_DataProviderStatus] FOREIGN KEY([DataProviderStatusTypeID])
REFERENCES [dbo].[DataProviderStatusType] ([ID])
GO
ALTER TABLE [dbo].[DataProvider] CHECK CONSTRAINT [FK_DataProvider_DataProviderStatus]
GO
