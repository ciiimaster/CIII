SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[AI](
	[PK_AI] [int] IDENTITY(1,1) NOT NULL,
	[ObjectIdentifier] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[ObjectName] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Description] [nvarchar](4000) COLLATE French_CI_AS NULL,
	[PresentValue] [real] NULL,
	[CommissionFlag] [nvarchar](50) COLLATE French_CI_AS NULL,
	[TypeReference] [nvarchar](50) COLLATE French_CI_AS NULL,
	[OutOfService] [int] NULL,
	[CovIncrement] [real] NULL,
	[AdFilter] [int] NULL,
	[Calibration] [real] NULL,
	[FixedPoint] [int] NULL,
	[DecimalPlaces] [int] NULL,
	[ExternalControl] [int] NULL,
	[Reliability] [nvarchar](50) COLLATE French_CI_AS NULL,
	[HalFlags] [nvarchar](50) COLLATE French_CI_AS NULL,
	[EventDetectionEnable] [int] NULL,
	[HistoricalDateTime] [datetime] NOT NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
	[FK_ProjectController] [int] NOT NULL,
	[FK_HistoricalStage] [int] NOT NULL,
 CONSTRAINT [PK_AI] PRIMARY KEY CLUSTERED 
(
	[PK_AI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[AI] ADD  CONSTRAINT [DF_AI_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [ctl].[AI]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_HistoricalStage_AI] FOREIGN KEY([FK_HistoricalStage])
REFERENCES [app].[HistoricalStage] ([PK_HistoricalStage])
GO
ALTER TABLE [ctl].[AI] CHECK CONSTRAINT [Constraint_FK_HistoricalStage_AI]
GO
ALTER TABLE [ctl].[AI]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ProjectController_AI] FOREIGN KEY([FK_ProjectController])
REFERENCES [ctl].[ProjectController] ([PK_ProjectController])
GO
ALTER TABLE [ctl].[AI] CHECK CONSTRAINT [Constraint_FK_ProjectController_AI]
GO
