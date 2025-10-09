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
