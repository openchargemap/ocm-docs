USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConnectionType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[FormalName] [nvarchar](200) NULL,
	[IsDiscontinued] [bit] NULL,
	[IsObsolete] [bit] NULL,
 CONSTRAINT [PK_ConnectionType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ConnectionType_Title] ON [dbo].[ConnectionType]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConnectionType] ADD  CONSTRAINT [DF_ConnectionType_IsDiscontinued]  DEFAULT ((0)) FOR [IsDiscontinued]
GO
ALTER TABLE [dbo].[ConnectionType] ADD  CONSTRAINT [DF_ConnectionType_IsObsolete]  DEFAULT ((0)) FOR [IsObsolete]
GO
