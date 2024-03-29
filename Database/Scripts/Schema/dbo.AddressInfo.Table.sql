USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AddressInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[AddressLine1] [nvarchar](1000) NULL,
	[AddressLine2] [nvarchar](1000) NULL,
	[Town] [nvarchar](100) NULL,
	[StateOrProvince] [nvarchar](100) NULL,
	[Postcode] [nvarchar](100) NULL,
	[CountryID] [int] NOT NULL,
	[Latitude] [float] NOT NULL,
	[Longitude] [float] NOT NULL,
	[ContactTelephone1] [nvarchar](200) NULL,
	[ContactTelephone2] [nvarchar](200) NULL,
	[ContactEmail] [nvarchar](500) NULL,
	[AccessComments] [nvarchar](max) NULL,
	[GeneralComments] [nvarchar](max) NULL,
	[RelatedURL] [nvarchar](500) NULL,
	[SpatialPosition]  AS ([geography]::Point([Latitude],[Longitude],(4326))) PERSISTED,
 CONSTRAINT [PK_AddressInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_AddressInfo_CountryID>] ON [dbo].[AddressInfo]
(
	[CountryID] ASC
)
INCLUDE ( 	[ID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_AddressLocation] ON [dbo].[AddressInfo]
(
	[Latitude] ASC,
	[Longitude] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AddressInfo]  WITH CHECK ADD  CONSTRAINT [FK_AddressInfo_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([ID])
GO
ALTER TABLE [dbo].[AddressInfo] CHECK CONSTRAINT [FK_AddressInfo_Country]
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

GO
CREATE SPATIAL INDEX [IX_AddresLocationSpatial] ON [dbo].[AddressInfo]
(
	[SpatialPosition]
)USING  GEOGRAPHY_GRID 
WITH (GRIDS =(LEVEL_1 = MEDIUM,LEVEL_2 = MEDIUM,LEVEL_3 = MEDIUM,LEVEL_4 = MEDIUM), 
CELLS_PER_OBJECT = 16, PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
