USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSharingAgreement](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](255) NOT NULL,
	[CountryID] [int] NOT NULL,
	[RepresentativeName] [nvarchar](255) NOT NULL,
	[ContactEmail] [nvarchar](255) NOT NULL,
	[IsEmailVerified] [bit] NOT NULL,
	[WebsiteURL] [nvarchar](255) NOT NULL,
	[DataFeedType] [nvarchar](50) NOT NULL,
	[DataFeedURL] [nvarchar](500) NOT NULL,
	[DistributionLimitations] [nvarchar](500) NULL,
	[DataLicense] [nvarchar](255) NULL,
	[Credentials] [nvarchar](max) NULL,
	[UserID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateAgreed] [datetime] NOT NULL,
	[DateAgreementTerminated] [datetime] NULL,
	[Comments] [nvarchar](max) NULL,
 CONSTRAINT [PK_DataSharingAgreement] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[DataSharingAgreement]  WITH CHECK ADD  CONSTRAINT [FK_DataSharingAgreement_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([ID])
GO
ALTER TABLE [dbo].[DataSharingAgreement] CHECK CONSTRAINT [FK_DataSharingAgreement_Country]
GO
ALTER TABLE [dbo].[DataSharingAgreement]  WITH CHECK ADD  CONSTRAINT [FK_DataSharingAgreement_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[DataSharingAgreement] CHECK CONSTRAINT [FK_DataSharingAgreement_User]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Organisation making agreement' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataSharingAgreement', @level2type=N'COLUMN',@level2name=N'CompanyName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of person authorised by organisation to make agreement' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataSharingAgreement', @level2type=N'COLUMN',@level2name=N'RepresentativeName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Website of data provider' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataSharingAgreement', @level2type=N'COLUMN',@level2name=N'WebsiteURL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'OCM User ID of user who completed agreement' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataSharingAgreement', @level2type=N'COLUMN',@level2name=N'UserID'
GO
