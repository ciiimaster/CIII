SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[User](
	[PK_User] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[FirstName] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[LastName] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Password] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Comment] [nvarchar](400) COLLATE French_CI_AS NULL,
	[RowPerPage] [int] NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[PK_User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [app].[User] ADD  CONSTRAINT [DF_User_RowPerPage]  DEFAULT ((15)) FOR [RowPerPage]
GO
ALTER TABLE [app].[User] ADD  CONSTRAINT [DF_User_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
