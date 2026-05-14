-- Khan-E-Azam Website Database Setup
-- Run against (localdb)\MSSQLLocalDB

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'KhanEAzamDB')
    CREATE DATABASE KhanEAzamDB;
GO

USE KhanEAzamDB;
GO

-- AdminUsers
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AdminUsers' AND xtype='U')
CREATE TABLE AdminUsers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(500) NOT NULL,
    Email NVARCHAR(200) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- BannerSlides
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='BannerSlides' AND xtype='U')
CREATE TABLE BannerSlides (
    Id INT PRIMARY KEY IDENTITY(1,1),
    TagLine NVARCHAR(200),
    Heading NVARCHAR(500),
    Description NVARCHAR(1000),
    BgImage NVARCHAR(500),
    FoodImage NVARCHAR(500),
    FoodCardName NVARCHAR(200),
    ChefName NVARCHAR(200),
    ChefRole NVARCHAR(200),
    ChefImage NVARCHAR(500),
    Price NVARCHAR(100),
    CardDescription NVARCHAR(500),
    SortOrder INT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

-- BrowseMenuItems
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='BrowseMenuItems' AND xtype='U')
CREATE TABLE BrowseMenuItems (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(200) NOT NULL,
    SubTitle NVARCHAR(200),
    Price NVARCHAR(100),
    Image NVARCHAR(500),
    SortOrder INT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

-- TodaysSpecials
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TodaysSpecials' AND xtype='U')
CREATE TABLE TodaysSpecials (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Category NVARCHAR(100),
    Weight NVARCHAR(100),
    Name NVARCHAR(200) NOT NULL,
    Price NVARCHAR(100),
    Image NVARCHAR(500),
    SortOrder INT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

-- MenuFilterItems
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='MenuFilterItems' AND xtype='U')
CREATE TABLE MenuFilterItems (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(200) NOT NULL,
    Description NVARCHAR(1000),
    Price NVARCHAR(100),
    Image NVARCHAR(500),
    FilterTags NVARCHAR(500),
    SortOrder INT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

-- IconFeatures
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='IconFeatures' AND xtype='U')
CREATE TABLE IconFeatures (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IconClass NVARCHAR(200),
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(1000),
    LinkUrl NVARCHAR(500),
    SortOrder INT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

-- Chefs
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Chefs' AND xtype='U')
CREATE TABLE Chefs (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(200) NOT NULL,
    Role NVARCHAR(200),
    Image NVARCHAR(500),
    FacebookUrl NVARCHAR(500),
    TwitterUrl NVARCHAR(500),
    InstagramUrl NVARCHAR(500),
    LinkedInUrl NVARCHAR(500),
    SortOrder INT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

-- Testimonials
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Testimonials' AND xtype='U')
CREATE TABLE Testimonials (
    Id INT PRIMARY KEY IDENTITY(1,1),
    ReviewerName NVARCHAR(200) NOT NULL,
    ReviewerPosition NVARCHAR(200),
    ReviewText NVARCHAR(2000),
    Image NVARCHAR(500),
    SortOrder INT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

-- BlogPosts
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='BlogPosts' AND xtype='U')
CREATE TABLE BlogPosts (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(500) NOT NULL,
    Author NVARCHAR(200),
    PublishedDate DATETIME,
    Image NVARCHAR(500),
    VideoUrl NVARCHAR(500),
    IsLarge BIT NOT NULL DEFAULT 0,
    CommentCount INT NOT NULL DEFAULT 0,
    SortOrder INT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

-- ============================================================
-- Seed Admin User  (password: Admin@123)
-- Hash generated via PBKDF2 - run app once to regenerate
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM AdminUsers WHERE Username = 'admin')
INSERT INTO AdminUsers (Username, PasswordHash, Email)
VALUES ('admin', 'PLACEHOLDER_HASH', 'admin@khanazam.com');
GO

-- Seed BannerSlides
IF NOT EXISTS (SELECT 1 FROM BannerSlides)
BEGIN
    INSERT INTO BannerSlides (TagLine, Heading, Description, BgImage, FoodImage, FoodCardName, ChefName, ChefRole, ChefImage, Price, CardDescription, SortOrder)
    VALUES
    ('Authentic Pakistani Royal Cuisine', 'Where Every Dish Tells a Story of Royal Taste', 'Experience the rich flavours of traditional Pakistani recipes, crafted with hand-picked spices and time-honoured cooking techniques passed down through generations.', 'assets/images/main-slider/slider2/bg1.jpg', 'assets/images/main-slider/slider2/pic1.png', 'Chicken Karahi', 'Ustad Farooq', 'Head Chef', 'assets/images/team/pic1.jpg', 'Rs. 850', 'Slow-cooked in aromatic spices...', 1),
    ('Lahore''s Finest — Now at Your Table', 'Bringing the Heart of Lahore to Your Plate', 'From sizzling Sajji to slow-cooked Nihari, every bite at Khan-e-Azam is a journey through the vibrant street-food culture of Pakistan.', 'assets/images/main-slider/slider2/bg2.jpg', 'assets/images/main-slider/slider2/pic2.png', 'Mutton Biryani', 'Chef Imran Ali', 'Master Chef', 'assets/images/team/pic2.jpg', 'Rs. 850', 'Fragrant basmati with tender mutton...', 2),
    ('Generations of Taste, Served with Pride', 'Savour the Magic of Khan-e-Azam Every Visit', 'From sizzling Sajji to slow-cooked Nihari, every bite at Khan-e-Azam is a journey through the vibrant street-food culture of Pakistan.', 'assets/images/main-slider/slider2/bg3.jpg', 'assets/images/main-slider/slider2/pic3.png', 'Seekh Kebab', 'Chef Aqeel Khan', 'Master Chef', 'assets/images/team/pic2.jpg', 'Rs. 850', 'Fragrant basmati with tender mutton...', 3);
END
GO

-- Seed BrowseMenuItems
IF NOT EXISTS (SELECT 1 FROM BrowseMenuItems)
BEGIN
    INSERT INTO BrowseMenuItems (Name, SubTitle, Price, Image, SortOrder)
    VALUES
    ('Zinger Burger',   'Crispy & Juicy Chicken',          'Rs. 450', 'assets/images/menu-small/pic1.png', 1),
    ('Yakhni Pulao',    'Tender Meat & Aromatic Rice',     'Rs. 650', 'assets/images/menu-small/pic2.png', 2),
    ('Chicken Karahi',  'Slow-Cooked Spicy Delight',       'Rs. 850', 'assets/images/menu-small/pic3.png', 3),
    ('Mutton Biryani',  'Fragrant Basmati & Tender Mutton','Rs. 950', 'assets/images/menu-small/pic4.png', 4),
    ('Seekh Kebab',     'Grilled Over Open Flame',         'Rs. 700', 'assets/images/menu-small/pic5.png', 5),
    ('Nihari Special',  'Slow-Cooked Beef Stew',           'Rs. 900', 'assets/images/menu-small/pic6.png', 6);
END
GO

-- Seed TodaysSpecials
IF NOT EXISTS (SELECT 1 FROM TodaysSpecials)
BEGIN
    INSERT INTO TodaysSpecials (Category, Weight, Name, Price, Image, SortOrder)
    VALUES
    ('Grills',   '756g', 'Malai Boti',    'Rs. 750', 'assets/images/gallery/grid3/pic1.jpg', 1),
    ('Karahi',   '756g', 'Chicken Karahi','Rs. 900', 'assets/images/gallery/grid3/pic2.jpg', 2),
    ('Biryani',  '756g', 'Mutton Biryani','Rs. 950', 'assets/images/gallery/grid3/pic3.jpg', 3),
    ('BBQ',      '756g', 'Seekh Kebab',   'Rs. 650', 'assets/images/gallery/grid3/pic4.jpg', 4);
END
GO

-- Seed MenuFilterItems
IF NOT EXISTS (SELECT 1 FROM MenuFilterItems)
BEGIN
    INSERT INTO MenuFilterItems (Name, Description, Price, Image, FilterTags, SortOrder) VALUES
    ('Chicken Malai Boti',  'Succulent chicken marinated in cream, cashew paste, and subtle spices, then grilled to perfection on coal.', 'Rs. 550',   'assets/images/menu-small/grid/pic1.png', 'All drink sweet salad', 1),
    ('Mutton Karahi',       'Tender mutton pieces slow-cooked in a rich tomato gravy with whole spices — a Khan-e-Azam signature.',     'Rs. 1,100', 'assets/images/menu-small/grid/pic2.png', 'All pizza sweet',       2),
    ('Seekh Kebab Platter', 'Hand-minced beef and chicken kebabs grilled over live charcoal, served with raita and fresh naan.',        'Rs. 700',   'assets/images/menu-small/grid/pic3.png', 'All salad spicy',       3),
    ('Nihari & Naan',       'Slow-braised beef shank in a deeply spiced broth, simmered overnight — best enjoyed with freshly baked naan.', 'Rs. 950', 'assets/images/menu-small/grid/pic4.png', 'All drink spicy sweet', 4),
    ('Dal Makhani',         'Creamy black lentils simmered with butter and spices — a comforting classic loved by all ages.',           'Rs. 450',   'assets/images/menu-small/grid/pic5.png', 'All burger',            5),
    ('Chicken Biryani',     'Rich golden basmati layered with tender chicken and slow-cooked masala, garnished with caramelised onions.','Rs. 800',  'assets/images/menu-small/grid/pic6.png', 'All pizza burger',      6),
    ('Chapli Kebab',        'Peshwari-style flat kebab loaded with pomegranate seeds, green chilli and coriander — an absolute crowd favourite.', 'Rs. 600', 'assets/images/menu-small/grid/pic7.png', 'All burger salad', 7),
    ('Mutton Sajji',        'Whole leg of mutton marinated in rock salt and roasted over open flame — a Balochi classic.',              'Rs. 1,200', 'assets/images/menu-small/grid/pic8.png', 'All drink',             8);
END
GO

-- Seed IconFeatures
IF NOT EXISTS (SELECT 1 FROM IconFeatures)
BEGIN
    INSERT INTO IconFeatures (IconClass, Title, Description, LinkUrl, SortOrder)
    VALUES
    ('flaticon-offer',        'Exclusive Deals & Offers', 'Enjoy special discounts and seasonal promotions every week.',                                     'services.html', 1),
    ('flaticon-hamburger',    '100% Fresh Ingredients',  'We source fresh produce daily to ensure the highest quality in every dish.',                       'services.html', 2),
    ('flaticon-room-service', 'Premium Table Service',   'Our courteous staff ensure a warm, royal dining experience every time.',                           'services.html', 3);
END
GO

-- Seed Chefs
IF NOT EXISTS (SELECT 1 FROM Chefs)
BEGIN
    INSERT INTO Chefs (Name, Role, Image, FacebookUrl, TwitterUrl, InstagramUrl, LinkedInUrl, SortOrder)
    VALUES
    ('Ahmad Baig',      'Senior Chef',        'assets/images/team/pic1.jpg', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 1),
    ('Imran Ali',       'Senior Chef',        'assets/images/team/pic2.jpg', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 2),
    ('Hina Malik',      'Senior Chef',        'assets/images/team/pic3.jpg', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 3),
    ('Zain Butt',       'Senior Chef',        'assets/images/team/pic4.jpg', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 4),
    ('Nadia Rauf',      'Senior Chef',        'assets/images/team/pic5.jpg', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 5),
    ('Bilal Chaudhry',  'Senior Chef',        'assets/images/team/pic6.jpg', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 6),
    ('Sarah Albert',    'Head Pastry Chef',   'assets/images/team/pic7.jpg', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 7),
    ('Aqeel Khan',      'Grill Master',       'assets/images/team/pic8.jpg', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 'javascript:void(0);', 8);
END
GO

-- Seed Testimonials
IF NOT EXISTS (SELECT 1 FROM Testimonials)
BEGIN
    INSERT INTO Testimonials (ReviewerName, ReviewerPosition, ReviewText, Image, SortOrder)
    VALUES
    ('Usman Qureshi',  'Loyal Customer', 'Khan-e-Azam is simply the best Pakistani restaurant I have ever visited. The Mutton Karahi was absolutely divine — tender meat, perfectly balanced spices, and that smoky aroma that stays with you long after the meal. I drive 45 minutes every weekend just to eat here!',         'assets/images/testimonial/large/pic1.jpg', 1),
    ('Ayesha Siddiqui','Loyal Customer', 'From the moment you walk in, you feel the warmth of genuine hospitality. The Nihari is cooked exactly as it should be — slow, rich, and deeply satisfying. Their naans fresh from the tandoor are a meal in themselves. Highly recommended to every food lover.',                    'assets/images/testimonial/large/pic2.jpg', 2),
    ('Tariq Hassan',   'Loyal Customer', 'I ordered the Seekh Kebab platter for a family gathering and everyone was amazed. Juicy, charcoal-grilled perfection! The portions are generous and the prices are very fair. Khan-e-Azam has become our family''s go-to restaurant for celebrations.',                             'assets/images/testimonial/large/pic3.jpg', 3);
END
GO

-- Seed BlogPosts
IF NOT EXISTS (SELECT 1 FROM BlogPosts)
BEGIN
    INSERT INTO BlogPosts (Title, Author, PublishedDate, Image, VideoUrl, IsLarge, CommentCount, SortOrder)
    VALUES
    ('Behind the Flame: An Evening at Khan-e-Azam Kitchen',         'Khan-e-Azam Team', '2024-02-14', 'assets/images/blog/large/pic1.jpg', 'assets/video/video.mp4', 1, 10, 1),
    ('Top 5 Must-Try Dishes at Khan-e-Azam This Season',            'Khan-e-Azam Team', '2024-02-12', 'assets/images/blog/grid2/pic1.jpg', NULL,                    0, 10, 2),
    ('The Art of Slow Cooking: How Our Nihari Is Made',             'Chef Ustad Farooq', '2024-02-24', 'assets/images/blog/grid2/pic2.jpg', NULL,                   0, 24, 3);
END
GO
