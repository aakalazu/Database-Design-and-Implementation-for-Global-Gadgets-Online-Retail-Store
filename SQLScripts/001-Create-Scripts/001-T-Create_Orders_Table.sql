USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[Orders]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
--===============| Create Orders Table |===============--

CREATE TABLE [dbo].[Orders](

 [order_id] [int] IDENTITY(20000,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[order_date] [datetime] NOT NULL,
	[status_id] [int] NOT NULL,
	[total_amount] [decimal](10, 2) NOT NULL,
	[shipping_method_id] [int] NOT NULL,
	[employee_id] [int] NULL,
	[tracking_number] [nvarchar](50) NOT NULL,

    -- PK
    CONSTRAINT [PK_Orders_ID] PRIMARY KEY CLUSTERED 
        ([order_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

  ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [order_date]
GO

ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((1)) FOR [shipping_method_id]
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customer]
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([employee_id])
REFERENCES [dbo].[Employees] ([employee_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_ShippingMethod] FOREIGN KEY([shipping_method_id])
REFERENCES [dbo].[ShippingMethod] ([shipping_method_id])
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_ShippingMethod]
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Status] FOREIGN KEY([status_id])
REFERENCES [dbo].[OrderStatus] ([status_id])
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Status]
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [CK_Orders_TotalAmount] CHECK  (([total_amount]>=(0)))
GO

ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [CK_Orders_TotalAmount]
GO
