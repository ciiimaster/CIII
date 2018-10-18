SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[ControllerAIOCStd](
	[PK_ControllerAIOCStd] [int] IDENTITY(1,1) NOT NULL,
	[FK_ControllerModel] [int] NOT NULL,
	[FK_AIOCStd] [int] NOT NULL,
 CONSTRAINT [PK_ControllerAIOCStd] PRIMARY KEY CLUSTERED 
(
	[PK_ControllerAIOCStd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[ControllerAIOCStd]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_AIOCStd_ControllerAIOCStd] FOREIGN KEY([FK_AIOCStd])
REFERENCES [ctl].[AIOCStd] ([PK_AIOCStd])
GO
ALTER TABLE [ctl].[ControllerAIOCStd] CHECK CONSTRAINT [Constraint_FK_AIOCStd_ControllerAIOCStd]
GO
ALTER TABLE [ctl].[ControllerAIOCStd]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ControllerModel_ControllerAIOCStd] FOREIGN KEY([FK_ControllerModel])
REFERENCES [ctl].[ControllerModel] ([PK_ControllerModel])
GO
ALTER TABLE [ctl].[ControllerAIOCStd] CHECK CONSTRAINT [Constraint_FK_ControllerModel_ControllerAIOCStd]
GO
