SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Group](
	[PK_Group] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) COLLATE French_CI_AS NOT NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
	[FK_Application] [int] NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[PK_Group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [app].[Group] ADD  CONSTRAINT [DF_Group_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [app].[Group]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Application_Group] FOREIGN KEY([FK_Application])
REFERENCES [app].[Application] ([PK_Application])
GO
ALTER TABLE [app].[Group] CHECK CONSTRAINT [Constraint_FK_Application_Group]
GO
