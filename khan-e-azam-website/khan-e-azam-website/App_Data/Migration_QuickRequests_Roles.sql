-- Khan-E-Azam Website — Quick Requests + Admin Roles Migration
-- Run against the configured SQL Server instance, against KhanEAzamDB.
-- Safe to re-run: every step is guarded so it only applies once.
--
-- Adds:
--   1) QuickRequests table   — homepage "Quick Order Request" form (Name/Phone/OrderType)
--   2) AdminUsers.Role       — SuperAdmin / Manager / Staff, backs Admin > Users management

USE KhanEAzamDB;
GO

-- ============================================================
-- 1) QuickRequests
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='QuickRequests' AND xtype='U')
CREATE TABLE QuickRequests (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(150) NOT NULL,
    ContactNumber NVARCHAR(30) NOT NULL,
    OrderType NVARCHAR(30) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- ============================================================
-- 2) AdminUsers.Role
--    Existing admin accounts default to SuperAdmin (full access, incl. user management).
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = N'Role' AND Object_ID = Object_ID(N'AdminUsers'))
    ALTER TABLE AdminUsers ADD Role NVARCHAR(30) NOT NULL DEFAULT 'SuperAdmin';
GO
