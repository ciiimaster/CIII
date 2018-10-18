SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[AO](
	[PK_AO] [int] IDENTITY(1,1) NOT NULL,
	[ObjectIdentifier] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[ObjectName] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Description] [nvarchar](4000) COLLATE French_CI_AS NULL,
	[PresentValue] [real] NULL,
	[Units] [nvarchar](50) COLLATE French_CI_AS NULL,
	[CommissionFlag] [nvarchar](50) COLLATE French_CI_AS NULL,
	[TypeReference] [nvarchar](50) COLLATE French_CI_AS NULL,
	[OutOfService] [int] NULL,
	[CurrentPriority] [int] NULL,
	[CriticalControl] [int] NULL,
	[CovIncrement] [real] NULL,
	[RelinquishDefault] [real] NULL,
	[Polarity] [nvarchar](50) COLLATE French_CI_AS NULL,
	[FBackEnable] [nvarchar](50) COLLATE French_CI_AS NULL,
	[Reliability] [nvarchar](50) COLLATE French_CI_AS NULL,
	[HalFlags] [nvarchar](50) COLLATE French_CI_AS NULL,
	[EventDetectionEnable] [int] NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
	[HistoricalDateTime] [datetime] NOT NULL,
	[FK_ProjectController] [int] NOT NULL,
	[FK_HistoricalStage] [int] NOT NULL,
 CONSTRAINT [PK_AO] PRIMARY KEY CLUSTERED 
(
	[PK_AO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[AO] ADD  CONSTRAINT [DF_AO_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [ctl].[AO]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_HistoricalStage_AO] FOREIGN KEY([FK_HistoricalStage])
REFERENCES [app].[HistoricalStage] ([PK_HistoricalStage])
GO
ALTER TABLE [ctl].[AO] CHECK CONSTRAINT [Constraint_FK_HistoricalStage_AO]
GO
ALTER TABLE [ctl].[AO]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ProjectController_AO] FOREIGN KEY([FK_ProjectController])
REFERENCES [ctl].[ProjectController] ([PK_ProjectController])
GO
ALTER TABLE [ctl].[AO] CHECK CONSTRAINT [Constraint_FK_ProjectController_AO]
GO
