USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[Departments]    Script Date: 10-Oct-25 12:27:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Departments](
	[department_id] [int] IDENTITY(100,100) NOT NULL,
	[department_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Departments_DepartmentID] PRIMARY KEY CLUSTERED 
(
	[department_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [CK_Departments_DepartmentName] CHECK  ((len(ltrim(rtrim([department_name])))>(0)))
GO

ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [CK_Departments_DepartmentName]
GO
