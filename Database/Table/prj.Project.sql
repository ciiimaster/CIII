SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[Project](
	[PK_Project] [int] IDENTITY(1,1) NOT NULL,
	[FK_BranchOffice] [int] NULL,
	[FK_Client] [int] NULL,
	[Active] [bit] NOT NULL,
	[ProjectNumber] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Description] [nvarchar](200) COLLATE French_CI_AS NULL,
	[OrderDate] [datetime] NULL,
	[OpeningDate] [datetime] NULL,
	[ClosingDate] [datetime] NULL,
	[ProjectManager] [nvarchar](100) COLLATE French_CI_AS NULL,
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
	[Status] [nvarchar](1) COLLATE French_CI_AS NULL,
	[ApplyProjectManagement] [bit] NOT NULL,
	[Comment] [nvarchar](400) COLLATE French_CI_AS NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[PK_Project] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [prj].[Project] ADD  CONSTRAINT [DF_Project_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [prj].[Project] ADD  CONSTRAINT [DF_Project_ApplyProjectManagement]  DEFAULT ((0)) FOR [ApplyProjectManagement]
GO
ALTER TABLE [prj].[Project] ADD  CONSTRAINT [DF_Project_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
ALTER TABLE [prj].[Project]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_BranchOffice_Project] FOREIGN KEY([FK_BranchOffice])
REFERENCES [app].[BranchOffice] ([PK_BranchOffice])
GO
ALTER TABLE [prj].[Project] CHECK CONSTRAINT [Constraint_FK_BranchOffice_Project]
GO
ALTER TABLE [prj].[Project]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Client_Project] FOREIGN KEY([FK_Client])
REFERENCES [prj].[Client] ([PK_Client])
GO
ALTER TABLE [prj].[Project] CHECK CONSTRAINT [Constraint_FK_Client_Project]
GO
