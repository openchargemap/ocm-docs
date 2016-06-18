USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserChargingRequest](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Latitude] [float] NOT NULL,
	[Longitude] [float] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsEmergency] [bit] NOT NULL,
 CONSTRAINT [PK_UserChargingRequest] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[UserChargingRequest]  WITH CHECK ADD  CONSTRAINT [FK_UserChargingRequest_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserChargingRequest] CHECK CONSTRAINT [FK_UserChargingRequest_User]
GO
