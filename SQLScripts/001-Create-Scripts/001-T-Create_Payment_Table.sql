USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[Payments]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
--===============| Create Payments Table |===============--

CREATE TABLE [dbo].[Payments](

    [payment_id]     INT IDENTITY(40000,1)   NOT NULL,
    [order_id]       INT                     NOT NULL,
    [payment_date]   DATETIME                NOT NULL DEFAULT GETDATE(),
    [amount]         DECIMAL(10,2)           NOT NULL,
    [payment_method_id] INT                  NOT NULL,

    -- PK
    CONSTRAINT [PK_Payments_ID] PRIMARY KEY CLUSTERED 
        ([payment_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK to Orders
    CONSTRAINT [FK_Payments_Orders] FOREIGN KEY([order_id])
        REFERENCES [dbo].[Orders] ([order_id])
        ON DELETE CASCADE,

    -- FK to PaymentMethod
    CONSTRAINT [FK_Payments_PaymentMethod] FOREIGN KEY([payment_method_id])
        REFERENCES [dbo].[PaymentMethod] ([payment_method_id])
) ON [PRIMARY]
GO

----------------------------------------------------------------------
--===============| Adding CHECK Constraints |===============--

-- Payment amount must be greater than 0
ALTER TABLE dbo.Payments
ADD CONSTRAINT CK_Payments_Amount
    CHECK (amount > 0)
GO
