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

    [product_id]        INT IDENTITY(1000,1)       NOT NULL,
    [subsubcategory_id] INT                        NOT NULL,
    [product_name]      NVARCHAR(150)              NOT NULL,
    [sku]               NVARCHAR(50)               NOT NULL,
    [price]             DECIMAL(18,2)              NOT NULL,
    [stock_quantity]    INT                        NOT NULL DEFAULT 0,
    [description]       NVARCHAR(500)              NULL,
    [created_at]        DATETIME                   NOT NULL DEFAULT GETDATE(),
    [is_active]         BIT                        NOT NULL DEFAULT 1,

    -- PK
    CONSTRAINT [PK_Product_ID] PRIMARY KEY CLUSTERED 
        ([product_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK
    CONSTRAINT [FK_Product_SubSubCategory] FOREIGN KEY([subsubcategory_id])
        REFERENCES [dbo].[ProductSubSubCategory] ([subsubcategory_id])
        ON DELETE CASCADE
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for SKU |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Product_SKU] 
    ON [dbo].[Product] ([sku] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
          SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, 
          DROP_EXISTING = OFF, ONLINE = OFF, 
          ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, 
          OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Adding CHECK Constraints |===============--

-- Product name cannot be empty
ALTER TABLE dbo.Product
ADD CONSTRAINT CK_Product_Name_NotEmpty
    CHECK (LEN(LTRIM(RTRIM(product_name))) > 0)
GO

-- Price must be greater than zero
ALTER TABLE dbo.Product
ADD CONSTRAINT CK_Product_Price_Positive
    CHECK (price > 0)
GO

-- Stock must be non-negative
ALTER TABLE dbo.Product
ADD CONSTRAINT CK_Product_Stock_NonNegative
    CHECK (stock_quantity >= 0)
GO
