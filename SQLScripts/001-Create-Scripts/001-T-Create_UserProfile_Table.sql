USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[UserProfile]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
--===============| Create UserProfile Table |===============--

CREATE TABLE [dbo].[UserProfile](

    [profile_id]     INT IDENTITY(2000,1)       NOT NULL,
    [user_id]        INT                        NOT NULL,
    [full_name]      NVARCHAR(100)              NOT NULL,
    [date_of_birth]  DATE                       NOT NULL,
    [billing_address] NVARCHAR(250)             NOT NULL,
    [email]          NVARCHAR(100)              NULL,
    [phone_number]   NVARCHAR(20)               NULL,
    [last_login]     DATETIME                   NULL,
    [last_logout]    DATETIME                   NULL,

    -- PK
    CONSTRAINT [PK_UserProfile_ProfileID] PRIMARY KEY CLUSTERED 
        ([profile_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK
    CONSTRAINT [FK_UserProfile_UserAccount] FOREIGN KEY([user_id])
        REFERENCES [dbo].[UserAccount] ([user_id])
        ON DELETE CASCADE
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Adding CHECK Constraints |===============--

-- Full name cannot be empty
ALTER TABLE dbo.UserProfile
ADD CONSTRAINT CK_UserProfile_FullName_NotEmpty
    CHECK (LEN(LTRIM(RTRIM(full_name))) > 0)
GO

-- Date of birth must be in the past
ALTER TABLE dbo.UserProfile
ADD CONSTRAINT CK_UserProfile_DOB_Past
    CHECK (date_of_birth < GETDATE())
GO

-- Phone number must be at least 7 characters if provided
ALTER TABLE dbo.UserProfile
ADD CONSTRAINT CK_UserProfile_Phone_Length
    CHECK (phone_number IS NULL OR LEN(phone_number) >= 7)
GO

-- Last logout must be NULL or after last login
ALTER TABLE dbo.UserProfile
ADD CONSTRAINT CK_UserProfile_LastLogOut 
    CHECK (last_logout IS NULL OR last_logout > last_login)
GO
