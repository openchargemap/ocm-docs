USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckinStatusType](
	[ID] [tinyint] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[IsPositive] [bit] NULL,
	[IsAutomatedCheckin] [bit] NOT NULL,
 CONSTRAINT [PK_CheckinStatusType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CheckinStatusType] ADD  CONSTRAINT [DF_CheckinStatusType_IsPositive]  DEFAULT ((1)) FOR [IsPositive]
GO
ALTER TABLE [dbo].[CheckinStatusType] ADD  CONSTRAINT [DF_CheckinStatusType_IsAutomatedCheckin]  DEFAULT ((0)) FOR [IsAutomatedCheckin]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'If true, implies positive, if false, implies negative, if null implies neutral' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CheckinStatusType', @level2type=N'COLUMN',@level2name=N'IsPositive'
GO
