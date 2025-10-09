USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[Employees]    Script Date: 10-Oct-25 12:25:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Employees](
	[employee_id] [int] IDENTITY(1000,1) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[email] [nvarchar](100) NULL,
	[phone_number] [nvarchar](20) NULL,
	[department_id] [int] NOT NULL,
	[hire_date] [date] NOT NULL,
	[role_id] [int] NOT NULL,
 CONSTRAINT [PK_Employees_EmployeeID] PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Employees] ADD  DEFAULT (getdate()) FOR [hire_date]
GO

ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Departments] FOREIGN KEY([department_id])
REFERENCES [dbo].[Departments] ([department_id])
GO

ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Departments]
GO

ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([role_id])
GO

ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Roles]
GO

ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [CK_Employees_FirstName] CHECK  ((len(ltrim(rtrim([first_name])))>(0)))
GO

ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CK_Employees_FirstName]
GO

ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [CK_Employees_LastName] CHECK  ((len(ltrim(rtrim([last_name])))>(0)))
GO

ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [CK_Employees_LastName]
GO


