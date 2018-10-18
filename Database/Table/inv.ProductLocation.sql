SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [inv].[ProductLocation](
	[PK_ProductLocation] [int] IDENTITY(1,1) NOT NULL,
	[Warehouse] [nvarchar](100) COLLATE French_CI_AS NOT NULL,
	[Site] [nvarchar](50) COLLATE French_CI_AS NULL,
	[Emplacement] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
 CONSTRAINT [PK_ProductLocation] PRIMARY KEY CLUSTERED 
(
	[PK_ProductLocation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [inv].[ProductLocation] ADD  CONSTRAINT [DF_ProductLocation_Warehouse]  DEFAULT ('') FOR [Warehouse]
GO
ALTER TABLE [inv].[ProductLocation] ADD  CONSTRAINT [DF_Location_Emplacement]  DEFAULT ('') FOR [Emplacement]
GO
