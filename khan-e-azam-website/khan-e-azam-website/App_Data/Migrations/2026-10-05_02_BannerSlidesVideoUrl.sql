/*
  Khan-E-Azam — BannerSlides.VideoUrl (2026-10-05)

  BannerSlideRepository.Map() reads BannerSlides.VideoUrl, and Default.aspx binds
  the banner repeater on every homepage load. Where the column is missing the whole
  homepage returns HTTP 500 with IndexOutOfRangeException, and the Banner Slides
  admin page fails the same way.

  Production already has this column; local databases created from an older script
  do not. This closes that gap. Idempotent and non-destructive: the column is added
  as NULL, so existing rows keep working and banners simply have no video until one
  is set.

  (The 2026-10-03_02_VerifyAndIndex script already warns about this; this applies
  the fix it recommends.)
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

PRINT '--- BannerSlides.VideoUrl migration starting ---';

DECLARE @banner INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.BannerSlides'),
                               OBJECT_ID('dbo.BannerSlides'));

IF @banner IS NULL
    PRINT 'SKIP: BannerSlides table not found.';
ELSE IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = @banner AND name = 'VideoUrl')
    PRINT 'Column BannerSlides.VideoUrl already present.';
ELSE
BEGIN
    DECLARE @sql NVARCHAR(MAX) =
        'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(@banner)) + '.' + QUOTENAME(OBJECT_NAME(@banner))
        + ' ADD VideoUrl NVARCHAR(500) NULL';
    EXEC sp_executesql @sql;
    PRINT 'Added column BannerSlides.VideoUrl on ' + OBJECT_SCHEMA_NAME(@banner) + '.';
END

PRINT '--- BannerSlides.VideoUrl migration complete ---';
GO
