USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[ProductCategory]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
--===============| Create ProductCategory Table |===============--

CREATE TABLE [dbo].[ProductCategory](

    [category_id]    INT IDENTITY(600,1)      NOT NULL,
    [category_name]  NVARCHAR(100)            NOT NULL,
    [description]    NVARCHAR(250)            NULL,

    -- PK
    CONSTRAINT [PK_ProductCategory_ID] PRIMARY KEY CLUSTERED 
        ([category_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for CategoryName |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductCategory_Name] 
    ON [dbo].[ProductCategory] ([category_name] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
          SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, 
          DROP_EXISTING = OFF, ONLINE = OFF, 
          ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, 
          OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--===============| Adding CHECK Constraints |===============--

-- Category name cannot be empty
ALTER TABLE dbo.ProductCategory
ADD CONSTRAINT CK_ProductCategory_Name_NotEmpty
    CHECK (LEN(LTRIM(RTRIM(category_name))) > 0)
GO
