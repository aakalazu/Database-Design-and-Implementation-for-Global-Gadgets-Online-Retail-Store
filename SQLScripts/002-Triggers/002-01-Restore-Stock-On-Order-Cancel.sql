GO
CREATE TRIGGER trg_RestoreStockOnOrderCancel
ON dbo.Orders
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if order status changed to 'Cancelled'
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN dbo.OrderStatus os ON i.status_id = os.status_id
        WHERE os.status_name = 'Cancelled'
    )
    BEGIN
        INSERT INTO dbo.Inventory (product_id, quantity, movement_type, notes)
        SELECT 
            oi.product_id,
            oi.quantity,
            'IN',
            CONCAT('Restock from cancelled order ', i.order_id)
        FROM inserted i
        JOIN dbo.OrderItems oi ON i.order_id = oi.order_id
        JOIN dbo.OrderStatus os ON i.status_id = os.status_id
        WHERE os.status_name = 'Cancelled';
    END
END;
GO
