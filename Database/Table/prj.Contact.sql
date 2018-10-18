SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[Contact](
	[PK_Contact] [int] IDENTITY(1,1) NOT NULL,
	[ID_Contact] [uniqueidentifier] NOT NULL,
	[Active] [bit] NOT NULL,
	[Title] [nvarchar](100) COLLATE French_CI_AS NULL,
	[FirstName] [nvarchar](100) COLLATE French_CI_AS NOT NULL,
	[LastName] [nvarchar](100) COLLATE French_CI_AS NOT NULL,
	[FullName] [nvarchar](200) COLLATE French_CI_AS NULL,
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
	[Comment] [nvarchar](4000) COLLATE French_CI_AS NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[PK_Contact] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [prj].[Contact] ADD  CONSTRAINT [DF_Contact_ID_Contact]  DEFAULT (newid()) FOR [ID_Contact]
GO
ALTER TABLE [prj].[Contact] ADD  CONSTRAINT [DF_Contact_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [prj].[Contact] ADD  CONSTRAINT [DF_Contact_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [prj].[Contact]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Language_Contact] FOREIGN KEY([FK_Language])
REFERENCES [app].[Language] ([PK_Language])
GO
ALTER TABLE [prj].[Contact] CHECK CONSTRAINT [Constraint_FK_Language_Contact]
GO
