USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[IdentityProvider] [nvarchar](100) NOT NULL,
	[Identifier] [nvarchar](200) NOT NULL,
	[Username] [nvarchar](100) NULL,
	[PasswordHash] [nvarchar](500) NULL,
	[CurrentSessionToken] [nvarchar](100) NULL,
	[Profile] [nvarchar](max) NULL,
	[Location] [nvarchar](500) NULL,
	[WebsiteURL] [nvarchar](500) NULL,
	[ReputationPoints] [int] NULL,
	[Permissions] [nvarchar](max) NULL,
	[PermissionsRequested] [nvarchar](max) NULL,
	[DateCreated] [smalldatetime] NOT NULL,
	[DateLastLogin] [smalldatetime] NULL,
	[EmailAddress] [nvarchar](500) NULL,
	[IsEmergencyChargingProvider] [bit] NOT NULL,
	[IsProfilePublic] [bit] NOT NULL,
	[IsPublicChargingProvider] [bit] NOT NULL,
	[APIKey] [nvarchar](100) NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[SyncedSettings] [nvarchar](max) NULL,
	[IsReadOnly] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_ReputationPoints]  DEFAULT ((0)) FOR [ReputationPoints]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsEmergencyChargingProvider]  DEFAULT ((0)) FOR [IsEmergencyChargingProvider]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsProfilePublic]  DEFAULT ((1)) FOR [IsProfilePublic]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsPublicChargingProvider]  DEFAULT ((0)) FOR [IsPublicChargingProvider]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsReadOnly]  DEFAULT ((0)) FOR [IsReadOnly]
GO
