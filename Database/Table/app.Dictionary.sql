SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Dictionary](
	[PK_Dictionary] [int] IDENTITY(1,1) NOT NULL,
	[ParentObjectType] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[ObjectType] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[ParentObject] [nvarchar](150) COLLATE French_CI_AS NULL,
	[Object] [nvarchar](150) COLLATE French_CI_AS NOT NULL,
	[TableName] [nvarchar](150) COLLATE French_CI_AS NULL,
	[ColumnName] [nvarchar](150) COLLATE French_CI_AS NULL,
	[FK_Language] [int] NOT NULL,
	[Caption] [nvarchar](1000) COLLATE French_CI_AS NOT NULL,
	[Hint] [nvarchar](4000) COLLATE French_CI_AS NOT NULL,
 CONSTRAINT [PK_Dictionary] PRIMARY KEY CLUSTERED 
(
	[PK_Dictionary] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [app].[Dictionary] ADD  CONSTRAINT [DF_Dictionary_FK_Laguage]  DEFAULT ((1)) FOR [FK_Language]
GO
ALTER TABLE [app].[Dictionary] ADD  CONSTRAINT [DF_Dictionary_Caption]  DEFAULT ('') FOR [Caption]
GO
ALTER TABLE [app].[Dictionary] ADD  CONSTRAINT [DF_Dictionary_Hint]  DEFAULT ('') FOR [Hint]
GO
