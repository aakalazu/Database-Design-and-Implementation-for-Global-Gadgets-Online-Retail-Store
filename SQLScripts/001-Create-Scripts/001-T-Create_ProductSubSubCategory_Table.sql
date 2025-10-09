USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[ProductSubSubCategory]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
--===============| Create ProductSubSubCategory Table |===============--

CREATE TABLE [dbo].[ProductSubSubCategory](

    [subsubcategory_id] INT IDENTITY(800,1)     NOT NULL,
    [subcategory_id]    INT                     NOT NULL,
    [subsubcategory_name] NVARCHAR(100)         NOT NULL,
    [description]       NVARCHAR(250)           NULL,

    -- PK
    CONSTRAINT [PK_ProductSubSubCategory_ID] PRIMARY KEY CLUSTERED 
        ([subsubcategory_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK
    CONSTRAINT [FK_ProductSubSubCategory_SubCategory] FOREIGN KEY([subcategory_id])
        REFERENCES [dbo].[ProductSubCategory] ([subcategory_id])
        ON DELETE CASCADE
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for SubSubCategoryName |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductSubSubCategory_Name] 
    ON [dbo].[ProductSubSubCategory] ([subsubcategory_name] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
          SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, 
          DROP_EXISTING = OFF, ONLINE = OFF, 
          ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, 
          OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--===============| Adding CHECK Constraints |===============--

-- SubSubCategory name must not be empty
ALTER TABLE dbo.ProductSubSubCategory
ADD CONSTRAINT CK_ProductSubSubCategory_Name_NotEmpty
    CHECK (LEN(LTRIM(RTRIM(subsubcategory_name))) > 0)
GO
