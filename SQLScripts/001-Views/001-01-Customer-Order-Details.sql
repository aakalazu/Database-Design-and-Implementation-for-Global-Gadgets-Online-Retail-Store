GO
CREATE OR ALTER VIEW dbo.vw_CustomerOrderDetails AS
SELECT 
    c.customer_id,
    c.full_name AS CustomerName,
    o.order_id,
    o.order_date,
    p.product_name,
    pc.category_name AS ProductCategory,
    s.supplier_name AS SupplierName,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS TotalCost,
	os.status_name,
    r.rating AS ProductRating,
    r.comments AS ProductReview
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN dbo.OrderItems AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.Products AS p
    ON oi.product_id = p.product_id
INNER JOIN dbo.ProductSubSubCategory AS pssc
    ON p.subsubcategory_id = pssc.subsubcategory_id
INNER JOIN dbo.ProductSubCategory AS psc
    ON pssc.subcategory_id = psc.subcategory_id
INNER JOIN dbo.ProductCategory AS pc
    ON psc.category_id = pc.category_id
INNER JOIN dbo.Suppliers AS s
    ON p.supplier_id = s.supplier_id
INNER JOIN dbo.OrderStatus AS os
	ON o.status_id = os.status_id
LEFT JOIN dbo.Reviews AS r
    ON o.order_id = r.order_id 
    AND p.product_id = r.product_id;
GO
