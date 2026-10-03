/*
  Khan-E-Azam — schema migration (2026-10-03)

  Brings a database up to the schema the current application code expects.
  Idempotent: every step is guarded, so this is safe to re-run and safe to run
  against a database that is already up to date.

  Covers four gaps found during deployment verification:
    1. AdminUsers.Role           — drives all admin role-based access control.
    2. Orders.OrderType          — read/written by OrderRepository and the admin Type filter.
    3. QuickRequests table       — backs the homepage "Quick Order Request" form.
    4. TableReservations table   — backs the Reservation page form.

  SCHEMA NOTE
  -----------
  The application's SQL is unqualified (e.g. "SELECT * FROM QuickRequests"), so each
  table resolves against the login's DEFAULT SCHEMA at runtime. These are not the same
  everywhere:

      local  : everything in dbo
      live   : Orders/AdminUsers in dbo, but QuickRequests/TableReservations/GalleryImages
               in the 'khaneazam' schema (that login's default schema)

  So this script resolves each table the way the application does -- through the caller's
  default schema first, then dbo -- instead of hard-coding "dbo.". Hard-coding dbo here
  would create a second, EMPTY dbo.QuickRequests on the live server that shadows the real
  khaneazam.QuickRequests for some logins and silently hides existing rows.
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

PRINT '--- Schema migration starting ---';

-- Resolve each table the way the app's unqualified SQL does.
DECLARE @adminUsers       SYSNAME = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.AdminUsers'),        OBJECT_ID('dbo.AdminUsers'));
DECLARE @orders           SYSNAME = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.Orders'),            OBJECT_ID('dbo.Orders'));
DECLARE @quickRequests    INT     = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.QuickRequests'),     OBJECT_ID('dbo.QuickRequests'));
DECLARE @tableReservations INT    = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.TableReservations'), OBJECT_ID('dbo.TableReservations'));

PRINT 'Default schema for this login: ' + SCHEMA_NAME();
GO

-- 1. AdminUsers.Role ---------------------------------------------------------
-- Every admin page gates on this. Accounts that predate the column default to
-- 'Staff'; the lowest-numbered (original) account is promoted to SuperAdmin so
-- the Dashboard, content management and Admin Users remain reachable after
-- deployment -- without this, a database with no Role column locks everyone out.
DECLARE @t INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.AdminUsers'), OBJECT_ID('dbo.AdminUsers'));
DECLARE @sql NVARCHAR(MAX);

IF @t IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = @t AND name = 'Role')
BEGIN
    SET @sql = 'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(@t)) + '.' + QUOTENAME(OBJECT_NAME(@t)) +
               ' ADD Role NVARCHAR(50) NOT NULL CONSTRAINT DF_AdminUsers_Role DEFAULT (''Staff'')';
    EXEC sp_executesql @sql;
    PRINT 'Added column AdminUsers.Role (default ''Staff'') on ' + OBJECT_SCHEMA_NAME(@t) + '.';
END
ELSE IF @t IS NULL
    PRINT 'SKIP: AdminUsers table not found.';
ELSE
    PRINT 'Column AdminUsers.Role already present.';
GO

-- Separate batch: the column must exist before it can be referenced.
DECLARE @t INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.AdminUsers'), OBJECT_ID('dbo.AdminUsers'));
DECLARE @sql NVARCHAR(MAX), @n INT;

IF @t IS NOT NULL AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = @t AND name = 'Role')
BEGIN
    DECLARE @tbl NVARCHAR(300) = QUOTENAME(OBJECT_SCHEMA_NAME(@t)) + '.' + QUOTENAME(OBJECT_NAME(@t));

    SET @sql = N'SELECT @cnt = COUNT(*) FROM ' + @tbl + N' WHERE Role = ''SuperAdmin''';
    EXEC sp_executesql @sql, N'@cnt INT OUTPUT', @cnt = @n OUTPUT;

    IF @n = 0
    BEGIN
        SET @sql = N'UPDATE ' + @tbl + N' SET Role = ''SuperAdmin'' WHERE Id = (SELECT MIN(Id) FROM ' + @tbl + N')';
        EXEC sp_executesql @sql;
        PRINT 'Promoted the original admin account to SuperAdmin (no SuperAdmin existed).';
    END
    ELSE
        PRINT 'A SuperAdmin already exists; no change.';
END
GO

-- 2. Orders.OrderType --------------------------------------------------------
-- Existing rows predate the column; 'Fast Delivery' matches the app's own default.
DECLARE @t INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.Orders'), OBJECT_ID('dbo.Orders'));
DECLARE @sql NVARCHAR(MAX);

IF @t IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = @t AND name = 'OrderType')
BEGIN
    SET @sql = 'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(@t)) + '.' + QUOTENAME(OBJECT_NAME(@t)) +
               ' ADD OrderType NVARCHAR(30) NOT NULL CONSTRAINT DF_Orders_OrderType DEFAULT (''Fast Delivery'')';
    EXEC sp_executesql @sql;
    PRINT 'Added column Orders.OrderType (default ''Fast Delivery'') on ' + OBJECT_SCHEMA_NAME(@t) + '.';
END
ELSE IF @t IS NULL
    PRINT 'SKIP: Orders table not found.';
ELSE
    PRINT 'Column Orders.OrderType already present.';
GO

-- 3. QuickRequests -----------------------------------------------------------
-- Created in the caller's default schema so unqualified app SQL resolves to it.
IF COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.QuickRequests'), OBJECT_ID('dbo.QuickRequests')) IS NULL
BEGIN
    DECLARE @sql NVARCHAR(MAX) =
        'CREATE TABLE ' + QUOTENAME(SCHEMA_NAME()) + '.QuickRequests
         (
             Id            INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_QuickRequests PRIMARY KEY,
             FullName      NVARCHAR(200)  NOT NULL,
             ContactNumber NVARCHAR(40)   NOT NULL,
             OrderType     NVARCHAR(50)   NOT NULL,
             CreatedAt     DATETIME       NOT NULL CONSTRAINT DF_QuickRequests_CreatedAt DEFAULT (GETDATE())
         )';
    EXEC sp_executesql @sql;
    PRINT 'Created table QuickRequests in schema ' + SCHEMA_NAME() + '.';
END
ELSE
    PRINT 'Table QuickRequests already present in '
          + OBJECT_SCHEMA_NAME(COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.QuickRequests'), OBJECT_ID('dbo.QuickRequests')))
          + '; left untouched.';
GO

-- 4. TableReservations -------------------------------------------------------
IF COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.TableReservations'), OBJECT_ID('dbo.TableReservations')) IS NULL
BEGIN
    DECLARE @sql NVARCHAR(MAX) =
        'CREATE TABLE ' + QUOTENAME(SCHEMA_NAME()) + '.TableReservations
         (
             Id              INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_TableReservations PRIMARY KEY,
             FullName        NVARCHAR(200)  NOT NULL,
             ContactNumber   NVARCHAR(40)   NOT NULL,
             ReservationDate DATE           NOT NULL,
             ReservationTime NVARCHAR(40)   NOT NULL,
             PartySize       INT            NOT NULL CONSTRAINT DF_TableReservations_PartySize DEFAULT (1),
             SpecialRequests NVARCHAR(1000) NULL,
             CreatedAt       DATETIME       NOT NULL CONSTRAINT DF_TableReservations_CreatedAt DEFAULT (GETDATE())
         )';
    EXEC sp_executesql @sql;
    PRINT 'Created table TableReservations in schema ' + SCHEMA_NAME() + '.';
END
ELSE
    PRINT 'Table TableReservations already present in '
          + OBJECT_SCHEMA_NAME(COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.TableReservations'), OBJECT_ID('dbo.TableReservations')))
          + '; left untouched.';
GO

PRINT '--- Schema migration complete ---';
GO
