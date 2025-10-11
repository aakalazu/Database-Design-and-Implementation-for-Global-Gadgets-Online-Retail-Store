
GO
CREATE OR ALTER PROCEDURE dbo.UpdateSupplierDetailsFlexible
    @SupplierID INT,
    @SupplierName NVARCHAR(100) = NULL,
    @ContactName NVARCHAR(100) = NULL,
    @Phone NVARCHAR(20) = NULL,
    @Email NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.Suppliers WHERE supplier_id = @SupplierID)
    BEGIN
        PRINT 'Error: Supplier not found.';
        RETURN;
    END

    UPDATE dbo.Suppliers
    SET 
        supplier_name = COALESCE(@SupplierName, supplier_name),
        contact_name = COALESCE(@ContactName, contact_name),
        phone_number = COALESCE(@Phone, phone_number),
        email = COALESCE(@Email, email)
    WHERE supplier_id = @SupplierID;

    PRINT 'Supplier details updated successfully.';
END;
GO
