/*
  Khan-E-Azam — Admin filter/sort release (2026-10-03)
  Verification + indexes. Safe to re-run; makes no destructive changes.

  The admin filter/sort work added NO new tables or columns. Every new query reads
  columns that already exist. This script therefore does two things:

    1. VERIFY  — fails loudly if anything the new admin queries depend on is missing.
    2. OPTIMISE — adds non-clustered indexes covering the new filter/sort paths.
                  Index creation is guarded, so re-running is a no-op.

  Like the schema script, tables are resolved through the caller's default schema
  first and then dbo, matching how the application's unqualified SQL resolves them.
*/

SET NOCOUNT ON;

DECLARE @errors INT = 0;
DECLARE @msg NVARCHAR(400);

PRINT '--- Verifying schema required by the admin filter/sort release ---';
PRINT 'Default schema for this login: ' + SCHEMA_NAME();

-- Resolve the tables the way the application does.
DECLARE @adminUsers INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.AdminUsers'),        OBJECT_ID('dbo.AdminUsers'));
DECLARE @orders     INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.Orders'),            OBJECT_ID('dbo.Orders'));
DECLARE @quick      INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.QuickRequests'),     OBJECT_ID('dbo.QuickRequests'));
DECLARE @reserv     INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.TableReservations'), OBJECT_ID('dbo.TableReservations'));

-- Required columns, per table.
DECLARE @req TABLE (TblKey VARCHAR(20), ObjId INT, ColName SYSNAME);

INSERT INTO @req (TblKey, ObjId, ColName)
SELECT 'AdminUsers', @adminUsers, v FROM (VALUES ('Id'),('Username'),('PasswordHash'),('Role')) x(v)
UNION ALL
SELECT 'Orders', @orders, v FROM (VALUES
    ('Id'),('CustomerName'),('CustomerPhone'),('OrderType'),
    ('PaymentMethod'),('Status'),('TotalAmount'),('CreatedAt')) x(v)
UNION ALL
SELECT 'QuickRequests', @quick, v FROM (VALUES
    ('Id'),('FullName'),('ContactNumber'),('OrderType'),('CreatedAt')) x(v)
UNION ALL
SELECT 'TableReservations', @reserv, v FROM (VALUES
    ('Id'),('FullName'),('ContactNumber'),('ReservationDate'),
    ('ReservationTime'),('PartySize'),('SpecialRequests'),('CreatedAt')) x(v);

-- Missing tables.
SELECT @errors = @errors + COUNT(*) FROM (
    SELECT DISTINCT TblKey FROM @req WHERE ObjId IS NULL
) m;

SELECT 'FAIL: table ' + TblKey + ' is missing.' AS Problem
FROM (SELECT DISTINCT TblKey FROM @req WHERE ObjId IS NULL) m;

-- Missing columns on tables that do exist.
SELECT @errors = @errors + COUNT(*)
FROM @req r
WHERE r.ObjId IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM sys.columns c WHERE c.object_id = r.ObjId AND c.name = r.ColName);

SELECT 'FAIL: ' + r.TblKey + '.' + r.ColName + ' is missing.' AS Problem
FROM @req r
WHERE r.ObjId IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM sys.columns c WHERE c.object_id = r.ObjId AND c.name = r.ColName);

-- At least one SuperAdmin must exist, or the admin area is unreachable for everyone.
IF @adminUsers IS NOT NULL
   AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = @adminUsers AND name = 'Role')
BEGIN
    DECLARE @sa INT, @q NVARCHAR(MAX) =
        N'SELECT @c = COUNT(*) FROM ' + QUOTENAME(OBJECT_SCHEMA_NAME(@adminUsers)) + N'.' +
        QUOTENAME(OBJECT_NAME(@adminUsers)) + N' WHERE Role = ''SuperAdmin''';
    EXEC sp_executesql @q, N'@c INT OUTPUT', @c = @sa OUTPUT;

    IF @sa = 0
    BEGIN
        PRINT 'FAIL: no account has Role = SuperAdmin -- the Dashboard, content management';
        PRINT '      and Admin Users pages would be unreachable for everyone.';
        SET @errors += 1;
    END
END

