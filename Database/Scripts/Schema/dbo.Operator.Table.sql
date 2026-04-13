USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Operator](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[WebsiteURL] [nvarchar](500) NULL,
	[Comments] [nvarchar](max) NULL,
	[PhonePrimaryContact] [nvarchar](100) NULL,
	[PhoneSecondaryContact] [nvarchar](100) NULL,
	[IsPrivateIndividual] [bit] NULL,
	[AddressInfoID] [int] NULL,
	[BookingURL] [nvarchar](500) NULL,
	[ContactEmail] [nvarchar](500) NULL,
	[FaultReportEmail] [nvarchar](500) NULL,
	[IsRestrictedEdit] [bit] NULL,
 CONSTRAINT [PK_Operator] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Operator] ADD  CONSTRAINT [DF_Operator_IsRestrictedEdit]  DEFAULT ((0)) FOR [IsRestrictedEdit]
GO
ALTER TABLE [dbo].[Operator]  WITH CHECK ADD  CONSTRAINT [FK_Operator_AddressInfo] FOREIGN KEY([AddressInfoID])
REFERENCES [dbo].[AddressInfo] ([ID])
GO
ALTER TABLE [dbo].[Operator] CHECK CONSTRAINT [FK_Operator_AddressInfo]
GO
