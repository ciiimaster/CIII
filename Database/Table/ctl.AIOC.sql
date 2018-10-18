SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[AIOC](
	[PK_AIOC] [int] IDENTITY(1,1) NOT NULL,
	[ObjectIdentifier] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[ObjectName] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Description] [nvarchar](4000) COLLATE French_CI_AS NULL,
	[Units] [nvarchar](50) COLLATE French_CI_AS NULL,
	[MaxValue] [real] NULL,
	[MinValue] [real] NULL,
	[HalFlags] [nvarchar](50) COLLATE French_CI_AS NULL,
	[isAIC] [bit] NOT NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
	[HistoricalDateTime] [datetime] NOT NULL,
	[ForObjectIdentifier] [nvarchar](50) COLLATE French_CI_AS NULL,
	[FK_ProjectController] [int] NOT NULL,
	[FK_HistoricalStage] [int] NOT NULL,
 CONSTRAINT [PK_AIOC] PRIMARY KEY CLUSTERED 
(
	[PK_AIOC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[AIOC] ADD  CONSTRAINT [DF_AIOC_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [ctl].[AIOC]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_HistoricalStage_AIOC] FOREIGN KEY([FK_HistoricalStage])
REFERENCES [app].[HistoricalStage] ([PK_HistoricalStage])
GO
ALTER TABLE [ctl].[AIOC] CHECK CONSTRAINT [Constraint_FK_HistoricalStage_AIOC]
GO
ALTER TABLE [ctl].[AIOC]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ProjectController_AIOC] FOREIGN KEY([FK_ProjectController])
REFERENCES [ctl].[ProjectController] ([PK_ProjectController])
GO
ALTER TABLE [ctl].[AIOC] CHECK CONSTRAINT [Constraint_FK_ProjectController_AIOC]
GO
