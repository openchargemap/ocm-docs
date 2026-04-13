USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsageType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[IsPayAtLocation] [bit] NULL,
	[IsMembershipRequired] [bit] NULL,
	[IsAccessKeyRequired] [bit] NULL,
	[IsPublicAccess] [bit] NULL,
 CONSTRAINT [PK_UsageType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UsageType] ADD  CONSTRAINT [DF_UsageType_IsPublicAccess]  DEFAULT ((0)) FOR [IsPublicAccess]
GO
