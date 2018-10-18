SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[AIOCScaleRange](
	[PK_AIOCScaleRange] [int] IDENTITY(1,1) NOT NULL,
	[Voltage] [real] NOT NULL,
	[Value] [real] NOT NULL,
	[AdValue] [int] NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
	[HistoricalDateTime] [datetime] NOT NULL,
	[AIOCObjectIdentifier] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[FK_ProjectController] [int] NOT NULL,
	[FK_HistoricalStage] [int] NOT NULL,
 CONSTRAINT [PK_AicScaleRange] PRIMARY KEY CLUSTERED 
(
	[PK_AIOCScaleRange] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[AIOCScaleRange] ADD  CONSTRAINT [DF_AIOCScaleRange_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [ctl].[AIOCScaleRange]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_HistoricalStage_AIOCScaleRange] FOREIGN KEY([FK_HistoricalStage])
REFERENCES [app].[HistoricalStage] ([PK_HistoricalStage])
GO
ALTER TABLE [ctl].[AIOCScaleRange] CHECK CONSTRAINT [Constraint_FK_HistoricalStage_AIOCScaleRange]
GO
ALTER TABLE [ctl].[AIOCScaleRange]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ProjectController_AIOCScaleRange] FOREIGN KEY([FK_ProjectController])
REFERENCES [ctl].[ProjectController] ([PK_ProjectController])
GO
ALTER TABLE [ctl].[AIOCScaleRange] CHECK CONSTRAINT [Constraint_FK_ProjectController_AIOCScaleRange]
GO
