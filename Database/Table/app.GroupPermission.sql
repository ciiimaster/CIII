SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[GroupPermission](
	[PK_GroupPermission] [int] IDENTITY(1,1) NOT NULL,
	[FK_Group] [int] NOT NULL,
	[FK_Permission] [int] NOT NULL,
	[Allow] [bit] NOT NULL,
 CONSTRAINT [PK_GroupWebpage] PRIMARY KEY CLUSTERED 
(
	[PK_GroupPermission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [app].[GroupPermission]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Group_GroupPermission] FOREIGN KEY([FK_Group])
REFERENCES [app].[Group] ([PK_Group])
GO
ALTER TABLE [app].[GroupPermission] CHECK CONSTRAINT [Constraint_FK_Group_GroupPermission]
GO
ALTER TABLE [app].[GroupPermission]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Permission_GroupPermission] FOREIGN KEY([FK_Permission])
REFERENCES [app].[Permission] ([PK_Permission])
GO
ALTER TABLE [app].[GroupPermission] CHECK CONSTRAINT [Constraint_FK_Permission_GroupPermission]
GO
