SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[BO](
	[PK_BO] [int] IDENTITY(1,1) NOT NULL,
	[ObjectIdentifier] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[ObjectName] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Description] [nvarchar](4000) COLLATE French_CI_AS NULL,
	[PresentValue] [nvarchar](50) COLLATE French_CI_AS NULL,
	[CommissionFlag] [nvarchar](50) COLLATE French_CI_AS NULL,
	[TypeReference] [nvarchar](50) COLLATE French_CI_AS NULL,
	[OutOfService] [int] NULL,
	[Polarity] [nvarchar](50) COLLATE French_CI_AS NULL,
	[MinimumOffTime] [int] NULL,
	[MinimumOnTime] [int] NULL,
	[CriticalControl] [int] NULL,
	[Reliability] [nvarchar](50) COLLATE French_CI_AS NULL,
	[RelinquishDefault] [nvarchar](50) COLLATE French_CI_AS NULL,
	[HoaStatus] [nvarchar](50) COLLATE French_CI_AS NULL,
	[StartDelayTime] [int] NULL,
	[FBackEnable] [nvarchar](50) COLLATE French_CI_AS NULL,
	[HalFlags] [nvarchar](50) COLLATE French_CI_AS NULL,
	[EventDetectionEnable] [int] NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
	[HistoricalDateTime] [datetime] NOT NULL,
	[FK_ProjectController] [int] NOT NULL,
	[FK_HistoricalStage] [int] NOT NULL,
 CONSTRAINT [PK_BO] PRIMARY KEY CLUSTERED 
(
	[PK_BO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[BO] ADD  CONSTRAINT [DF_BO_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [ctl].[BO]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_HistoricalStage_BO] FOREIGN KEY([FK_HistoricalStage])
REFERENCES [app].[HistoricalStage] ([PK_HistoricalStage])
GO
ALTER TABLE [ctl].[BO] CHECK CONSTRAINT [Constraint_FK_HistoricalStage_BO]
GO
ALTER TABLE [ctl].[BO]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ProjectController_BO] FOREIGN KEY([FK_ProjectController])
REFERENCES [ctl].[ProjectController] ([PK_ProjectController])
GO
ALTER TABLE [ctl].[BO] CHECK CONSTRAINT [Constraint_FK_ProjectController_BO]
GO
