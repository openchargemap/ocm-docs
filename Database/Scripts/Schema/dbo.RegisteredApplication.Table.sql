USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisteredApplication](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[WebsiteURL] [nvarchar](500) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[IsEnabled] [bit] NOT NULL,
	[IsWriteEnabled] [bit] NOT NULL,
	[AppID] [nvarchar](250) NOT NULL,
	[PrimaryAPIKey] [nvarchar](100) NOT NULL,
	[DeprecatedAPIKey] [nvarchar](100) NULL,
	[SharedSecret] [nvarchar](100) NOT NULL,
	[DateAPIKeyLastUsed] [datetime] NULL,
	[DateCreated] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Application] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [IX_RegisteredApplication_AppID] UNIQUE NONCLUSTERED 
(
	[AppID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[RegisteredApplication] ADD  CONSTRAINT [DF_Application_IsEnabled]  DEFAULT ((0)) FOR [IsEnabled]
GO
ALTER TABLE [dbo].[RegisteredApplication] ADD  CONSTRAINT [DF_Application_IsWriteEnabled]  DEFAULT ((0)) FOR [IsWriteEnabled]
GO
ALTER TABLE [dbo].[RegisteredApplication]  WITH CHECK ADD  CONSTRAINT [FK_RegisteredApplication_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[RegisteredApplication] CHECK CONSTRAINT [FK_RegisteredApplication_User]
GO
