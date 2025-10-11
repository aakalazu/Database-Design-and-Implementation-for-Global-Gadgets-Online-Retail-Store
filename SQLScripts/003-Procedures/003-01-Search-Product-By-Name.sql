GO
CREATE OR ALTER PROCEDURE dbo.SearchProductsByName
    @SearchTerm NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        P.product_id,
        P.product_name,
        P.sku,
        P.price,
        PC.category_name,
        MAX(O.order_date) AS MostRecentOrderDate
    FROM dbo.Products AS P
    LEFT JOIN dbo.OrderItems AS OI ON P.product_id = OI.product_id
    LEFT JOIN dbo.Orders AS O ON OI.order_id = O.order_id
    LEFT JOIN dbo.ProductSubSubCategory AS PSC ON P.subsubcategory_id = PSC.subsubcategory_id
    LEFT JOIN dbo.ProductSubCategory AS PS ON PSC.subcategory_id = PS.subcategory_id
    LEFT JOIN dbo.ProductCategory AS PC ON PS.category_id = PC.category_id
    WHERE P.product_name LIKE '%' + @SearchTerm + '%'
    GROUP BY P.product_id, P.product_name, P.sku, P.price, PC.category_name
    ORDER BY MostRecentOrderDate DESC;
END;
GO
