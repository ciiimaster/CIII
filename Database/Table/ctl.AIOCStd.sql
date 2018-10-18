SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[AIOCStd](
	[PK_AIOCStd] [int] IDENTITY(1,1) NOT NULL,
	[ObjectIdentifier] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[ObjectName] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Description] [nvarchar](4000) COLLATE French_CI_AS NULL,
	[Units] [nvarchar](50) COLLATE French_CI_AS NULL,
	[MaxValue] [real] NULL,
	[MinValue] [real] NULL,
	[HalFlags] [nvarchar](50) COLLATE French_CI_AS NULL,
	[IsAIC] [bit] NOT NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_AIOCStd] PRIMARY KEY CLUSTERED 
(
	[PK_AIOCStd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[AIOCStd] ADD  CONSTRAINT [DF_AIOCStd_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
