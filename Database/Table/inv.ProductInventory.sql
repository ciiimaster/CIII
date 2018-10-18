SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [inv].[ProductInventory](
	[PK_ProductInventory] [int] IDENTITY(1,1) NOT NULL,
	[FK_Product] [int] NOT NULL,
	[FK_ProductLocation] [int] NOT NULL,
	[UnitCost] [real] NOT NULL,
	[InStock] [real] NOT NULL,
	[ReservedStock] [real] NOT NULL,
 CONSTRAINT [PK_ProductInventory] PRIMARY KEY CLUSTERED 
(
	[PK_ProductInventory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [inv].[ProductInventory] ADD  CONSTRAINT [DF_ProductInventory_UnitCost]  DEFAULT ((0.0)) FOR [UnitCost]
GO
ALTER TABLE [inv].[ProductInventory] ADD  CONSTRAINT [DF_ProductInventory_ReservedStock]  DEFAULT ((0.0)) FOR [ReservedStock]
GO
ALTER TABLE [inv].[ProductInventory]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_Product_ProductInventory] FOREIGN KEY([FK_Product])
REFERENCES [inv].[Product] ([PK_Product])
GO
ALTER TABLE [inv].[ProductInventory] CHECK CONSTRAINT [Constraint_FK_Product_ProductInventory]
GO
ALTER TABLE [inv].[ProductInventory]  WITH CHECK ADD  CONSTRAINT [Constraint_FK_ProductLocation_ProductInventory] FOREIGN KEY([FK_ProductLocation])
REFERENCES [inv].[ProductLocation] ([PK_ProductLocation])
GO
ALTER TABLE [inv].[ProductInventory] CHECK CONSTRAINT [Constraint_FK_ProductLocation_ProductInventory]
GO
