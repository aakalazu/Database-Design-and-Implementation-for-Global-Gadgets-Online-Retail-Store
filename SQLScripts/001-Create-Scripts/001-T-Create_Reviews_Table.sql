USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[Reviews]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
--===============| Create Reviews Table |===============--

CREATE TABLE [dbo].[Reviews](

    [review_id]    INT IDENTITY(50000,1)    NOT NULL,
    [customer_id]  INT                      NOT NULL,
    [product_id]   INT                      NOT NULL,
    [order_id]     INT                      NOT NULL,
    [rating]       INT                      NOT NULL,   -- 1 to 5
    [comments]     NVARCHAR(500)            NULL,
    [review_date]  DATETIME                 NOT NULL DEFAULT GETDATE(),

    -- PK
    CONSTRAINT [PK_Reviews_ID] PRIMARY KEY CLUSTERED 
        ([review_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK to Customers
    CONSTRAINT [FK_Reviews_Customer] FOREIGN KEY([customer_id])
        REFERENCES [dbo].[Customers] ([customer_id])
        ON DELETE CASCADE,

    -- FK to Products
    CONSTRAINT [FK_Reviews_Product] FOREIGN KEY([product_id])
        REFERENCES [dbo].[Product] ([product_id])
        ON DELETE CASCADE,

    -- FK to Orders
    CONSTRAINT [FK_Reviews_Order] FOREIGN KEY([order_id])
        REFERENCES [dbo].[Orders] ([order_id])
        ON DELETE CASCADE
) ON [PRIMARY]
GO

----------------------------------------------------------------------
--===============| Adding CHECK Constraints |===============--

-- Rating must be between 1 and 5
ALTER TABLE dbo.Reviews
ADD CONSTRAINT CK_Reviews_Rating
    CHECK (rating BETWEEN 1 AND 5)
GO

