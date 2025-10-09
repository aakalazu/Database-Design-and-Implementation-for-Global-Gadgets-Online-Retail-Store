USE [GlobalGadgetsDB]
GO

/****** Object:  Table [dbo].[UserAccount]    Script Date: 10/1/2025 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------
--===============| Create UserAccount Table |===============--

CREATE TABLE [dbo].[UserAccount](

    [user_id]       INT IDENTITY(1000,1)      NOT NULL,
    [username]      NVARCHAR(50)              NOT NULL,
    [password_hash] NVARCHAR(200)             NOT NULL,
    [role_id]       INT                       NOT NULL,
    [account_status] NVARCHAR(20)             NOT NULL DEFAULT('Active'),
    [created_at]    DATETIME                  NOT NULL DEFAULT(GETDATE()),
    [deactivated_at] DATETIME                 NULL,

    -- PK
    CONSTRAINT [PK_UserAccount_UserID] PRIMARY KEY CLUSTERED 
        ([user_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
              IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, 
              ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],

    -- FK
    CONSTRAINT [FK_UserAccount_Role] FOREIGN KEY([role_id])
        REFERENCES [dbo].[Role] ([role_id])
        ON DELETE CASCADE
) ON [PRIMARY]
GO

----------------------------------------------------------------------------------
--===============| Create Unique Nonclustered Index for Username |===============--
SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_UserAccount_Username] 
    ON [dbo].[UserAccount] ([username] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, 
          SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, 
          DROP_EXISTING = OFF, ONLINE = OFF, 
          ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, 
          OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

--===============| Adding CHECK Constraints |===============--
ALTER TABLE dbo.UserAccount
ADD CONSTRAINT CK_UserAccount_Status 
    CHECK (account_status IN ('Active', 'Inactive', 'Suspended'))
GO

ALTER TABLE dbo.UserAccount
ADD CONSTRAINT CK_UserAccount_Username_NotEmpty
    CHECK (LEN(LTRIM(RTRIM(username))) > 0)
GO

ALTER TABLE dbo.UserAccount
ADD CONSTRAINT CK_UserAccount_Password_NotEmpty
    CHECK (LEN(LTRIM(RTRIM(password_hash))) > 0)
GO
