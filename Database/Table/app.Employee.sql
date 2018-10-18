SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[Employee](
	[PK_Employee] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Active] [bit] NOT NULL,
	[EmployeeNumber] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[FirstName] [nvarchar](50) COLLATE French_CI_AS NULL,
	[LastName] [nvarchar](50) COLLATE French_CI_AS NULL,
	[FullName] [nvarchar](150) COLLATE French_CI_AS NULL,
	[JobTitle] [nvarchar](150) COLLATE French_CI_AS NULL,
	[BranchOfficeName] [nvarchar](150) COLLATE French_CI_AS NULL,
	[GenericTitle] [nvarchar](150) COLLATE French_CI_AS NULL,
	[OfficePhoneNumber] [nvarchar](50) COLLATE French_CI_AS NULL,
	[MobilePhone] [nvarchar](50) COLLATE French_CI_AS NULL,
	[Extension] [nvarchar](50) COLLATE French_CI_AS NULL,
	[Email] [nvarchar](150) COLLATE French_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [app].[Employee] ADD  CONSTRAINT [DF_Employee_Active]  DEFAULT ((1)) FOR [Active]
GO
