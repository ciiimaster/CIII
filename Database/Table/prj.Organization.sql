SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[Organization](
	[PK_Organization] [int] IDENTITY(1,1) NOT NULL,
	[Active] [bit] NOT NULL,
	[ID_Organization] [uniqueidentifier] NULL,
	[FK_Organization__Parent] [int] NULL,
	[FK_OrganizationType] [int] NOT NULL,
	[Name] [nvarchar](250) COLLATE French_CI_AS NOT NULL,
	[LegalName] [nvarchar](250) COLLATE French_CI_AS NULL,
	[FullAddress] [nvarchar](max) COLLATE French_CI_AS NULL,
	[AddressLine1] [nvarchar](250) COLLATE French_CI_AS NULL,
	[AddressLine2] [nvarchar](250) COLLATE French_CI_AS NULL,
	[City] [nvarchar](100) COLLATE French_CI_AS NULL,
	[State] [nvarchar](100) COLLATE French_CI_AS NULL,
	[Country] [nvarchar](100) COLLATE French_CI_AS NULL,
	[ZipCode] [nvarchar](50) COLLATE French_CI_AS NULL,
	[Email] [nvarchar](300) COLLATE French_CI_AS NULL,
	[WebSite] [nvarchar](200) COLLATE French_CI_AS NULL,
	[PrimaryPhoneNumber] [nvarchar](50) COLLATE French_CI_AS NULL,
	[SecondaryPhoneNumber] [nvarchar](50) COLLATE French_CI_AS NULL,
	[MobilePhone] [nvarchar](50) COLLATE French_CI_AS NULL,
	[Fax] [nvarchar](50) COLLATE French_CI_AS NULL,
	[FK_Language] [int] NOT NULL,
	[Comment] [nvarchar](400) COLLATE French_CI_AS NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Organisation] PRIMARY KEY CLUSTERED 
(
	[PK_Organization] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [prj].[Organization] ADD  CONSTRAINT [DF_Organization_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [prj].[Organization] ADD  CONSTRAINT [DF_Organization_FK_Language]  DEFAULT ((1)) FOR [FK_Language]
GO
ALTER TABLE [prj].[Organization] ADD  CONSTRAINT [DF_Organization_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [prj].[Organization]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Language_Organization] FOREIGN KEY([FK_Language])
REFERENCES [app].[Language] ([PK_Language])
GO
ALTER TABLE [prj].[Organization] CHECK CONSTRAINT [Constraint_FK_Language_Organization]
GO
ALTER TABLE [prj].[Organization]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Organization__Parent_Organization] FOREIGN KEY([FK_Organization__Parent])
REFERENCES [prj].[Organization] ([PK_Organization])
GO
ALTER TABLE [prj].[Organization] CHECK CONSTRAINT [Constraint_FK_Organization__Parent_Organization]
GO
ALTER TABLE [prj].[Organization]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_OrganizationType_Organization] FOREIGN KEY([FK_OrganizationType])
REFERENCES [prj].[OrganizationType] ([PK_OrganizationType])
GO
ALTER TABLE [prj].[Organization] CHECK CONSTRAINT [Constraint_FK_OrganizationType_Organization]
GO
