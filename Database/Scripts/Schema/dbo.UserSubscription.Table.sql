USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSubscription](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[CountryID] [int] NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[DistanceKM] [float] NULL,
	[FilterSettings] [nvarchar](max) NULL,
	[DateLastNotified] [datetime] NULL,
	[IsEnabled] [bit] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[NotifyPOIAdditions] [bit] NOT NULL,
	[NotifyPOIEdits] [bit] NOT NULL,
	[NotifyPOIUpdates] [bit] NOT NULL,
	[NotifyComments] [bit] NOT NULL,
	[NotifyMedia] [bit] NOT NULL,
	[NotifyEmergencyChargingRequests] [bit] NOT NULL,
	[NotifyGeneralChargingRequests] [bit] NOT NULL,
	[NotificationFrequencyMins] [int] NOT NULL,
 CONSTRAINT [PK_UserSubscription] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[UserSubscription] ADD  CONSTRAINT [DF_UserSubscription_IsEnabled]  DEFAULT ((1)) FOR [IsEnabled]
GO
ALTER TABLE [dbo].[UserSubscription] ADD  CONSTRAINT [DF_UserSubscription_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[UserSubscription] ADD  CONSTRAINT [DF_UserSubscription_NotifyPOIAdditions]  DEFAULT ((0)) FOR [NotifyPOIAdditions]
GO
ALTER TABLE [dbo].[UserSubscription] ADD  CONSTRAINT [DF_UserSubscription_NotifyEdits]  DEFAULT ((0)) FOR [NotifyPOIEdits]
GO
ALTER TABLE [dbo].[UserSubscription] ADD  CONSTRAINT [DF_UserSubscription_NotifyPOIUpdates]  DEFAULT ((0)) FOR [NotifyPOIUpdates]
GO
ALTER TABLE [dbo].[UserSubscription] ADD  CONSTRAINT [DF_UserSubscription_NotifyComments]  DEFAULT ((0)) FOR [NotifyComments]
GO
ALTER TABLE [dbo].[UserSubscription] ADD  CONSTRAINT [DF_UserSubscription_NotifyMedia]  DEFAULT ((0)) FOR [NotifyMedia]
GO
ALTER TABLE [dbo].[UserSubscription] ADD  CONSTRAINT [DF_UserSubscription_NotifyEmergencyChargingRequests]  DEFAULT ((0)) FOR [NotifyEmergencyChargingRequests]
GO
ALTER TABLE [dbo].[UserSubscription] ADD  CONSTRAINT [DF_UserSubscription_NotifyGeneralChargingRequests]  DEFAULT ((0)) FOR [NotifyGeneralChargingRequests]
GO
ALTER TABLE [dbo].[UserSubscription] ADD  CONSTRAINT [DF_UserSubscription_NotificationFrequencyMins]  DEFAULT ((5)) FOR [NotificationFrequencyMins]
GO
ALTER TABLE [dbo].[UserSubscription]  WITH CHECK ADD  CONSTRAINT [FK_UserSubscription_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([ID])
GO
ALTER TABLE [dbo].[UserSubscription] CHECK CONSTRAINT [FK_UserSubscription_Country]
GO
ALTER TABLE [dbo].[UserSubscription]  WITH CHECK ADD  CONSTRAINT [FK_UserSubscription_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserSubscription] CHECK CONSTRAINT [FK_UserSubscription_User]
GO
