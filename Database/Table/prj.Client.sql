SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[Client](
	[PK_Client] [int] IDENTITY(1,1) NOT NULL,
	[Active] [bit] NOT NULL,
	[Code] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Code_Override] [nvarchar](50) COLLATE French_CI_AS NULL,
	[Name] [nvarchar](250) COLLATE French_CI_AS NULL,
	[Name_Override] [nvarchar](250) COLLATE French_CI_AS NULL,
	[Comment] [nvarchar](400) COLLATE French_CI_AS NULL,
	[Source] [int] NOT NULL,
	[MarkedAsDeleted] [bit] NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[PK_Client] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [prj].[Client] ADD  CONSTRAINT [DF_Client_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [prj].[Client] ADD  CONSTRAINT [DF_Client_Source]  DEFAULT ((1)) FOR [Source]
GO
ALTER TABLE [prj].[Client] ADD  CONSTRAINT [DF_Client_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
