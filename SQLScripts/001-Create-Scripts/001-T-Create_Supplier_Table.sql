USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[Supplier]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
--===============| Create Supplier Table |===============--

CREATE TABLE [dbo].[Supplier](

    [supplier_id]    INT IDENTITY(500,1)     NOT NULL,
    [supplier_name]  NVARCHAR(100)           NOT NULL,
    [contact_name]   NVARCHAR(100)           NULL,
    [phone_number]   NVARCHAR(20)            NULL,
    [email]          NVARCHAR(100)           NULL,
    [address]        NVARCHAR(250)           NULL,
    [is_active]      BIT                     NOT NULL DEFAULT(1),

    -- PK
    CONSTRAINT [PK_Supplier_ID] PRIMARY KEY CLUSTERED 
        ([supplier_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for SupplierName |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Supplier_Name] 
    ON [dbo].[Supplier] ([supplier_name] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
          SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, 
          DROP_EXISTING = OFF, ONLINE = OFF, 
          ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, 
          OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--===============| Adding CHECK Constraints |===============--

-- Supplier name cannot be empty
ALTER TABLE dbo.Supplier
ADD CONSTRAINT CK_Supplier_Name_NotEmpty
    CHECK (LEN(LTRIM(RTRIM(supplier_name))) > 0)
GO

-- Phone number must be at least 7 characters if provided
ALTER TABLE dbo.Supplier
ADD CONSTRAINT CK_Supplier_Phone_Length
    CHECK (phone_number IS NULL OR LEN(phone_number) >= 7)
GO
