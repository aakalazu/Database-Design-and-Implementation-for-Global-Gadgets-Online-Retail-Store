USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[ProductSubCategory]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
--===============| Create ProductSubCategory Table |===============--

CREATE TABLE [dbo].[ProductSubCategory](

    [subcategory_id]   INT IDENTITY(700,1)     NOT NULL,
    [category_id]      INT                     NOT NULL,
    [subcategory_name] NVARCHAR(100)           NOT NULL,
    [description]      NVARCHAR(250)           NULL,

    -- PK
    CONSTRAINT [PK_ProductSubCategory_ID] PRIMARY KEY CLUSTERED 
        ([subcategory_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK
    CONSTRAINT [FK_ProductSubCategory_Category] FOREIGN KEY([category_id])
        REFERENCES [dbo].[ProductCategory] ([category_id])
        ON DELETE CASCADE
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for SubCategoryName |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductSubCategory_Name] 
    ON [dbo].[ProductSubCategory] ([subcategory_name] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
          SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, 
          DROP_EXISTING = OFF, ONLINE = OFF, 
          ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, 
          OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--===============| Adding CHECK Constraints |===============--

-- Subcategory name cannot be empty
ALTER TABLE dbo.ProductSubCategory
ADD CONSTRAINT CK_ProductSubCategory_Name_NotEmpty
    CHECK (LEN(LTRIM(RTRIM(subcategory_name))) > 0)
GO
