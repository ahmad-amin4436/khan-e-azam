-- Khan-E-Azam Real Menu Items Migration
-- Clears placeholder seed data and inserts the actual restaurant menu
USE KhanEAzamDB;
GO

DELETE FROM MenuFilterItems;
GO

DBCC CHECKIDENT ('MenuFilterItems', RESEED, 0);
GO

INSERT INTO MenuFilterItems (Name, Description, Price, Image, FilterTags, SortOrder, IsActive) VALUES

-- ===================== SANDWICH =====================
('Grilled Sandwich',    'Toasted bread layered with grilled chicken, fresh veggies and sauces.',  'Rs. 250', 'assets/images/menu-small/grid/pic1.png', 'sandwich', 10, 1),
('Panini Sandwich',     'Italian-style pressed sandwich with chicken, cheese and herbs.',           'Rs. 300', 'assets/images/menu-small/grid/pic2.png', 'sandwich', 11, 1),
('Bar.B.Q Sandwich',    'Smoky BBQ chicken strips packed in soft bread with crunchy slaw.',        'Rs. 350', 'assets/images/menu-small/grid/pic3.png', 'sandwich', 12, 1),
('Club Sandwich',       'Triple-decker classic loaded with chicken, egg, lettuce and tomato.',     'Rs. 320', 'assets/images/menu-small/grid/pic4.png', 'sandwich', 13, 1),
('Smokey Sandwich',     'Smoked chicken with caramelised onion and smokey sauce on toasted bread.','Rs. 350', 'assets/images/menu-small/grid/pic5.png', 'sandwich', 14, 1),

-- ===================== SHAWARMA =====================
('Grilled Shawarma',       'Tender grilled chicken wrapped in soft bread with garlic sauce.',         'Rs. 250', 'assets/images/menu-small/grid/pic6.png', 'shawarma', 20, 1),
('Chicken Shawarma',       'Marinated chicken strips with pickles, veggies and creamy sauce.',        'Rs. 280', 'assets/images/menu-small/grid/pic7.png', 'shawarma', 21, 1),
('Zinger Shawarma',        'Crispy zinger chicken wrapped with lettuce, mayo and chilli sauce.',      'Rs. 350', 'assets/images/menu-small/grid/pic8.png', 'shawarma', 22, 1),
('Zinger Cheez Shawarma',  'Crispy zinger chicken with melted cheese and signature sauce.',           'Rs. 380', 'assets/images/menu-small/grid/pic1.png', 'shawarma', 23, 1),
('Chicken Cheez Shawarma', 'Juicy chicken with a generous layer of melted cheese.',                   'Rs. 380', 'assets/images/menu-small/grid/pic2.png', 'shawarma', 24, 1),
('Malai Boti Shawarma',    'Creamy malai boti chicken wrapped with garlic sauce and fresh herbs.',    'Rs. 450', 'assets/images/menu-small/grid/pic3.png', 'shawarma', 25, 1),

-- ===================== BURGER =====================
('Grand Pa Burger',       'Towering classic burger with double patty, lettuce, tomato and sauce.',   'Rs. 550', 'assets/images/menu-small/grid/pic4.png', 'burger', 30, 1),
('Big Eleven Burger',     'Loaded signature burger with crispy chicken and fresh toppings.',          'Rs. 700', 'assets/images/menu-small/grid/pic5.png', 'burger', 31, 1),
('Grilled Burger',        'Flame-grilled chicken burger with lettuce, mayo and pickles.',             'Rs. 400', 'assets/images/menu-small/grid/pic6.png', 'burger', 32, 1),
('Smokey Grilled Burger', 'Smoky grilled patty with caramelised onions and smokey BBQ sauce.',       'Rs. 450', 'assets/images/menu-small/grid/pic7.png', 'burger', 33, 1),
('Zinger Burger',         'Crispy spicy chicken fillet with lettuce, mayo and pickles.',              'Rs. 400', 'assets/images/menu-small/grid/pic8.png', 'burger', 34, 1),
('Zinger Cheez Burger',   'Crispy zinger fillet topped with a thick slice of melted cheese.',        'Rs. 450', 'assets/images/menu-small/grid/pic1.png', 'burger', 35, 1),
('Double Dacker Burger',  'Double-stacked patty burger packed with all the fixings.',                'Rs. 650', 'assets/images/menu-small/grid/pic2.png', 'burger', 36, 1),
('Filet Burger',          'Tender chicken fillet burger with classic toppings and house sauce.',     'Rs. 500', 'assets/images/menu-small/grid/pic3.png', 'burger', 37, 1),
('Grand King Burger',     'Our biggest burger — stacked high with double fillets, cheese and sauce.','Rs. 850', 'assets/images/menu-small/grid/pic4.png', 'burger', 38, 1),