IF @errors > 0
BEGIN
    RAISERROR('Schema verification FAILED: %d problem(s). Deployment should be stopped.', 16, 1, @errors);
    RETURN;
END

PRINT 'OK: all tables/columns required by the new admin queries are present.';

-- Advisory only (does not block deployment) ----------------------------------
-- BannerSlideRepository.Map() reads BannerSlides.VideoUrl. Where that column is
-- missing the Banner Slides admin page throws IndexOutOfRangeException on load.
-- This is pre-existing and unrelated to the filter/sort release.
DECLARE @banner INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.BannerSlides'), OBJECT_ID('dbo.BannerSlides'));
IF @banner IS NOT NULL
   AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = @banner AND name = 'VideoUrl')
BEGIN
    PRINT '';
    PRINT 'WARNING (pre-existing, not part of this release):';
    PRINT '  BannerSlides.VideoUrl is missing but BannerSlideRepository reads it.';
    PRINT '  The Banner Slides admin page will error until the column is added:';
    PRINT '    ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(@banner)) + '.BannerSlides ADD VideoUrl NVARCHAR(500) NULL;';
    PRINT '';
END
GO

-- 2. OPTIMISE ---------------------------------------------------------------
-- The admin lists sort by date and filter by status/type most often.
SET NOCOUNT ON;

DECLARE @orders INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.Orders'),            OBJECT_ID('dbo.Orders'));
DECLARE @quick  INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.QuickRequests'),     OBJECT_ID('dbo.QuickRequests'));
DECLARE @reserv INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.TableReservations'), OBJECT_ID('dbo.TableReservations'));
DECLARE @sql NVARCHAR(MAX), @full NVARCHAR(300);

IF @orders IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Orders_CreatedAt' AND object_id=@orders)
BEGIN
    SET @full = QUOTENAME(OBJECT_SCHEMA_NAME(@orders)) + '.' + QUOTENAME(OBJECT_NAME(@orders));
    SET @sql = 'CREATE NONCLUSTERED INDEX IX_Orders_CreatedAt ON ' + @full + ' (CreatedAt DESC)';
    EXEC sp_executesql @sql;
    PRINT 'Created index IX_Orders_CreatedAt.';
END
ELSE PRINT 'Index IX_Orders_CreatedAt already present (or Orders missing).';

IF @orders IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Orders_Status' AND object_id=@orders)
BEGIN
    SET @full = QUOTENAME(OBJECT_SCHEMA_NAME(@orders)) + '.' + QUOTENAME(OBJECT_NAME(@orders));
    SET @sql = 'CREATE NONCLUSTERED INDEX IX_Orders_Status ON ' + @full + ' (Status) INCLUDE (CreatedAt)';
    EXEC sp_executesql @sql;
    PRINT 'Created index IX_Orders_Status.';
END
ELSE PRINT 'Index IX_Orders_Status already present (or Orders missing).';

IF @quick IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_QuickRequests_CreatedAt' AND object_id=@quick)
BEGIN
    SET @full = QUOTENAME(OBJECT_SCHEMA_NAME(@quick)) + '.' + QUOTENAME(OBJECT_NAME(@quick));
    SET @sql = 'CREATE NONCLUSTERED INDEX IX_QuickRequests_CreatedAt ON ' + @full + ' (CreatedAt DESC)';
    EXEC sp_executesql @sql;
    PRINT 'Created index IX_QuickRequests_CreatedAt.';
END
ELSE PRINT 'Index IX_QuickRequests_CreatedAt already present (or QuickRequests missing).';

IF @reserv IS NOT NULL AND NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_TableReservations_Date' AND object_id=@reserv)
BEGIN
    SET @full = QUOTENAME(OBJECT_SCHEMA_NAME(@reserv)) + '.' + QUOTENAME(OBJECT_NAME(@reserv));
    SET @sql = 'CREATE NONCLUSTERED INDEX IX_TableReservations_Date ON ' + @full + ' (ReservationDate, ReservationTime)';
    EXEC sp_executesql @sql;
    PRINT 'Created index IX_TableReservations_Date.';
END
ELSE PRINT 'Index IX_TableReservations_Date already present (or TableReservations missing).';

PRINT '--- Migration complete ---';
GO
