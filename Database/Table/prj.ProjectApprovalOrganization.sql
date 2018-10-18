SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[ProjectApprovalOrganization](
	[PK_ProjectApprovalOrganization] [int] IDENTITY(1,1) NOT NULL,
	[FK_ProjectApproval] [int] NOT NULL,
	[FK_Organization] [int] NOT NULL,
	[FK_OrganizationType] [int] NOT NULL,
 CONSTRAINT [PK_ProjectApprovalOrganization] PRIMARY KEY CLUSTERED 
(
	[PK_ProjectApprovalOrganization] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [prj].[ProjectApprovalOrganization] ADD  CONSTRAINT [DF_ProjectApprovalOrganization_FK_OrganizationType]  DEFAULT ((1)) FOR [FK_OrganizationType]
GO
ALTER TABLE [prj].[ProjectApprovalOrganization]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Organization_ProjectApprovalOrganization] FOREIGN KEY([FK_Organization])
REFERENCES [prj].[Organization] ([PK_Organization])
GO
ALTER TABLE [prj].[ProjectApprovalOrganization] CHECK CONSTRAINT [Constraint_FK_Organization_ProjectApprovalOrganization]
GO
ALTER TABLE [prj].[ProjectApprovalOrganization]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_OrganizationType_ProjectApprovalOrganization] FOREIGN KEY([FK_OrganizationType])
REFERENCES [prj].[OrganizationType] ([PK_OrganizationType])
GO
ALTER TABLE [prj].[ProjectApprovalOrganization] CHECK CONSTRAINT [Constraint_FK_OrganizationType_ProjectApprovalOrganization]
GO
ALTER TABLE [prj].[ProjectApprovalOrganization]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ProjectApproval_ProjectApprovalOrganization] FOREIGN KEY([FK_ProjectApproval])
REFERENCES [prj].[ProjectApproval] ([PK_ProjectApproval])
GO
ALTER TABLE [prj].[ProjectApprovalOrganization] CHECK CONSTRAINT [Constraint_FK_ProjectApproval_ProjectApprovalOrganization]
GO
