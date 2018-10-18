SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[BI](
	[PK_BI] [int] IDENTITY(1,1) NOT NULL,
	[ObjectIdentifier] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[ObjectName] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Description] [nvarchar](4000) COLLATE French_CI_AS NULL,
	[PresentValue] [nvarchar](50) COLLATE French_CI_AS NULL,
	[CommissionFlag] [nvarchar](50) COLLATE French_CI_AS NULL,
	[TypeReference] [nvarchar](50) COLLATE French_CI_AS NULL,
	[OutOfService] [int] NULL,
	[Polarity] [nvarchar](50) COLLATE French_CI_AS NULL,
	[Reliability] [nvarchar](50) COLLATE French_CI_AS NULL,
	[HalFlags] [nvarchar](50) COLLATE French_CI_AS NULL,
	[ValueSource] [nvarchar](50) COLLATE French_CI_AS NULL,
	[EventDetectionEnable] [int] NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
	[HistoricalDateTime] [datetime] NOT NULL,
	[FK_ProjectController] [int] NOT NULL,
	[FK_HistoricalStage] [int] NOT NULL,
 CONSTRAINT [PK_BI] PRIMARY KEY CLUSTERED 
(
	[PK_BI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[BI] ADD  CONSTRAINT [DF_BI_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [ctl].[BI]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_HistoricalStage_BI] FOREIGN KEY([FK_HistoricalStage])
REFERENCES [app].[HistoricalStage] ([PK_HistoricalStage])
GO
ALTER TABLE [ctl].[BI] CHECK CONSTRAINT [Constraint_FK_HistoricalStage_BI]
GO
ALTER TABLE [ctl].[BI]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ProjectController_BI] FOREIGN KEY([FK_ProjectController])
REFERENCES [ctl].[ProjectController] ([PK_ProjectController])
GO
ALTER TABLE [ctl].[BI] CHECK CONSTRAINT [Constraint_FK_ProjectController_BI]
GO
