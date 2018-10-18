SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[OrganizationBranchOffice](
	[PK_OrganizationBranchOffice] [int] IDENTITY(1,1) NOT NULL,
	[FK_Organization] [int] NOT NULL,
	[FK_BranchOffice] [int] NOT NULL,
	[MarkAsShow] [bit] NOT NULL,
 CONSTRAINT [PK_OrganizationBranchOffice] PRIMARY KEY CLUSTERED 
(
	[PK_OrganizationBranchOffice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [prj].[OrganizationBranchOffice]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_BranchOffice_OrganizationBranchOffice] FOREIGN KEY([FK_BranchOffice])
REFERENCES [app].[BranchOffice] ([PK_BranchOffice])
GO
ALTER TABLE [prj].[OrganizationBranchOffice] CHECK CONSTRAINT [Constraint_FK_BranchOffice_OrganizationBranchOffice]
GO
ALTER TABLE [prj].[OrganizationBranchOffice]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Organization_OrganizationBranchOffice] FOREIGN KEY([FK_Organization])
REFERENCES [prj].[Organization] ([PK_Organization])
GO
ALTER TABLE [prj].[OrganizationBranchOffice] CHECK CONSTRAINT [Constraint_FK_Organization_OrganizationBranchOffice]
GO
