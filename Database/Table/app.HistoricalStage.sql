SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[HistoricalStage](
	[PK_HistoricalStage] [int] NOT NULL,
	[HistoricalStage] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[MarkedAsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_HistoricalStage] PRIMARY KEY CLUSTERED 
(
	[PK_HistoricalStage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [app].[HistoricalStage] ADD  CONSTRAINT [DF_HistoricalStage_MarkedAsDeleted]  DEFAULT ((0)) FOR [MarkedAsDeleted]
GO
