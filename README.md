# GlobalGadgetsDB
## Project Overview
A comprehensive SQL Server-based database project designed for an online retail store (Global Gadgets). The database was developed using SQL Server Management Studio (SSMS), the project includes custom stored procedures, functions, and triggers which encapsulate and centralize business logic within the database and ensures data integrity.
## Features
- Comprehensive Product Categorization: Products are organized in a three-level hierarchy: Category → Subcategory → Sub-subcategory. This allows flexible classification and easier searching, filtering, and reporting of product types such as “Premium Electronics” or “Home Appliances”.
- Order Management System: Supports full order processing through Orders and OrderItems tables. Tracks customer details, order dates, quantities, prices, order status, shipping method, and payment method — ensuring accurate record-keeping of sales transactions.
- Inventory Tracking with Movement History: The Inventory table records stock movements as IN, OUT, or ADJUST, rather than a single stock count. This feature provides an audit trail for all stock changes, ensuring transparency and preventing discrepancies in product availability.
- Integrated Customer and Review Management: Customers are linked to UserAccount and Role tables for secure authentication and authorization. The Reviews table enables customers to give product feedback only after an order is delivered, maintaining data validity and customer trust.
- Automated Business Logic and Data Integrity Enforcement: Includes triggers (e.g., restocking inventory on order cancellation), stored procedures (e.g., searching products, updating suppliers), and constraints (e.g., positive prices, valid movement types). These ensure business rules are consistently applied and data remains accurate across all operations.
## Database Schema
The GlobalGadgetsDB database, the operational foundation for the online retail business, is composed of 18 tables designed to manage everything from product listings and inventory to customer orders, payments, and administrative functions. Below is a visual representation of the database schema: 

<img width="1450" height="840" alt="ERD_GLOBALGADGETSDB" src="https://github.com/user-attachments/assets/ae7b1d13-48a1-440c-9a25-1241cdcc313e" />

## Key Tables (grouped logically by functional area for clarity)
Customer & User Management
- Customers – Stores customer personal information and contact details.
- UserAccount – Manages login credentials and access information for system users.
- Role – Defines user roles such as Admin, Customer, Employee, etc.

Employee & Department Structure
- Employees – Contains details of company staff members.
- Departments – Defines the department structure to which employees belong.

Product & Supplier Management
- Products – Central table for all product details (SKU, price, supplier, etc.).
- ProductCategory – Top-level product classification (e.g., Electronics).
- Suppliers – Contains supplier company details for sourcing products.
- Inventory – Tracks product stock movements (IN, OUT, ADJUST).

Order & Payment Processing
- Orders – Records customer orders, dates, and shipping methods.
- OrderItems – Links products to specific orders, including quantity and price.
- OrderStatus – Defines order progress states (e.g., Pending, Delivered, Cancelled).
- Payments – Logs payment details for each order.

## SQL Scripts
The repository includes SQL scripts for all database objects, including tables, views, stored procedures, functions, and triggers. These scripts are located in the sql/ folder.
## Functions and Procedures
### Scalar Functions
- dbo.fn_GetCustomerAge	Calculates the age of a customer based on their date of birth.
- dbo.fn_CalculateOrderTotal	Returns the total cost of an order by summing up quantities × prices from the OrderItems table.
- dbo.fn_GetProductStockLevel	Returns the current stock level for a product by calculating total IN - OUT from Inventory.
### Table-Valued Functions (TVFs)
- dbo.fn_GetProductsByCategory(@CategoryName NVARCHAR(100))	Returns a list of products that belong to a specified product category.
- dbo.fn_GetCustomerOrders(@CustomerID INT)	Returns all orders (and order details) placed by a specific customer.
### Stored Procedures
- dbo.SearchProductsByName (@SearchTerm NVARCHAR(100))	Searches for products whose names match a given keyword; results sorted by most recent OrderDate.
- dbo.GetCustomerProductsOrderedToday (@CustomerID INT)	Returns full list of products ordered today by a specific customer, including supplier details.
- dbo.UpdateSupplierDetailsFlexible (@SupplierID INT, @NewName NVARCHAR(100), @NewContact NVARCHAR(100), @NewEmail NVARCHAR(100), @NewPhone NVARCHAR(20))	Updates supplier details dynamically for an existing supplier record.
- dbo.DeleteDeliveredOrders	Deletes orders marked as Delivered along with their dependencies (subject to foreign key constraints).
- dbo.InsertNewOrder (@CustomerID INT, @ProductID INT, @Quantity INT, @PaymentMethodID INT, @ShippingMethodID INT)	Inserts a new order and related order items, automatically calculating totals.
- dbo.GenerateSalesReport (@StartDate DATE, @EndDate DATE)	Returns sales summary (total revenue, order count) between specific dates.
### Triggers
- trg_UpdateInventoryOnCancel	When an order is cancelled, increases inventory stock for each ordered product (making stock available again).
- trg_UpdateInventoryOnInsertOrderItem	When a new order item is added, automatically decreases product stock in Inventory.
- trg_LogProductPriceChange	Records any product price change event in an audit or log table (if implemented).
## License
This project is licensed under the MIT License.
## Contact
For any questions or suggestions, please contact aakalazu@gmail.com.

