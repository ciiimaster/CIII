SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[ProjectBuilding](
	[PK_ProjectBuilding] [int] IDENTITY(1,1) NOT NULL,
	[FK_Project] [int] NOT NULL,
	[FK_Building] [int] NOT NULL,
	[Choosen] [bit] NOT NULL,
 CONSTRAINT [PK_ProjectBuilding] PRIMARY KEY CLUSTERED 
(
	[PK_ProjectBuilding] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [prj].[ProjectBuilding]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Building_ProjectBuilding] FOREIGN KEY([FK_Building])
REFERENCES [prj].[Building] ([PK_Building])
GO
ALTER TABLE [prj].[ProjectBuilding] CHECK CONSTRAINT [Constraint_FK_Building_ProjectBuilding]
GO
ALTER TABLE [prj].[ProjectBuilding]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Project_ProjectBuilding] FOREIGN KEY([FK_Project])
REFERENCES [prj].[Project] ([PK_Project])
GO
ALTER TABLE [prj].[ProjectBuilding] CHECK CONSTRAINT [Constraint_FK_Project_ProjectBuilding]
GO
