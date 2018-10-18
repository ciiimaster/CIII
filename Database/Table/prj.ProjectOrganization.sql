SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[ProjectOrganization](
	[PK_ProjectOrganization] [int] IDENTITY(1,1) NOT NULL,
	[FK_Project] [int] NOT NULL,
	[FK_Organization] [int] NOT NULL,
	[FK_OrganizationType] [int] NOT NULL,
 CONSTRAINT [PK_ProjectOrganization] PRIMARY KEY CLUSTERED 
(
	[PK_ProjectOrganization] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [prj].[ProjectOrganization] ADD  CONSTRAINT [DF_ProjectOrganization_FK_OrganizationType]  DEFAULT ((1)) FOR [FK_OrganizationType]
GO
ALTER TABLE [prj].[ProjectOrganization]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Organization_ProjectOrganization] FOREIGN KEY([FK_Organization])
REFERENCES [prj].[Organization] ([PK_Organization])
GO
ALTER TABLE [prj].[ProjectOrganization] CHECK CONSTRAINT [Constraint_FK_Organization_ProjectOrganization]
GO
ALTER TABLE [prj].[ProjectOrganization]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_OrganizationType_ProjectOrganization] FOREIGN KEY([FK_OrganizationType])
REFERENCES [prj].[OrganizationType] ([PK_OrganizationType])
GO
ALTER TABLE [prj].[ProjectOrganization] CHECK CONSTRAINT [Constraint_FK_OrganizationType_ProjectOrganization]
GO
ALTER TABLE [prj].[ProjectOrganization]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Project_ProjectOrganization] FOREIGN KEY([FK_Project])
REFERENCES [prj].[Project] ([PK_Project])
GO
ALTER TABLE [prj].[ProjectOrganization] CHECK CONSTRAINT [Constraint_FK_Project_ProjectOrganization]
GO
