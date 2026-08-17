-- Khan-E-Azam Website — Redesign Migration (2026)
-- Run against (localdb)\MSSQLLocalDB or the configured SQL Server instance, against KhanEAzamDB.
-- Safe to re-run: every step is guarded so it only applies once.
--
-- Adds:
--   1) BannerSlides.VideoUrl        — optional looping background video per hero slide
--   2) BannerSlides reseed          — 5 rotating hero concepts (video / deals / restaurant / audience / birthday & family)
--   3) GalleryImages table + seed   — backs the new Admin-managed Gallery page
--   4) Orders.OrderType             — Dine-In / Takeaway / Fast Delivery on the Order Now flow

USE KhanEAzamDB;
GO

-- ============================================================
-- 1) BannerSlides.VideoUrl
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = N'VideoUrl' AND Object_ID = Object_ID(N'BannerSlides'))
    ALTER TABLE BannerSlides ADD VideoUrl NVARCHAR(500) NULL;
GO

-- ============================================================
-- 2) Reseed BannerSlides with the 5 rotating hero concepts
--    (video animation / deals / restaurant / audience / birthday & family functions)
-- ============================================================
DELETE FROM BannerSlides;
GO

INSERT INTO BannerSlides (TagLine, Heading, Description, BgImage, VideoUrl, FoodImage, FoodCardName, ChefName, ChefRole, ChefImage, Price, CardDescription, SortOrder, IsActive)
VALUES
('Watch Our Kitchen Come Alive', 'Crafted Live, Served with Passion', 'Step behind the scenes and watch our chefs turn hand-picked spices and fresh ingredients into the dishes Khan-e-Azam is loved for.', 'assets/images/main-slider/slider2/bg1.jpg', 'assets/video/video.mp4', 'assets/images/main-slider/slider2/pic1.png', 'Chicken Karahi', 'Ustad Farooq', 'Head Chef', 'assets/images/team/pic1.jpg', 'Rs. 850', 'Slow-cooked in aromatic spices for that signature Khan-e-Azam taste.', 1, 1),
('This Week''s Best Deal', 'Feast More, Pay Less', 'Enjoy limited-time bundle offers on our most-loved karahis, biryanis and BBQ platters — crafted for sharing.', 'assets/images/main-slider/slider2/bg2.jpg', NULL, 'assets/images/main-slider/slider2/pic2.png', 'Mutton Biryani', 'Chef Imran Ali', 'Master Chef', 'assets/images/team/pic2.jpg', 'Rs. 850', 'Fragrant basmati layered with tender mutton and slow-cooked masala.', 2, 1),
('Luxury Dining with Rooftop', 'Welcome to Khan-e-Azam', 'Experience the rich flavours of traditional Pakistani recipes in an elegant rooftop setting, crafted with hand-picked spices and time-honoured technique.', 'assets/images/main-slider/slider2/bg3.jpg', NULL, 'assets/images/main-slider/slider2/pic3.png', 'Seekh Kebab', 'Chef Aqeel Khan', 'Master Chef', 'assets/images/team/pic2.jpg', 'Rs. 850', 'Hand-minced kebabs grilled over live charcoal for that smoky finish.', 3, 1),
('Loved by Lahore', 'A Table Full of Stories', 'From family lunches to late-night gatherings, Khan-e-Azam brings people together over food worth talking about.', 'assets/images/main-slider/slider2/bg1.jpg', NULL, 'assets/images/main-slider/slider2/pic1.png', 'Chicken Karahi', 'Ustad Farooq', 'Head Chef', 'assets/images/team/pic1.jpg', 'Rs. 850', 'Our most-ordered karahi, made fresh to order every time.', 4, 1),
('Birthdays & Family Functions', 'Celebrate Every Occasion With Us', 'From birthday parties to family functions, our rooftop venue and dedicated team make every celebration memorable.', 'assets/images/main-slider/slider2/bg2.jpg', NULL, 'assets/images/main-slider/slider2/pic2.png', 'Mutton Biryani', 'Chef Imran Ali', 'Master Chef', 'assets/images/team/pic2.jpg', 'Rs. 850', 'Ask us about group menus and rooftop seating for your next event.', 5, 1);
GO

-- ============================================================
-- 3) GalleryImages
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='GalleryImages' AND xtype='U')
CREATE TABLE GalleryImages (
    Id INT PRIMARY KEY IDENTITY(1,1),
    ImageUrl NVARCHAR(500) NOT NULL,
    Caption NVARCHAR(200),
    SortOrder INT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

IF NOT EXISTS (SELECT 1 FROM GalleryImages)
BEGIN
    INSERT INTO GalleryImages (ImageUrl, Caption, SortOrder)
    VALUES
    ('assets/images/uploads/48a23dd63d904b2eb9cc17251679eb95.jpg', 'Signature dishes at Khan-e-Azam', 1),
    ('assets/images/uploads/b40086be33ec4d7e809593d68222d0a6.jpeg', 'Khan-e-Azam dining experience', 2),
    ('assets/images/menu-small/grid/pic1.png', 'Chicken Malai Boti', 3),
    ('assets/images/menu-small/grid/pic2.png', 'Mutton Karahi', 4),
    ('assets/images/menu-small/grid/pic3.png', 'Seekh Kebab Platter', 5),
    ('assets/images/menu-small/grid/pic4.png', 'Nihari & Naan', 6),
    ('assets/images/menu-small/grid/pic6.png', 'Chicken Biryani', 7),
    ('assets/images/team/pic1.jpg', 'Our kitchen team', 8);
END
GO

-- ============================================================
-- 4) Orders.OrderType (Dine-In / Takeaway / Fast Delivery)
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = N'OrderType' AND Object_ID = Object_ID(N'Orders'))
    ALTER TABLE Orders ADD OrderType NVARCHAR(30) NOT NULL DEFAULT 'Fast Delivery';
GO
