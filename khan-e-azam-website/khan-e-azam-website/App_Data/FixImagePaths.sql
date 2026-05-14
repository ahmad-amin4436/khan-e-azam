-- Fix image paths to match actual files on disk
-- Run this against KhanEAzamDB

USE KhanEAzamDB;
GO

-- Fix BannerSlides image paths
UPDATE BannerSlides SET BgImage = 'assets/images/main-slider/slider2/bg1.jpg', FoodImage = 'assets/images/main-slider/slider2/pic1.png', ChefImage = 'assets/images/team/pic1.jpg' WHERE SortOrder = 1;
UPDATE BannerSlides SET BgImage = 'assets/images/main-slider/slider2/bg2.jpg', FoodImage = 'assets/images/main-slider/slider2/pic2.png', ChefImage = 'assets/images/team/pic2.jpg' WHERE SortOrder = 2;
UPDATE BannerSlides SET BgImage = 'assets/images/main-slider/slider2/bg3.jpg', FoodImage = 'assets/images/main-slider/slider2/pic3.png', ChefImage = 'assets/images/team/pic2.jpg' WHERE SortOrder = 3;
GO

-- Fix BrowseMenuItems image paths
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/pic1.png' WHERE SortOrder = 1;
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/pic2.png' WHERE SortOrder = 2;
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/pic3.png' WHERE SortOrder = 3;
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/pic4.png' WHERE SortOrder = 4;
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/pic5.png' WHERE SortOrder = 5;
UPDATE BrowseMenuItems SET Image = 'assets/images/menu-small/pic6.png' WHERE SortOrder = 6;
GO

-- Fix TodaysSpecials image paths
UPDATE TodaysSpecials SET Image = 'assets/images/gallery/grid3/pic1.jpg' WHERE SortOrder = 1;
UPDATE TodaysSpecials SET Image = 'assets/images/gallery/grid3/pic2.jpg' WHERE SortOrder = 2;
UPDATE TodaysSpecials SET Image = 'assets/images/gallery/grid3/pic3.jpg' WHERE SortOrder = 3;
UPDATE TodaysSpecials SET Image = 'assets/images/gallery/grid3/pic4.jpg' WHERE SortOrder = 4;
GO

-- Seed MenuFilterItems (was missing from original seed)
IF NOT EXISTS (SELECT 1 FROM MenuFilterItems)
BEGIN
    INSERT INTO MenuFilterItems (Name, Description, Price, Image, FilterTags, SortOrder) VALUES
    ('Chicken Malai Boti', 'Succulent chicken marinated in cream, cashew paste, and subtle spices, then grilled to perfection on coal.', 'Rs. 550', 'assets/images/menu-small/grid/pic1.png', 'All drink sweet salad', 1),
    ('Mutton Karahi', 'Tender mutton pieces slow-cooked in a rich tomato gravy with whole spices — a Khan-e-Azam signature.', 'Rs. 1,100', 'assets/images/menu-small/grid/pic2.png', 'All pizza sweet', 2),
    ('Seekh Kebab Platter', 'Hand-minced beef and chicken kebabs grilled over live charcoal, served with raita and fresh naan.', 'Rs. 700', 'assets/images/menu-small/grid/pic3.png', 'All salad spicy', 3),
    ('Nihari & Naan', 'Slow-braised beef shank in a deeply spiced broth, simmered overnight — best enjoyed with freshly baked naan.', 'Rs. 950', 'assets/images/menu-small/grid/pic4.png', 'All drink spicy sweet', 4),
    ('Dal Makhani', 'Creamy black lentils simmered with butter and spices — a comforting classic loved by all ages.', 'Rs. 450', 'assets/images/menu-small/grid/pic5.png', 'All burger', 5),
    ('Chicken Biryani', 'Rich golden basmati layered with tender chicken and slow-cooked masala, garnished with caramelised onions.', 'Rs. 800', 'assets/images/menu-small/grid/pic6.png', 'All pizza burger', 6),
    ('Chapli Kebab', 'Peshwari-style flat kebab loaded with pomegranate seeds, green chilli and coriander — an absolute crowd favourite.', 'Rs. 600', 'assets/images/menu-small/grid/pic7.png', 'All burger salad', 7),
    ('Mutton Sajji', 'Whole leg of mutton marinated in rock salt and roasted over open flame — a Balochi classic.', 'Rs. 1,200', 'assets/images/menu-small/grid/pic8.png', 'All drink', 8);
END
GO

-- Fix IconFeatures icon classes
UPDATE IconFeatures SET IconClass = 'flaticon-offer'        WHERE SortOrder = 1;
UPDATE IconFeatures SET IconClass = 'flaticon-hamburger'    WHERE SortOrder = 2;
UPDATE IconFeatures SET IconClass = 'flaticon-room-service' WHERE SortOrder = 3;
GO

-- Fix Chefs image paths
UPDATE Chefs SET Image = 'assets/images/team/pic1.jpg' WHERE SortOrder = 1;
UPDATE Chefs SET Image = 'assets/images/team/pic2.jpg' WHERE SortOrder = 2;
UPDATE Chefs SET Image = 'assets/images/team/pic3.jpg' WHERE SortOrder = 3;
UPDATE Chefs SET Image = 'assets/images/team/pic4.jpg' WHERE SortOrder = 4;
UPDATE Chefs SET Image = 'assets/images/team/pic5.jpg' WHERE SortOrder = 5;
UPDATE Chefs SET Image = 'assets/images/team/pic6.jpg' WHERE SortOrder = 6;
UPDATE Chefs SET Image = 'assets/images/team/pic7.jpg' WHERE SortOrder = 7;
UPDATE Chefs SET Image = 'assets/images/team/pic8.jpg' WHERE SortOrder = 8;
GO

-- Fix Testimonials image paths
UPDATE Testimonials SET Image = 'assets/images/testimonial/large/pic1.jpg' WHERE SortOrder = 1;
UPDATE Testimonials SET Image = 'assets/images/testimonial/large/pic2.jpg' WHERE SortOrder = 2;
UPDATE Testimonials SET Image = 'assets/images/testimonial/large/pic3.jpg' WHERE SortOrder = 3;
GO

-- Fix BlogPosts image paths and video URL
UPDATE BlogPosts SET Image = 'assets/images/blog/large/pic1.jpg',  VideoUrl = 'assets/video/video.mp4' WHERE IsLarge = 1;
UPDATE BlogPosts SET Image = 'assets/images/blog/grid2/pic1.jpg' WHERE IsLarge = 0 AND SortOrder = 2;
UPDATE BlogPosts SET Image = 'assets/images/blog/grid2/pic2.jpg' WHERE IsLarge = 0 AND SortOrder = 3;
UPDATE BlogPosts SET Image = 'assets/images/blog/grid2/pic2.jpg' WHERE IsLarge = 0 AND SortOrder = 4;
GO

SELECT 'Done. Image paths fixed and MenuFilterItems seeded.' AS Result;
GO
