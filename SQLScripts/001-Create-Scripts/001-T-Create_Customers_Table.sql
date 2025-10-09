USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[Customers]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
--===============| Create Customers Table |===============--

CREATE TABLE [dbo].[Customers](

    [customer_id]     INT IDENTITY(1000,1)     NOT NULL,
    [user_id]      INT                      NOT NULL, -- FK to UserAccount
    [full_name]       NVARCHAR(100)            NOT NULL,
    [dob]             DATE                     NOT NULL,
    [billing_address] NVARCHAR(255)            NOT NULL,
    [email]           NVARCHAR(100)            NULL,
    [phone]           NVARCHAR(20)             NULL,
    [join_date]       DATETIME                 NOT NULL DEFAULT GETDATE(),
    [deactivation_date] DATETIME               NULL,

    -- PK
    CONSTRAINT [PK_Customers_ID] PRIMARY KEY CLUSTERED 
        ([customer_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK to UserAccount
    CONSTRAINT [FK_Customers_UserAccount] FOREIGN KEY([user_id])
        REFERENCES [dbo].[UserAccount] ([user_id])
        ON DELETE CASCADE
) ON [PRIMARY]
GO

----------------------------------------------------------------------
--===============| Adding CHECK Constraints |===============--

-- Full name cannot be empty
ALTER TABLE dbo.Customers
ADD CONSTRAINT CK_Customers_FullName
    CHECK (LEN(LTRIM(RTRIM(full_name))) > 0)
GO

-- Email format check (simple)
ALTER TABLE dbo.Customers
ADD CONSTRAINT CK_Customers_Email
    CHECK (email IS NULL OR email LIKE '%_@__%.__%')
GO

-- Phone must be at least 7 digits if provided
ALTER TABLE dbo.Customers
ADD CONSTRAINT CK_Customers_Phone
    CHECK (phone IS NULL OR LEN(phone) >= 7)
GO