-- ===================== RAP ROLL =====================
('Matsila Rap Roll', 'Spiced chicken with tangy matsila chutney wrapped in soft bread.',  'Rs. 250', 'assets/images/menu-small/grid/pic5.png', 'roll', 40, 1),
('Stuff Roll',       'Stuffed roll filled with seasoned chicken and vegetables.',          'Rs. 280', 'assets/images/menu-small/grid/pic6.png', 'roll', 41, 1),
('Behari Roll',      'Behari-marinated chicken wrapped tightly in a soft, warm roll.',    'Rs. 350', 'assets/images/menu-small/grid/pic7.png', 'roll', 42, 1),

-- ===================== PARATHA ROLL =====================
('Grilled Paratha Roll',       'Grilled chicken strip rolled in a flaky, buttered paratha.',              'Rs. 300', 'assets/images/menu-small/grid/pic8.png', 'paratha', 50, 1),
('Chicken Paratha Roll',       'Juicy chicken filling wrapped in a soft homemade paratha.',               'Rs. 320', 'assets/images/menu-small/grid/pic1.png', 'paratha', 51, 1),
('Chicken Cheez Paratha Roll', 'Chicken and melted cheese sealed inside a crispy paratha.',               'Rs. 380', 'assets/images/menu-small/grid/pic2.png', 'paratha', 52, 1),
('Zinger Paratha Roll',        'Crispy zinger chicken wrapped in a warm, golden paratha.',                'Rs. 380', 'assets/images/menu-small/grid/pic3.png', 'paratha', 53, 1),
('Zinger Cheez Paratha Roll',  'Zinger fillet with melted cheese, all rolled in a buttery paratha.',     'Rs. 420', 'assets/images/menu-small/grid/pic4.png', 'paratha', 54, 1),
('Malai Boti Paratha Roll',    'Creamy malai boti chicken pieces nestled in a soft layered paratha.',    'Rs. 450', 'assets/images/menu-small/grid/pic5.png', 'paratha', 55, 1),

-- ===================== FRIES =====================
('Loaded Fries',      'Crispy fries piled with cheese sauce, jalapeños and toppings.',   'Rs. 380', 'assets/images/menu-small/grid/pic6.png', 'fries', 60, 1),
('Crinkle Fries',     'Golden wavy crinkle-cut fries, perfectly salted.',                'Rs. 250', 'assets/images/menu-small/grid/pic7.png', 'fries', 61, 1),
('Mayo Garlic Fries', 'Classic fries tossed in a rich mayo garlic dipping sauce.',       'Rs. 300', 'assets/images/menu-small/grid/pic8.png', 'fries', 62, 1),
('Regular Fries',     'Straight-cut golden fries seasoned with our secret spice blend.', 'Rs. 200', 'assets/images/menu-small/grid/pic1.png', 'fries', 63, 1),
('Masala Fries',      'Fries tossed in zesty Pakistani chat masala — addictive!',        'Rs. 250', 'assets/images/menu-small/grid/pic2.png', 'fries', 64, 1),

-- ===================== PASTA =====================
('Al-Afredo Pasta', 'Creamy Alfredo sauce over penne pasta, rich and comforting.',         'Rs. 550', 'assets/images/menu-small/grid/pic3.png', 'pasta', 70, 1),
('Lasagna Pasta',   'Oven-baked layers of pasta, meat sauce and béchamel.',                'Rs. 600', 'assets/images/menu-small/grid/pic4.png', 'pasta', 71, 1),
('Special Pasta',   'Chef''s special pasta with a unique house blend sauce.',              'Rs. 650', 'assets/images/menu-small/grid/pic5.png', 'pasta', 72, 1),
('Creamy Pasta',    'Velvet-smooth cream sauce tossed with pasta and aromatic herbs.',     'Rs. 500', 'assets/images/menu-small/grid/pic6.png', 'pasta', 73, 1),

-- ===================== WINGS =====================
('Farai Wings',     'Crispy deep-fried wings seasoned with our signature spice mix.',   'Rs. 600', 'assets/images/menu-small/grid/pic7.png', 'wings', 80, 1),
('Bar.B.Q Wings',   'Smoky BBQ glazed wings grilled to juicy perfection.',               'Rs. 650', 'assets/images/menu-small/grid/pic8.png', 'wings', 81, 1),
('Honey Wings',     'Sweet and sticky honey-glazed wings — a crowd favourite.',          'Rs. 700', 'assets/images/menu-small/grid/pic1.png', 'wings', 82, 1),
('Peri Peri Wings', 'Fiery peri peri marinated wings with a bold, tangy kick.',         'Rs. 750', 'assets/images/menu-small/grid/pic2.png', 'wings', 83, 1),
('Nuggets',         'Golden crispy chicken nuggets served with dipping sauce.',          'Rs. 500', 'assets/images/menu-small/grid/pic3.png', 'wings', 84, 1),
('Hot Shot',        'Spicy bite-sized chicken pieces with a fiery hot sauce coating.',  'Rs. 500', 'assets/images/menu-small/grid/pic4.png', 'wings', 85, 1),

