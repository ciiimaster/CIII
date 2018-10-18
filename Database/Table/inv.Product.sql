SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [inv].[Product](
	[PK_Product] [int] IDENTITY(1,1) NOT NULL,
	[FK_ProductType] [int] NULL,
	[Code] [nvarchar](50) COLLATE French_CI_AS NOT NULL,
	[Name] [nvarchar](150) COLLATE French_CI_AS NOT NULL,
	[Description] [nvarchar](200) COLLATE French_CI_AS NULL,
	[FK_Organization__Supplier] [int] NULL,
	[FK_Organization__Manufacturer] [int] NULL,
	[IsERPProduct] [bit] NOT NULL,
	[Note] [nvarchar](4000) COLLATE French_CI_AS NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[PK_Product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [inv].[Product] ADD  CONSTRAINT [DF_Product_IsERPProduct]  DEFAULT ((0)) FOR [IsERPProduct]
GO
ALTER TABLE [inv].[Product]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Organization__Manufacturer_Product] FOREIGN KEY([FK_Organization__Manufacturer])
REFERENCES [prj].[Organization] ([PK_Organization])
GO
ALTER TABLE [inv].[Product] CHECK CONSTRAINT [Constraint_FK_Organization__Manufacturer_Product]
GO
ALTER TABLE [inv].[Product]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Organization__Supplier_Product] FOREIGN KEY([FK_Organization__Supplier])
REFERENCES [prj].[Organization] ([PK_Organization])
GO
ALTER TABLE [inv].[Product] CHECK CONSTRAINT [Constraint_FK_Organization__Supplier_Product]
GO
ALTER TABLE [inv].[Product]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ProductType_Product] FOREIGN KEY([FK_ProductType])
REFERENCES [inv].[ProductType] ([PK_ProductType])
GO
ALTER TABLE [inv].[Product] CHECK CONSTRAINT [Constraint_FK_ProductType_Product]
GO
