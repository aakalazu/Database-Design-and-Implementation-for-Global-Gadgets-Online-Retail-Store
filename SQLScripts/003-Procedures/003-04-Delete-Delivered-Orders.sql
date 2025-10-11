GO
CREATE OR ALTER PROCEDURE dbo.DeleteDeliveredOrders
AS
BEGIN
    SET NOCOUNT ON;

    -- First, delete related reviews
    DELETE FROM dbo.Reviews
    WHERE order_id IN (
        SELECT order_id FROM dbo.Orders WHERE status_id = 
            (SELECT status_id FROM dbo.OrderStatus WHERE status_name = 'Delivered')
    );

    -- Then delete the delivered orders
    DELETE FROM dbo.Orders
    WHERE status_id = (
        SELECT status_id FROM dbo.OrderStatus WHERE status_name = 'Delivered'
    );

    PRINT 'Delivered orders and associated reviews deleted successfully.';
END;
GO
