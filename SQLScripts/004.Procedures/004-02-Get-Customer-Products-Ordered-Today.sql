GO
CREATE OR ALTER PROCEDURE dbo.GetCustomerProductsOrderedToday
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Retrieve orders placed today by this customer
    SELECT 
        C.customer_id,
        C.full_name AS CustomerName,
        O.order_id,
        O.order_date,
        P.product_name,
        S.supplier_name,
        OI.quantity,
        OI.unit_price,
        (OI.quantity * OI.unit_price) AS TotalAmount
    FROM dbo.Orders AS O
    INNER JOIN dbo.OrderItems AS OI ON O.order_id = OI.order_id
    INNER JOIN dbo.Products AS P ON OI.product_id = P.product_id
    INNER JOIN dbo.Suppliers AS S ON P.supplier_id = S.supplier_id
    INNER JOIN dbo.Customers AS C ON O.customer_id = C.customer_id
    WHERE 
        O.customer_id = @CustomerID
        AND CAST(O.order_date AS DATE) = CAST(GETDATE() AS DATE)
    ORDER BY O.order_date DESC;

    -- Step 2: Handle case when no records exist
    IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'No orders were placed today by this customer.';
    END
END;
GO
