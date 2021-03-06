USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemConfig](
	[ConfigKeyName] [nvarchar](100) NOT NULL,
	[ConfigValue] [nvarchar](500) NULL,
	[DataTypeID] [tinyint] NULL,
 CONSTRAINT [PK_SystemConfig] PRIMARY KEY CLUSTERED 
(
	[ConfigKeyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[SystemConfig]  WITH CHECK ADD  CONSTRAINT [FK_SystemConfig_DataType] FOREIGN KEY([DataTypeID])
REFERENCES [dbo].[DataType] ([ID])
GO
ALTER TABLE [dbo].[SystemConfig] CHECK CONSTRAINT [FK_SystemConfig_DataType]
GO
