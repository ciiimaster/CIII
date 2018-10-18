SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[BranchOffice](
	[PK_BranchOffice] [int] NOT NULL,
	[Code] [nvarchar](10) COLLATE French_CI_AS NOT NULL,
	[Name] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
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
 CONSTRAINT [PK_BranchOffice] PRIMARY KEY CLUSTERED 
(
	[PK_BranchOffice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
