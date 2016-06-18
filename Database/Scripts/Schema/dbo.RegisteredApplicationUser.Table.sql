USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RegisteredApplicationUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RegisteredApplicationID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[APIKey] [varchar](100) NOT NULL,
	[IsWriteEnabled] [nchar](10) NOT NULL,
 CONSTRAINT [PK_RegisteredApplicationUser] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[RegisteredApplicationUser] ADD  CONSTRAINT [DF_RegisteredApplicationUser_APIKey]  DEFAULT (newid()) FOR [APIKey]
GO
ALTER TABLE [dbo].[RegisteredApplicationUser] ADD  CONSTRAINT [DF_RegisteredApplicationUser_IsWriteEnabled]  DEFAULT ((1)) FOR [IsWriteEnabled]
GO
ALTER TABLE [dbo].[RegisteredApplicationUser]  WITH CHECK ADD  CONSTRAINT [FK_RegisteredApplicationUser_RegisteredApplication] FOREIGN KEY([RegisteredApplicationID])
REFERENCES [dbo].[RegisteredApplication] ([ID])
GO
ALTER TABLE [dbo].[RegisteredApplicationUser] CHECK CONSTRAINT [FK_RegisteredApplicationUser_RegisteredApplication]
GO
ALTER TABLE [dbo].[RegisteredApplicationUser]  WITH CHECK ADD  CONSTRAINT [FK_RegisteredApplicationUser_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[RegisteredApplicationUser] CHECK CONSTRAINT [FK_RegisteredApplicationUser_User]
GO