-- ===================== CHICKEN BROAST =====================
('Quarter Broast', 'Quarter piece of pressure-fried broast chicken, juicy inside, crispy outside.', 'Rs. 400', 'assets/images/menu-small/grid/pic5.png', 'broast', 90, 1),
('Half Broast',    'Half chicken broast — golden, crispy skin with tender meat throughout.',         'Rs. 650', 'assets/images/menu-small/grid/pic6.png', 'broast', 91, 1),
('Full Broast',    'Whole broast chicken for the family — supremely crispy and flavourful.',         'Rs. 950', 'assets/images/menu-small/grid/pic7.png', 'broast', 92, 1),

-- ===================== PIZZA (REGULAR FLAVORS) — Small·Medium·Large·XXL =====================
('Tikka Pizza',        'Tender tikka chicken, onions and peppers on a tangy tomato base.',              'Rs. 750', 'assets/images/menu-small/grid/pic8.png', 'pizza', 100, 1),
('Malai Boti Pizza',   'Creamy malai boti chicken pieces over a white sauce with herbs.',              'Rs. 850', 'assets/images/menu-small/grid/pic1.png', 'pizza', 101, 1),
('Fajita Pizza',       'Sizzling fajita-style chicken with colourful capsicums and onions.',           'Rs. 850', 'assets/images/menu-small/grid/pic2.png', 'pizza', 102, 1),
('Hot and Spicy Pizza','Fiery spiced chicken with jalapeños and chilli flakes on a bold sauce.',       'Rs. 750', 'assets/images/menu-small/grid/pic3.png', 'pizza', 103, 1),
('Bar.B.Q Pizza',      'Smoky BBQ chicken with sweet peppers and tangy BBQ drizzle.',                  'Rs. 850', 'assets/images/menu-small/grid/pic4.png', 'pizza', 104, 1),
('Tandori Pizza',      'Tandoori-spiced chicken on a rich tomato base with fresh coriander.',          'Rs. 850', 'assets/images/menu-small/grid/pic5.png', 'pizza', 105, 1),
('Vegetable Pizza',    'Fresh seasonal vegetables on a tomato and cheese base.',                       'Rs. 700', 'assets/images/menu-small/grid/pic6.png', 'pizza', 106, 1),
('Cheez Lover Pizza',  'Extra cheese on cheese — four cheese blend on a creamy white base.',           'Rs. 850', 'assets/images/menu-small/grid/pic7.png', 'pizza', 107, 1),

-- ===================== PIZZA (SPECIAL FLAVORS) — XXL 16-inch =====================
('Special Pizza',         'Our signature chef-crafted pizza with premium toppings and special sauce.', 'Rs. 1,200', 'assets/images/menu-small/grid/pic8.png', 'pizza', 110, 1),
('Behari Kabab Pizza',    'Rich behari kabab mince with onions and green chilli on crispy dough.',    'Rs. 1,400', 'assets/images/menu-small/grid/pic1.png', 'pizza', 111, 1),
('Crown Crust Pizza',     'Cheese-stuffed crown crust with a loaded centre — showstopper pizza.',     'Rs. 1,400', 'assets/images/menu-small/grid/pic2.png', 'pizza', 112, 1),
('Kabab Stuffer Pizza',   'Seekh kabab mince stuffed inside the crust with premium toppings.',        'Rs. 1,400', 'assets/images/menu-small/grid/pic3.png', 'pizza', 113, 1),
('Lasagna Pizza',         'Lasagna-inspired pizza with layered meat sauce and béchamel drizzle.',     'Rs. 1,200', 'assets/images/menu-small/grid/pic4.png', 'pizza', 114, 1),
('Bonefire Pizza',        'Bold smoky flavours with spiced chicken and a fire-roasted sauce.',         'Rs. 1,300', 'assets/images/menu-small/grid/pic5.png', 'pizza', 115, 1),
('Super Supreme Pizza',   'Everything on one pizza — chicken, beef, veggies, extra cheese.',          'Rs. 1,500', 'assets/images/menu-small/grid/pic6.png', 'pizza', 116, 1),
('Cheese Stick Pizza',    'Cheese-pull crust sticks surrounding a loaded pizza centre.',               'Rs. 1,200', 'assets/images/menu-small/grid/pic7.png', 'pizza', 117, 1),

-- ===================== SALAD =====================
('Russian Salad',         'Creamy Russian salad with vegetables and tangy mayo dressing.',             'Rs. 300', 'assets/images/menu-small/grid/pic8.png', 'salad', 120, 1),
('Russian Namkeen Salad', 'Savoury twist on Russian salad with a spiced, tangy flavour profile.',     'Rs. 350', 'assets/images/menu-small/grid/pic1.png', 'salad', 121, 1),

-- ===================== SWEETS / CAKE =====================
('Molten Lava Cake', 'Warm chocolate cake with a gooey molten centre — indulge yourself.',      'Rs. 400', 'assets/images/menu-small/grid/pic2.png', 'sweet', 130, 1),
('Brownie',          'Dense, fudgy chocolate brownie — best served warm with vanilla ice cream.','Rs. 300', 'assets/images/menu-small/grid/pic3.png', 'sweet', 131, 1);

GO
