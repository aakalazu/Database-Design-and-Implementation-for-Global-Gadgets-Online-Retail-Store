USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[Product]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
--===============| Create Product Table |===============--

CREATE TABLE [dbo].[Product](

   	[product_id] [int] IDENTITY(1000,1) NOT NULL,
	[subsubcategory_id] [int] NOT NULL,
	[product_name] [nvarchar](150) NOT NULL,
	[sku] [nvarchar](50) NOT NULL,
	[price] [decimal](18, 2) NOT NULL,
	[stock_quantity] [int] NOT NULL,
	[description] [nvarchar](500) NULL,
	[created_at] [datetime] NOT NULL,
	[is_active] [bit] NOT NULL,
	[supplier_id] [int] NOT NULL,

    -- PK
    CONSTRAINT [PK_Product_ID] PRIMARY KEY CLUSTERED 
        ([product_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

 ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [stock_quantity]
GO

ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [created_at]
GO

ALTER TABLE [dbo].[Products] ADD  DEFAULT ((1)) FOR [is_active]
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Product_SubSubCategory] FOREIGN KEY([subsubcategory_id])
REFERENCES [dbo].[ProductSubSubCategory] ([subsubcategory_id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Product_SubSubCategory]
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Product_Supplier] FOREIGN KEY([supplier_id])
REFERENCES [dbo].[Suppliers] ([supplier_id])
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Product_Supplier]
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [CK_Product_Name_NotEmpty] CHECK  ((len(ltrim(rtrim([product_name])))>(0)))
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_Product_Name_NotEmpty]
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [CK_Product_Price_Positive] CHECK  (([price]>(0)))
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_Product_Price_Positive]
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [CK_Product_Stock_NonNegative] CHECK  (([stock_quantity]>=(0)))
GO

ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_Product_Stock_NonNegative]
GO
