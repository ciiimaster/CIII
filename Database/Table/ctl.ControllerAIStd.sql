SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[ControllerAIStd](
	[PK_ControllerAIStd] [int] IDENTITY(1,1) NOT NULL,
	[FK_ControllerModel] [int] NOT NULL,
	[FK_AIStd] [int] NOT NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ControllerAIStd] PRIMARY KEY CLUSTERED 
(
	[PK_ControllerAIStd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[ControllerAIStd] ADD  CONSTRAINT [DF_ControllerAIStd_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [ctl].[ControllerAIStd]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_AIStd_ControllerAIStd] FOREIGN KEY([FK_AIStd])
REFERENCES [ctl].[AIStd] ([PK_AIStd])
GO
ALTER TABLE [ctl].[ControllerAIStd] CHECK CONSTRAINT [Constraint_FK_AIStd_ControllerAIStd]
GO
ALTER TABLE [ctl].[ControllerAIStd]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ControllerModel_ControllerAIStd] FOREIGN KEY([FK_ControllerModel])
REFERENCES [ctl].[ControllerModel] ([PK_ControllerModel])
GO
ALTER TABLE [ctl].[ControllerAIStd] CHECK CONSTRAINT [Constraint_FK_ControllerModel_ControllerAIStd]
GO
