USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConnectionInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChargePointID] [int] NOT NULL,
	[ConnectionTypeID] [int] NOT NULL,
	[Reference] [nvarchar](100) NULL,
	[StatusTypeID] [int] NULL,
	[Amps] [int] NULL,
	[Voltage] [int] NULL,
	[PowerKW] [float] NULL,
	[LevelTypeID] [int] NULL,
	[Quantity] [int] NULL,
	[Comments] [nvarchar](max) NULL,
	[CurrentTypeID] [smallint] NULL,
 CONSTRAINT [PK_ConnectionInfo_1] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_ConnectionInfoChargePoint] ON [dbo].[ConnectionInfo]
(
	[ChargePointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConnectionInfo]  WITH CHECK ADD  CONSTRAINT [FK_ConnectionInfo_ChargePoint] FOREIGN KEY([ChargePointID])
REFERENCES [dbo].[ChargePoint] ([ID])
GO
ALTER TABLE [dbo].[ConnectionInfo] CHECK CONSTRAINT [FK_ConnectionInfo_ChargePoint]
GO
ALTER TABLE [dbo].[ConnectionInfo]  WITH CHECK ADD  CONSTRAINT [FK_ConnectionInfo_ChargerType] FOREIGN KEY([LevelTypeID])
REFERENCES [dbo].[ChargerType] ([ID])
GO
ALTER TABLE [dbo].[ConnectionInfo] CHECK CONSTRAINT [FK_ConnectionInfo_ChargerType]
GO
ALTER TABLE [dbo].[ConnectionInfo]  WITH CHECK ADD  CONSTRAINT [FK_ConnectionInfo_ConnectorType] FOREIGN KEY([ConnectionTypeID])
REFERENCES [dbo].[ConnectionType] ([ID])
GO
ALTER TABLE [dbo].[ConnectionInfo] CHECK CONSTRAINT [FK_ConnectionInfo_ConnectorType]
GO
ALTER TABLE [dbo].[ConnectionInfo]  WITH CHECK ADD  CONSTRAINT [FK_ConnectionInfo_CurrentType] FOREIGN KEY([CurrentTypeID])
REFERENCES [dbo].[CurrentType] ([ID])
GO
ALTER TABLE [dbo].[ConnectionInfo] CHECK CONSTRAINT [FK_ConnectionInfo_CurrentType]
GO
ALTER TABLE [dbo].[ConnectionInfo]  WITH CHECK ADD  CONSTRAINT [FK_ConnectionInfo_StatusType] FOREIGN KEY([StatusTypeID])
REFERENCES [dbo].[StatusType] ([ID])
GO
ALTER TABLE [dbo].[ConnectionInfo] CHECK CONSTRAINT [FK_ConnectionInfo_StatusType]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'List of equipment types and specifications for a given POI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConnectionInfo'
GO
