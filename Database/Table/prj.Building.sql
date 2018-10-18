SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[Building](
	[PK_Building] [int] IDENTITY(1,1) NOT NULL,
	[ID_Building] [uniqueidentifier] NULL,
	[Name] [nvarchar](500) COLLATE French_CI_AS NOT NULL,
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
	[Comment] [nvarchar](400) COLLATE French_CI_AS NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
	[FK_Organization__Owner] [int] NULL,
	[FK_Organization__Manager] [int] NULL,
 CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED 
(
	[PK_Building] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [prj].[Building] ADD  CONSTRAINT [DF_Building_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [prj].[Building]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Organization__Manager_Building] FOREIGN KEY([FK_Organization__Manager])
REFERENCES [prj].[Organization] ([PK_Organization])
GO
ALTER TABLE [prj].[Building] CHECK CONSTRAINT [Constraint_FK_Organization__Manager_Building]
GO
ALTER TABLE [prj].[Building]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Organization__Owner_Building] FOREIGN KEY([FK_Organization__Owner])
REFERENCES [prj].[Organization] ([PK_Organization])
GO
ALTER TABLE [prj].[Building] CHECK CONSTRAINT [Constraint_FK_Organization__Owner_Building]
GO
