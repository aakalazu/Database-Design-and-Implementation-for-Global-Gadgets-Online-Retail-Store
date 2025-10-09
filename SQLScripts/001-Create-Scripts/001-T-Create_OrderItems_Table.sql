USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[OrderItems]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
--===============| Create OrderItems Table |===============--

CREATE TABLE [dbo].[OrderItems](

    [order_item_id]  INT IDENTITY(30000,1)   NOT NULL,
    [order_id]       INT                     NOT NULL,
    [product_id]     INT                     NOT NULL,
    [quantity]       INT                     NOT NULL,
    [unit_price]     DECIMAL(10,2)           NOT NULL,

    -- PK
    CONSTRAINT [PK_OrderItems_ID] PRIMARY KEY CLUSTERED 
        ([order_item_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK to Orders
    CONSTRAINT [FK_OrderItems_Orders] FOREIGN KEY([order_id])
        REFERENCES [dbo].[Orders] ([order_id])
        ON DELETE CASCADE,

    -- FK to Products
    CONSTRAINT [FK_OrderItems_Product] FOREIGN KEY([product_id])
        REFERENCES [dbo].[Product] ([product_id])
) ON [PRIMARY]
GO

----------------------------------------------------------------------
--===============| Adding CHECK Constraints |===============--

-- Quantity must be greater than 0
ALTER TABLE dbo.OrderItems
ADD CONSTRAINT CK_OrderItems_Quantity
    CHECK (quantity > 0)
GO

-- Unit price must be >= 0
ALTER TABLE dbo.OrderItems
ADD CONSTRAINT CK_OrderItems_UnitPrice
    CHECK (unit_price >= 0)
GO
