USE [GlobalGadgetsDB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
--===============| OrderStatus Table |===============--

CREATE TABLE [dbo].[OrderStatus](
    [status_id] INT IDENTITY(1,1) PRIMARY KEY,
    [status_name] NVARCHAR(50) NOT NULL UNIQUE
);

---------------------------------------------------------------
-- Insert Default Status Values
---------------------------------------------------------------
INSERT INTO [dbo].[OrderStatus] (status_name) VALUES
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled'),
('Returned');
GO
