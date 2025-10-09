USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[PaymentMethod]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
--===============| Create PaymentMethod Table |===============--

CREATE TABLE [dbo].[PaymentMethod](

    [payment_method_id] INT IDENTITY(300,1)    NOT NULL,
    [method_name]       NVARCHAR(50)           NOT NULL,
    [is_active]         BIT                    NOT NULL DEFAULT(1),

    -- PK
    CONSTRAINT [PK_PaymentMethod_ID] PRIMARY KEY CLUSTERED 
        ([payment_method_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for MethodName |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_PaymentMethod_MethodName] 
    ON [dbo].[PaymentMethod] ([method_name] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
          SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, 
          DROP_EXISTING = OFF, ONLINE = OFF, 
          ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, 
          OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--===============| Adding CHECK Constraints |===============--

-- Method name cannot be blank
ALTER TABLE dbo.PaymentMethod
ADD CONSTRAINT CK_PaymentMethod_MethodName_NotEmpty
    CHECK (LEN(LTRIM(RTRIM(method_name))) > 0)
GO
