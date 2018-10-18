SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ctl].[BDCStd](
	[PK_BDCStd] [int] IDENTITY(1,1) NOT NULL,
	[ObjectIdentifier] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[ObjectName] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Description] [nvarchar](4000) COLLATE French_CI_AS NULL,
	[ActiveText] [nvarchar](50) COLLATE French_CI_AS NULL,
	[InactiveText] [nvarchar](50) COLLATE French_CI_AS NULL,
	[HalFlags] [nvarchar](50) COLLATE French_CI_AS NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_BDCStd] PRIMARY KEY CLUSTERED 
(
	[PK_BDCStd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ctl].[BDCStd] ADD  CONSTRAINT [DF_BDCStd_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
