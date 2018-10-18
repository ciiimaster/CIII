SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[ControllerBIStd](
	[PK_ControllerBIStd] [int] IDENTITY(1,1) NOT NULL,
	[FK_ControllerModel] [int] NOT NULL,
	[FK_BIStd] [int] NOT NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ControllerBIStd] PRIMARY KEY CLUSTERED 
(
	[PK_ControllerBIStd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[ControllerBIStd] ADD  CONSTRAINT [DF_ControllerBIStd_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [ctl].[ControllerBIStd]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_BIStd_ControllerBIStd] FOREIGN KEY([FK_BIStd])
REFERENCES [ctl].[BIStd] ([PK_BIStd])
GO
ALTER TABLE [ctl].[ControllerBIStd] CHECK CONSTRAINT [Constraint_FK_BIStd_ControllerBIStd]
GO
ALTER TABLE [ctl].[ControllerBIStd]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ControllerModel_ControllerBIStd] FOREIGN KEY([FK_ControllerModel])
REFERENCES [ctl].[ControllerModel] ([PK_ControllerModel])
GO
ALTER TABLE [ctl].[ControllerBIStd] CHECK CONSTRAINT [Constraint_FK_ControllerModel_ControllerBIStd]
GO
