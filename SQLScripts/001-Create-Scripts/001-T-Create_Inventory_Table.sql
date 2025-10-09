USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[Inventory]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
--===============| Create Inventory Table |===============--

CREATE TABLE [dbo].[Inventory](

    [inventory_id]   INT IDENTITY(5000,1)     NOT NULL,
    [product_id]     INT                      NOT NULL,
    [quantity]       INT                      NOT NULL,
    [movement_type]  NVARCHAR(20)             NOT NULL,  -- e.g., 'IN', 'OUT', 'ADJUST'
    [movement_date]  DATETIME                 NOT NULL DEFAULT GETDATE(),
    [notes]          NVARCHAR(255)            NULL,

    -- PK
    CONSTRAINT [PK_Inventory_ID] PRIMARY KEY CLUSTERED 
        ([inventory_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK
    CONSTRAINT [FK_Inventory_Product] FOREIGN KEY([product_id])
        REFERENCES [dbo].[Product] ([product_id])
        ON DELETE CASCADE
) ON [PRIMARY]
GO

----------------------------------------------------------------------
--===============| Adding CHECK Constraints |===============--

-- Quantity must be greater than zero
ALTER TABLE dbo.Inventory
ADD CONSTRAINT CK_Inventory_Quantity_Positive
    CHECK (quantity > 0)
GO

-- Movement type must be one of allowed values
ALTER TABLE dbo.Inventory
ADD CONSTRAINT CK_Inventory_MovementType
    CHECK (movement_type IN ('IN', 'OUT', 'ADJUST'))
GO
