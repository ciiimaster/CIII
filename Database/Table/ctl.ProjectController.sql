SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[ProjectController](
	[PK_ProjectController] [int] IDENTITY(1,1) NOT NULL,
	[FK_Project] [int] NOT NULL,
	[FK_Controller] [int] NOT NULL,
 CONSTRAINT [PK_ProjectController] PRIMARY KEY CLUSTERED 
(
	[PK_ProjectController] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[ProjectController]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Controller_ProjectController] FOREIGN KEY([FK_Controller])
REFERENCES [ctl].[Controller] ([PK_Controller])
GO
ALTER TABLE [ctl].[ProjectController] CHECK CONSTRAINT [Constraint_FK_Controller_ProjectController]
GO
ALTER TABLE [ctl].[ProjectController]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Project_ProjectController] FOREIGN KEY([FK_Project])
REFERENCES [prj].[Project] ([PK_Project])
GO
ALTER TABLE [ctl].[ProjectController] CHECK CONSTRAINT [Constraint_FK_Project_ProjectController]
GO
