USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[Payment]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
--===============| Create Payment Table |===============--

CREATE TABLE [dbo].[Payment](

    [payment_id]        INT IDENTITY(4000,1)     NOT NULL,
    [order_id]          INT                      NOT NULL,
    [payment_method_id] INT                      NOT NULL,
    [amount]            DECIMAL(10,2)            NOT NULL,
    [payment_date]      DATETIME                 NOT NULL DEFAULT(GETDATE()),
    [payment_status]    NVARCHAR(20)             NOT NULL DEFAULT('Pending'),

    -- PK
    CONSTRAINT [PK_Payment_ID] PRIMARY KEY CLUSTERED 
        ([payment_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK
    CONSTRAINT [FK_Payment_Order] FOREIGN KEY([order_id])
        REFERENCES [dbo].[Order] ([order_id])
        ON DELETE CASCADE,

    CONSTRAINT [FK_Payment_PaymentMethod] FOREIGN KEY([payment_method_id])
        REFERENCES [dbo].[PaymentMethod] ([payment_method_id])
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Adding CHECK Constraints |===============--

-- Amount must be positive
ALTER TABLE dbo.Payment
ADD CONSTRAINT CK_Payment_Amount_Positive
    CHECK (amount > 0)
GO

-- Only valid statuses allowed
ALTER TABLE dbo.Payment
ADD CONSTRAINT CK_Payment_Status 
    CHECK (payment_status IN ('Pending', 'Completed', 'Failed', 'Refunded'))
GO
