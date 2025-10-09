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

USE [GLOBALGADGETS]
GO

/****** Object:  Table [dbo].[ShippingMethod]    Script Date: 10/1/2025  ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
--===============| Create ShippingMethod Table |===============--
---------------------------------------------------------------

CREATE TABLE [dbo].[ShippingMethod](

    [shipping_method_id]   INT IDENTITY(1,1)   NOT NULL,
    [method_name]          NVARCHAR(50)        NOT NULL,
    [description]          NVARCHAR(255)       NULL,
    [cost]                 DECIMAL(10,2)       NOT NULL,

    -- PK
    CONSTRAINT [PK_ShippingMethod_MethodID] PRIMARY KEY CLUSTERED 
        ([shipping_method_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
        ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for method_name |===============--
--------------------------------------------------------------------------------
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_ShippingMethod_MethodName] 
    ON [dbo].[ShippingMethod]
    ([method_name] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, 
          IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, 
          ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
    ON [PRIMARY]
GO

------------------------------------------------------------
--===============| Add CHECK Constraints |===============--
------------------------------------------------------------

-- Prevent empty or whitespace-only names
ALTER TABLE dbo.ShippingMethod 
ADD CONSTRAINT [CK_ShippingMethod_MethodName_NotEmpty]
    CHECK (LEN(LTRIM(RTRIM(method_name))) > 0)
GO

-- Restrict to predefined shipping methods (you can extend later)
ALTER TABLE dbo.ShippingMethod 
ADD CONSTRAINT [CK_ShippingMethod_AllowedValues]
    CHECK (method_name IN ('Standard', 'Express'))
GO

