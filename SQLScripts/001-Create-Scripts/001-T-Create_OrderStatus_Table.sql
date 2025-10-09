USE [GLOBALGADGETS]
GO

/****** Object:  Table [dbo].[OrderStatus]    Script Date: 10/1/2025  ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------
--===============| Create OrderStatus Table |===============--
-----------------------------------------------------------

CREATE TABLE [dbo].[OrderStatus](

    [status_id]     INT IDENTITY(1,1)     NOT NULL,
    [status_name]   NVARCHAR(30)          NOT NULL,

    -- PK
    CONSTRAINT [PK_OrderStatus_StatusID] PRIMARY KEY CLUSTERED 
        ([status_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
        ON [PRIMARY]
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for status_name |===============--
----------------------------------------------------------------------------------
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_OrderStatus_StatusName] 
    ON [dbo].[OrderStatus]
    ([status_name] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, 
          IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, 
          ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) 
    ON [PRIMARY]
GO

-----------------------------------------------------------
--===============| Add CHECK Constraints |===============--
-----------------------------------------------------------

-- Prevent empty or whitespace-only status names
ALTER TABLE dbo.OrderStatus 
ADD CONSTRAINT [CK_OrderStatus_StatusName_NotEmpty]
    CHECK (LEN(LTRIM(RTRIM(status_name))) > 0)
GO

-- Allow only valid predefined statuses (you can extend this list later)
ALTER TABLE dbo.OrderStatus 
ADD CONSTRAINT [CK_OrderStatus_AllowedValues]
    CHECK (status_name IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled', 'Returned'))
GO
