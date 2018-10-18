SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[Controller](
	[PK_Controller] [int] IDENTITY(1,1) NOT NULL,
	[ObjectName] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[DeviceInstance] [int] NOT NULL,
	[Description] [nvarchar](4000) COLLATE French_CI_AS NULL,
	[FirmwareRevision] [nvarchar](50) COLLATE French_CI_AS NULL,
	[HardwareRevision] [nvarchar](50) COLLATE French_CI_AS NULL,
	[ApplicationSoftwareVersion] [nvarchar](50) COLLATE French_CI_AS NULL,
	[Location] [nvarchar](50) COLLATE French_CI_AS NULL,
	[Latitude] [real] NULL,
	[Longitude] [real] NULL,
	[SiteElevation] [int] NULL,
	[SiteElevationUnits] [nvarchar](50) COLLATE French_CI_AS NULL,
	[HalFlags] [nvarchar](50) COLLATE French_CI_AS NULL,
	[ScanRate] [real] NULL,
	[IOScanRate] [real] NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
	[HistoricalDateTime] [datetime] NOT NULL,
	[FK_ControllerModel] [int] NOT NULL,
	[FK_ProjectController] [int] NOT NULL,
	[FK_HistoricalStage] [int] NOT NULL,
 CONSTRAINT [PK_Controller] PRIMARY KEY CLUSTERED 
(
	[PK_Controller] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[Controller] ADD  CONSTRAINT [DF_Controller_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [ctl].[Controller]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ControllerModel_Controller] FOREIGN KEY([FK_ControllerModel])
REFERENCES [ctl].[ControllerModel] ([PK_ControllerModel])
GO
ALTER TABLE [ctl].[Controller] CHECK CONSTRAINT [Constraint_FK_ControllerModel_Controller]
GO
ALTER TABLE [ctl].[Controller]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_HistoricalStage_Controller] FOREIGN KEY([FK_HistoricalStage])
REFERENCES [app].[HistoricalStage] ([PK_HistoricalStage])
GO
ALTER TABLE [ctl].[Controller] CHECK CONSTRAINT [Constraint_FK_HistoricalStage_Controller]
GO
ALTER TABLE [ctl].[Controller]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ProjectController_Controller] FOREIGN KEY([FK_ProjectController])
REFERENCES [ctl].[ProjectController] ([PK_ProjectController])
GO
ALTER TABLE [ctl].[Controller] CHECK CONSTRAINT [Constraint_FK_ProjectController_Controller]
GO
