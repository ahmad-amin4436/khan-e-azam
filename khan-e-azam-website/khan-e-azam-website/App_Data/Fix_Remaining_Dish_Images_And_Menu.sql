-- Khan-E-Azam Website — Remaining dish-image fixes + menu additions
-- Everything here was applied directly to the local dev DB during the session
-- but never saved to a script until now. Run this on any other database
-- (e.g. production) to bring it in line with local dev.
-- Idempotent: every statement is an UPDATE-by-name/Id, or an INSERT guarded
-- by a NOT EXISTS check, so it's safe to re-run.
USE KhanEAzamDB;
GO

-- ============================================================
-- 1) BrowseMenuItems (homepage "Browse Our Menu" carousel) —
--    was using 100x100 placeholder thumbnails, now real photos
-- ============================================================
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/dishes/burger-zinger.jpg' WHERE Name = 'Zinger Burger';
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/dishes/yakhni-pulao.jpg' WHERE Name = 'Yakhni Pulao';
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/dishes/chicken-karahi.jpg' WHERE Name = 'Chicken Karahi';
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/dishes/mutton-biryani.jpg' WHERE Name = 'Mutton Biryani';
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/dishes/seekh-kebab.jpg' WHERE Name = 'Seekh Kebab';
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/dishes/nihari-special.jpg' WHERE Name = 'Nihari Special';
GO

-- ============================================================
-- 2) BannerSlides hero food cards — were showing unrelated
--    photos (chicken skewers/doner sandwich/soup) under these names
-- ============================================================
UPDATE BannerSlides SET FoodImage = 'assets/images/menu-small/dishes/chicken-karahi.jpg' WHERE FoodCardName = 'Chicken Karahi';
UPDATE BannerSlides SET FoodImage = 'assets/images/menu-small/dishes/mutton-biryani.jpg' WHERE FoodCardName = 'Mutton Biryani';
UPDATE BannerSlides SET FoodImage = 'assets/images/menu-small/dishes/seekh-kebab.jpg' WHERE FoodCardName = 'Seekh Kebab';
GO

-- ============================================================
-- 3) TodaysSpecials — Malai Boti was showing an unrelated
--    egg-and-avocado-toast stock photo
-- ============================================================
UPDATE TodaysSpecials SET Image = 'assets/images/menu-small/dishes/malai-boti.jpg' WHERE Name = 'Malai Boti';
GO

-- ============================================================
-- 4) MenuFilterItems (full menu page + homepage "Our Menu") —
--    these 9 dishes had no matching local photo at all, so real
--    photos were sourced and saved under assets/images/menu-small/dishes/
-- ============================================================
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/burger-classic.jpg' WHERE Name = 'Grand Pa Burger';
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/burger-double-decker.jpg' WHERE Name = 'Double Dacker Burger';
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/fries-masala.jpg' WHERE Name = 'Masala Fries';
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/wings-fried.jpg' WHERE Name = 'Farai Wings';
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/pizza-spicy.jpg' WHERE Name = 'Hot and Spicy Pizza';
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/pizza-tandoori.jpg' WHERE Name = 'Tandori Pizza';
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/pizza-vegetable.jpg' WHERE Name = 'Vegetable Pizza';
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/pizza-bonefire.jpg' WHERE Name = 'Bonefire Pizza';
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/pizza-cheese-sticks.jpg' WHERE Name = 'Cheese Stick Pizza';
GO

-- ============================================================
-- 5) MenuFilterItems — paratha-chicken.jpg turned out to be a wide
--    "chef standing at a griddle" scene photo, not a dish close-up
-- ============================================================
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/paratha-roll.jpg' WHERE Name = 'Grilled Paratha Roll';
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/paratha-roll.jpg' WHERE Name = 'Chicken Paratha Roll';
UPDATE MenuFilterItems SET Image = 'assets/images/menu-small/dishes/paratha-roll.jpg' WHERE Name = 'Chicken Cheez Paratha Roll';
GO

-- ============================================================
-- 6) MenuFilterItems — tag genuinely spicy dishes so the "Spicy"
--    menu filter isn't empty (guarded so re-running won't double-append)
-- ============================================================
UPDATE MenuFilterItems SET FilterTags = FilterTags + ' spicy'
WHERE Name IN (
    'Zinger Shawarma','Zinger Cheez Shawarma','Zinger Burger','Zinger Cheez Burger',
    'Zinger Paratha Roll','Zinger Cheez Paratha Roll','Peri Peri Wings','Hot Shot',
    'Hot and Spicy Pizza','Masala Fries'
)
AND (' ' + FilterTags + ' ') NOT LIKE '% spicy %';
GO

-- ============================================================
-- 7) MenuFilterItems — Cold Drink category had zero items, so the
--    "Cold Drink" menu filter was always empty; add the real SKUs
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM MenuFilterItems WHERE Name = 'Cold Drink (350 ml)')
BEGIN
    DECLARE @base INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM MenuFilterItems);
    INSERT INTO MenuFilterItems (Name, Description, Price, Image, FilterTags, SortOrder, IsActive)
    VALUES
    ('Cold Drink (350 ml)', 'Chilled soft drink, 350 ml bottle.', 'Rs. 80', 'assets/images/menu-small/dishes/drink-350ml.jpg', 'drink', @base+1, 1),
    ('Cold Drink (500 ml)', 'Chilled soft drink, 500 ml bottle.', 'Rs. 120', 'assets/images/menu-small/dishes/drink-500ml.jpg', 'drink', @base+2, 1),
    ('Cold Drink (1.5 Litre)', 'Family-size chilled soft drink, 1.5 litre bottle.', 'Rs. 220', 'assets/images/menu-small/dishes/drink-1500ml.jpg', 'drink', @base+3, 1);
END
GO
