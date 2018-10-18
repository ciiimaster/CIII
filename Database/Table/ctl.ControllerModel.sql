SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[ControllerModel](
	[PK_ControllerModel] [int] IDENTITY(1,1) NOT NULL,
	[NameCloud] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[NameXML] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Description] [nvarchar](4000) COLLATE French_CI_AS NULL,
	[HalFlags] [nvarchar](50) COLLATE French_CI_AS NULL,
	[CloudAvailable] [bit] NOT NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ControllerModel] PRIMARY KEY CLUSTERED 
(
	[PK_ControllerModel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[ControllerModel] ADD  CONSTRAINT [DF_ControllerModel_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
