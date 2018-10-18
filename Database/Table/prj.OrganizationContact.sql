SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[OrganizationContact](
	[PK_OrganizationContact] [int] IDENTITY(1,1) NOT NULL,
	[FK_Organization] [int] NOT NULL,
	[FK_Contact] [int] NOT NULL,
	[Comment] [nvarchar](4000) COLLATE French_CI_AS NULL,
 CONSTRAINT [PK_OrganizationContact] PRIMARY KEY CLUSTERED 
(
	[PK_OrganizationContact] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_OrganizationContact] ON [prj].[OrganizationContact]
(
	[FK_Contact] ASC,
	[FK_Organization] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [prj].[OrganizationContact]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Contact_OrganizationContact] FOREIGN KEY([FK_Contact])
REFERENCES [prj].[Contact] ([PK_Contact])
GO
ALTER TABLE [prj].[OrganizationContact] CHECK CONSTRAINT [Constraint_FK_Contact_OrganizationContact]
GO
ALTER TABLE [prj].[OrganizationContact]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Organization_OrganizationContact] FOREIGN KEY([FK_Organization])
REFERENCES [prj].[Organization] ([PK_Organization])
GO
ALTER TABLE [prj].[OrganizationContact] CHECK CONSTRAINT [Constraint_FK_Organization_OrganizationContact]
GO
