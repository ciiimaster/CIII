SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [prj].[ProjectApproval](
	[PK_ProjectApproval] [int] IDENTITY(1,1) NOT NULL,
	[FK_Client] [int] NULL,
	[FK_Building] [int] NULL,
	[ProjectNumber] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Description] [nvarchar](200) COLLATE French_CI_AS NULL,
	[OrderNumber] [nvarchar](100) COLLATE French_CI_AS NULL,
	[OrderDate] [datetime] NULL,
	[SellingPrice] [float] NOT NULL,
	[NominalPrice] [float] NOT NULL,
	[ClientCode] [nvarchar](50) COLLATE French_CI_AS NULL,
	[ClientName] [nvarchar](250) COLLATE French_CI_AS NULL,
	[Estimator] [nvarchar](250) COLLATE French_CI_AS NULL,
	[Comment] [nvarchar](400) COLLATE French_CI_AS NULL,
	[Approved] [bit] NOT NULL,
 CONSTRAINT [PK_ProjectApproval] PRIMARY KEY CLUSTERED 
(
	[PK_ProjectApproval] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [IXD_ProjectNumber] ON [prj].[ProjectApproval]
(
	[ProjectNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [prj].[ProjectApproval] ADD  CONSTRAINT [DF_ProjectApproval_SellingPrice]  DEFAULT ((0)) FOR [SellingPrice]
GO
ALTER TABLE [prj].[ProjectApproval] ADD  CONSTRAINT [DF_ProjectApproval_NominalPrice]  DEFAULT ((0)) FOR [NominalPrice]
GO
ALTER TABLE [prj].[ProjectApproval] ADD  CONSTRAINT [DF_ProjectApproval_Approved]  DEFAULT ((0)) FOR [Approved]
GO
ALTER TABLE [prj].[ProjectApproval]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Building_ProjectApproval] FOREIGN KEY([FK_Building])
REFERENCES [prj].[Building] ([PK_Building])
GO
ALTER TABLE [prj].[ProjectApproval] CHECK CONSTRAINT [Constraint_FK_Building_ProjectApproval]
GO
ALTER TABLE [prj].[ProjectApproval]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Client_ProjectApproval] FOREIGN KEY([FK_Client])
REFERENCES [prj].[Client] ([PK_Client])
GO
ALTER TABLE [prj].[ProjectApproval] CHECK CONSTRAINT [Constraint_FK_Client_ProjectApproval]
GO
