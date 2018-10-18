SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[BuildingBranchOffice](
	[PK_BuildingBranchOffice] [int] IDENTITY(1,1) NOT NULL,
	[FK_Building] [int] NOT NULL,
	[FK_BranchOffice] [int] NOT NULL,
	[MarkAsShow] [bit] NOT NULL,
 CONSTRAINT [PK_BuildingBranchOffice] PRIMARY KEY CLUSTERED 
(
	[PK_BuildingBranchOffice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [prj].[BuildingBranchOffice]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_BranchOffice_BuildingBranchOffice] FOREIGN KEY([FK_BranchOffice])
REFERENCES [app].[BranchOffice] ([PK_BranchOffice])
GO
ALTER TABLE [prj].[BuildingBranchOffice] CHECK CONSTRAINT [Constraint_FK_BranchOffice_BuildingBranchOffice]
GO
ALTER TABLE [prj].[BuildingBranchOffice]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Building_BuildingBranchOffice] FOREIGN KEY([FK_Building])
REFERENCES [prj].[Building] ([PK_Building])
GO
ALTER TABLE [prj].[BuildingBranchOffice] CHECK CONSTRAINT [Constraint_FK_Building_BuildingBranchOffice]
GO
