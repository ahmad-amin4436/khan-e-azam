/*
  Khan-E-Azam — order status history / audit trail (2026-10-03)

  Adds OrderStatusHistory: one row per status change, so cancellations (and every
  other transition) keep a permanent record of what changed, when, by whom and why.
  Previously UpdateStatus overwrote Orders.Status in place with no trace.

  Idempotent and non-destructive: safe to re-run.

  SCHEMA NOTE
  -----------
  As with the other migrations, the table is created in the caller's default schema
  so the application's unqualified SQL resolves to it. On the production server the
  app login's default schema is 'khaneazam', not dbo.
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

PRINT '--- Order status history migration starting ---';
PRINT 'Default schema for this login: ' + SCHEMA_NAME();

-- 1. The history table -------------------------------------------------------
IF COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.OrderStatusHistory'),
            OBJECT_ID('dbo.OrderStatusHistory')) IS NULL
BEGIN
    DECLARE @sql NVARCHAR(MAX) =
        'CREATE TABLE ' + QUOTENAME(SCHEMA_NAME()) + '.OrderStatusHistory
         (
             Id           INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_OrderStatusHistory PRIMARY KEY,
             OrderId      INT            NOT NULL,
             OldStatus    NVARCHAR(50)   NULL,          -- NULL for the order-placed entry
             NewStatus    NVARCHAR(50)   NOT NULL,
             ChangedBy    NVARCHAR(200)  NULL,          -- admin username, or NULL for system/customer
             ChangedByRole NVARCHAR(50)  NULL,
             Reason       NVARCHAR(500)  NULL,          -- required by the UI for cancellations
             ChangedAt    DATETIME       NOT NULL CONSTRAINT DF_OrderStatusHistory_ChangedAt DEFAULT (GETDATE())
         )';
    EXEC sp_executesql @sql;
    PRINT 'Created table OrderStatusHistory in schema ' + SCHEMA_NAME() + '.';
END
ELSE
    PRINT 'Table OrderStatusHistory already present; left untouched.';
GO

-- 2. Index for reading one order's trail in order -----------------------------
DECLARE @hist INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.OrderStatusHistory'),
                             OBJECT_ID('dbo.OrderStatusHistory'));
IF @hist IS NOT NULL
   AND NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_OrderStatusHistory_Order' AND object_id = @hist)
BEGIN
    DECLARE @sql NVARCHAR(MAX) =
        'CREATE NONCLUSTERED INDEX IX_OrderStatusHistory_Order ON '
        + QUOTENAME(OBJECT_SCHEMA_NAME(@hist)) + '.' + QUOTENAME(OBJECT_NAME(@hist))
        + ' (OrderId, ChangedAt)';
    EXEC sp_executesql @sql;
    PRINT 'Created index IX_OrderStatusHistory_Order.';
END
ELSE
    PRINT 'Index IX_OrderStatusHistory_Order already present (or table missing).';
GO

-- 3. Seed a baseline entry for orders that predate the audit trail -------------
-- Without this, existing orders would show an empty history, implying they were
-- never touched. One synthetic "as at migration" row records their current status
-- without inventing a history that was never captured.
DECLARE @hist   INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.OrderStatusHistory'), OBJECT_ID('dbo.OrderStatusHistory'));
DECLARE @orders INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.Orders'),             OBJECT_ID('dbo.Orders'));

IF @hist IS NOT NULL AND @orders IS NOT NULL
BEGIN
    DECLARE @h NVARCHAR(300) = QUOTENAME(OBJECT_SCHEMA_NAME(@hist))   + '.' + QUOTENAME(OBJECT_NAME(@hist));
    DECLARE @o NVARCHAR(300) = QUOTENAME(OBJECT_SCHEMA_NAME(@orders)) + '.' + QUOTENAME(OBJECT_NAME(@orders));
    DECLARE @sql NVARCHAR(MAX) =
        N'INSERT INTO ' + @h + N' (OrderId, OldStatus, NewStatus, ChangedBy, ChangedByRole, Reason, ChangedAt)
          SELECT o.Id, NULL, o.Status, NULL, NULL,
                 ''Baseline recorded when the audit trail was introduced; earlier changes were not captured.'',
                 o.UpdatedAt
          FROM ' + @o + N' o
          WHERE NOT EXISTS (SELECT 1 FROM ' + @h + N' h WHERE h.OrderId = o.Id)';
    EXEC sp_executesql @sql;
    PRINT 'Seeded baseline history rows for pre-existing orders (' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ' row(s)).';
END
GO

PRINT '--- Order status history migration complete ---';
GO
