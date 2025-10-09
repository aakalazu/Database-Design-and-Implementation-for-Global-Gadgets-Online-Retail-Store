USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[Orders]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
--===============| Create Orders Table |===============--

CREATE TABLE [dbo].[Orders](

    [order_id]        INT IDENTITY(20000,1)   NOT NULL,
    [customer_id]     INT                     NOT NULL,
    [order_date]      DATETIME                NOT NULL DEFAULT GETDATE(),
    [shipping_method] NVARCHAR(50)            NOT NULL,
    [status_id]       INT                     NOT NULL, -- FK to OrderStatus
    [total_amount]    DECIMAL(10,2)           NOT NULL,

    -- PK
    CONSTRAINT [PK_Orders_ID] PRIMARY KEY CLUSTERED 
        ([order_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK to Customer
    CONSTRAINT [FK_Orders_Customer] FOREIGN KEY([customer_id])
        REFERENCES [dbo].[Customer] ([customer_id])
        ON DELETE CASCADE,

    -- FK to Order Status
    CONSTRAINT [FK_Orders_Status] FOREIGN KEY([status_id])
        REFERENCES [dbo].[OrderStatus] ([status_id])
) ON [PRIMARY]
GO

----------------------------------------------------------------------
--===============| Adding CHECK Constraints |===============--

-- Total amount cannot be negative
ALTER TABLE dbo.Orders
ADD CONSTRAINT CK_Orders_TotalAmount
    CHECK (total_amount >= 0)
GO

-- Shipping method must not be empty
ALTER TABLE dbo.Orders
ADD CONSTRAINT CK_Orders_ShippingMethod
    CHECK (LEN(LTRIM(RTRIM(shipping_method))) > 0)
GO
