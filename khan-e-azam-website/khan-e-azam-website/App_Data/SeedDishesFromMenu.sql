-- ============================================================
-- Khan-E-Azam : Seed real menu dishes (from handwritten menu)
-- Adds all dishes into MenuFilterItems, keeping existing items.
-- Images live in assets/images/menu-small/dishes/ (sourced online).
-- Idempotent: skips any dish whose Name already exists.
-- Run against KhanEAzamDB.
-- ============================================================
USE KhanEAzamDB;
GO

-- Continue SortOrder after whatever already exists
DECLARE @base INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM MenuFilterItems);

;WITH Dishes(Name, Description, Price, Image, FilterTags, Ord) AS (
    SELECT * FROM (VALUES
    -- ===== Special Pizzas =====
    ('Khan-e-Azam Special Pizza', 'Our signature loaded pizza piled high with chicken tikka, kebab and a blend of melting cheeses.', 'Rs. 1,650', 'assets/images/menu-small/dishes/pizza-khan-special.jpg', 'All pizza', 1),
    ('Kabab Stuff Pizza',         'Cheese-stuffed crust packed with juicy seekh kebab and a smoky tikka topping.',                    'Rs. 1,550', 'assets/images/menu-small/dishes/pizza-kabab-stuff.jpg', 'All pizza', 2),
    ('Bihari Kabab Pizza',        'Spicy Bihari-marinated beef strips over a rich tomato base with mozzarella.',                      'Rs. 1,500', 'assets/images/menu-small/dishes/pizza-bihari-kabab.jpg', 'All pizza spicy', 3),
    ('Crown Crust Pizza',         'A royal crown of cheese-filled crust bites around a fully loaded chicken pizza.',                  'Rs. 1,700', 'assets/images/menu-small/dishes/pizza-crown-crust.jpg', 'All pizza', 4),
    ('Lazania Pizza',             'A fusion of lasagne and pizza layered with creamy sauce, cheese and herbs.',                       'Rs. 1,450', 'assets/images/menu-small/dishes/pizza-lazania.jpg', 'All pizza', 5),
    ('Super Supreme Pizza',       'The ultimate feast: chicken, kebab, peppers, onions and olives under a thick cheese blanket.',     'Rs. 1,600', 'assets/images/menu-small/dishes/pizza-super-supreme.jpg', 'All pizza', 6),
    -- ===== Regular Pizzas =====
    ('Tikka Pizza',               'Classic chicken tikka chunks with onion, capsicum and mozzarella.',                                'Rs. 950',  'assets/images/menu-small/dishes/pizza-tikka.jpg', 'All pizza', 7),
    ('Fajita Pizza',              'Mexican-style fajita chicken with peppers and a zesty sauce.',                                     'Rs. 950',  'assets/images/menu-small/dishes/pizza-fajita.jpg', 'All pizza', 8),
    ('Malai Boti Pizza',          'Creamy malai boti chicken on a soft base topped with gooey cheese.',                               'Rs. 1,000', 'assets/images/menu-small/dishes/pizza-malai-boti.jpg', 'All pizza', 9),
    ('Cheese Lover Pizza',        'For the cheese fanatic - a triple-cheese pizza, rich and stringy in every bite.',                  'Rs. 900',  'assets/images/menu-small/dishes/pizza-cheese-lover.jpg', 'All pizza', 10),
    ('B.B.Q Pizza',               'Smoky BBQ chicken with caramelised onions and a tangy barbecue drizzle.',                          'Rs. 950',  'assets/images/menu-small/dishes/pizza-bbq.jpg', 'All pizza', 11),
    -- ===== Shawarma =====
    ('Grilled Shawarma',          'Char-grilled chicken wrapped with fresh salad and garlic sauce in soft pita.',                     'Rs. 320',  'assets/images/menu-small/dishes/shawarma-grilled.jpg', 'All shawarma', 12),
    ('Zinger Shawarma',           'Crispy zinger fillet rolled with creamy sauce - add cheese for extra indulgence.',                 'Rs. 380',  'assets/images/menu-small/dishes/shawarma-zinger.jpg', 'All shawarma spicy', 13),
    ('Chicken Shawarma',          'The classic - tender chicken, garlic mayo and pickles in a warm wrap. Cheese optional.',           'Rs. 300',  'assets/images/menu-small/dishes/shawarma-chicken.jpg', 'All shawarma', 14),
    ('Malai Boti Shawarma',       'Creamy malai boti chicken wrapped with fresh veggies and signature sauce.',                        'Rs. 400',  'assets/images/menu-small/dishes/shawarma-malai-boti.jpg', 'All shawarma', 15),
    -- ===== Parathas =====
    ('Chicken Paratha',           'Flaky paratha stuffed with spiced chicken and melted cheese.',                                     'Rs. 350',  'assets/images/menu-small/dishes/paratha-chicken.jpg', 'All paratha', 16),
    ('Zinger Paratha',            'Crunchy zinger fillet folded into a buttery paratha with sauces.',                                 'Rs. 420',  'assets/images/menu-small/dishes/paratha-zinger.jpg', 'All paratha spicy', 17),
    ('Malai Boti Paratha',        'Soft paratha loaded with creamy malai boti and fresh salad.',                                      'Rs. 430',  'assets/images/menu-small/dishes/paratha-malai-boti.jpg', 'All paratha', 18),
    -- ===== Wrap & Roll =====
    ('Matrila Wrap',              'A house-special wrap bursting with flavour, crunchy salad and signature sauce.',                   'Rs. 380',  'assets/images/menu-small/dishes/wrap-matrila.jpg', 'All roll', 19),
    ('Stuff Roll',                'Paratha roll generously stuffed with spicy chicken and fresh veggies.',                            'Rs. 320',  'assets/images/menu-small/dishes/roll-stuff.jpg', 'All roll', 20),
    ('Bihari Roll',               'Smoky Bihari beef rolled in a soft paratha with chutney and onions.',                              'Rs. 360',  'assets/images/menu-small/dishes/roll-bihari.jpg', 'All roll spicy', 21),
    -- ===== Burgers =====
    ('Beef Smash Burger',         'A juicy smashed beef patty with cheese, caramelised onions and special sauce.',                    'Rs. 650',  'assets/images/menu-small/dishes/burger-beef-smash.jpg', 'All burger', 22),
    ('Big Eleven Burger',         'A towering double-decker burger for the biggest appetites.',                                       'Rs. 750',  'assets/images/menu-small/dishes/burger-big-eleven.jpg', 'All burger', 23),
    ('Grilled Burger',            'Flame-grilled chicken breast with fresh lettuce and tomato.',                                      'Rs. 500',  'assets/images/menu-small/dishes/burger-grilled.jpg', 'All burger', 24),
    ('Zinger Burger',             'The all-time favourite crispy zinger fillet - add cheese for extra melt.',                         'Rs. 480',  'assets/images/menu-small/dishes/burger-zinger.jpg', 'All burger spicy', 25),
    ('Patty Burger',              'A simple, satisfying chicken patty burger with classic toppings.',                                'Rs. 350',  'assets/images/menu-small/dishes/burger-patty.jpg', 'All burger', 26),
    ('Fillet Burger',            'Tender grilled chicken fillet with mayo, lettuce and tomato.',                                     'Rs. 520',  'assets/images/menu-small/dishes/burger-fillet.jpg', 'All burger', 27),
    ('Grand King Burger',         'A king-sized beef burger stacked with cheese, patties and trimmings.',                             'Rs. 800',  'assets/images/menu-small/dishes/burger-grand-king.jpg', 'All burger', 28),
    ('Fish Burger',               'Crispy battered fish fillet with tangy tartar sauce.',                                             'Rs. 600',  'assets/images/menu-small/dishes/burger-fish.jpg', 'All burger', 29),
    -- ===== Sandwiches =====
    ('Grilled Sandwich',          'Toasted sandwich filled with seasoned chicken and melted cheese.',                                 'Rs. 380',  'assets/images/menu-small/dishes/sandwich-grilled.jpg', 'All sandwich', 30),
    ('B.B.Q Sandwich',            'Smoky BBQ chicken layered with crunchy veggies in toasted bread.',                                 'Rs. 400',  'assets/images/menu-small/dishes/sandwich-bbq.jpg', 'All sandwich', 31),
    ('Smokey Sandwich',           'Char-grilled chicken with a smoky mayo and fresh salad.',                                          'Rs. 400',  'assets/images/menu-small/dishes/sandwich-smokey.jpg', 'All sandwich', 32),
    ('Club Sandwich',             'A triple-layer classic with chicken, egg, salad and fries on the side.',                           'Rs. 550',  'assets/images/menu-small/dishes/sandwich-club.jpg', 'All sandwich', 33),
    ('Panini Sandwich',           'Pressed Italian-style panini with grilled chicken and cheese.',                                    'Rs. 480',  'assets/images/menu-small/dishes/sandwich-panini.jpg', 'All sandwich', 34),
    -- ===== Nuggets / Hot Shots =====
    ('Chicken Nuggets',           'Golden, crispy chicken nuggets served with a dip of your choice.',                                 'Rs. 350',  'assets/images/menu-small/dishes/nuggets.jpg', 'All broast', 35),
    ('Hot Shots',                 'Bite-sized spicy crispy chicken pieces - the perfect snack.',                                      'Rs. 380',  'assets/images/menu-small/dishes/hot-shots.jpg', 'All broast spicy', 36),
    -- ===== Chicken Broast =====
    ('Quarter Broast',            'A crispy quarter of broasted chicken with fries and a bun.',                                       'Rs. 450',  'assets/images/menu-small/dishes/broast-quarter.jpg', 'All broast', 37),
    ('Half Broast',               'Half a chicken broasted to golden perfection, served with sides.',                                 'Rs. 750',  'assets/images/menu-small/dishes/broast-half.jpg', 'All broast', 38),
    ('Full Broast',               'A full broasted chicken - juicy inside, crunchy outside. Great to share.',                         'Rs. 1,350', 'assets/images/menu-small/dishes/broast-full.jpg', 'All broast', 39),
    -- ===== Salad =====
    ('Russian Salad',             'Creamy fruit-and-veg Russian salad - cool, sweet and refreshing.',                                 'Rs. 300',  'assets/images/menu-small/dishes/salad-russian.jpg', 'All salad', 40),
    ('Russian Namkeen Salad',     'A savoury twist on the classic, with crunchy veggies and a light dressing.',                       'Rs. 300',  'assets/images/menu-small/dishes/salad-russian-namkeen.jpg', 'All salad', 41),
    -- ===== Cakes =====
    ('Molten Lava Cake',          'Warm chocolate cake with a gooey molten centre - a dessert lover''s dream.',                        'Rs. 420',  'assets/images/menu-small/dishes/cake-molten-lava.jpg', 'All sweet', 42),
    ('Brownie',                   'Rich, fudgy chocolate brownie - best served warm.',                                                'Rs. 380',  'assets/images/menu-small/dishes/cake-brownie.jpg', 'All sweet', 43),
    -- ===== Cold Drinks =====
    ('Cold Drink (350 ml)',       'Chilled soft drink, 350 ml bottle.',                                                               'Rs. 80',   'assets/images/menu-small/dishes/drink-350ml.jpg', 'All drink', 44),
    ('Cold Drink (500 ml)',       'Chilled soft drink, 500 ml bottle.',                                                               'Rs. 120',  'assets/images/menu-small/dishes/drink-500ml.jpg', 'All drink', 45),
    ('Cold Drink (1.5 Litre)',    'Family-size chilled soft drink, 1.5 litre bottle.',                                                'Rs. 220',  'assets/images/menu-small/dishes/drink-1500ml.jpg', 'All drink', 46),
    -- ===== Fries =====
    ('Regular Fries',             'Classic golden, crispy french fries with a sprinkle of salt.',                                     'Rs. 250',  'assets/images/menu-small/dishes/fries-regular.jpg', 'All fries', 47),
    ('Fish Fries',                'Crispy fish fingers served alongside seasoned fries.',                                             'Rs. 450',  'assets/images/menu-small/dishes/fries-fish.jpg', 'All fries', 48),
    ('Loaded Fries',              'Fries smothered in cheese sauce, jalapenos and grilled chicken.',                                  'Rs. 420',  'assets/images/menu-small/dishes/fries-loaded.jpg', 'All fries', 49),
    ('Crinkle Fries',             'Wavy crinkle-cut fries - extra crunch in every bite.',                                             'Rs. 300',  'assets/images/menu-small/dishes/fries-crinkle.jpg', 'All fries', 50),
    ('Mayo Garlic Fries',         'Fries tossed in a creamy garlic-mayo sauce.',                                                      'Rs. 320',  'assets/images/menu-small/dishes/fries-mayo-garlic.jpg', 'All fries', 51),
    -- ===== Pasta =====
    ('Alfredo Pasta',             'Creamy white-sauce pasta with grilled chicken and herbs.',                                         'Rs. 650',  'assets/images/menu-small/dishes/pasta-alfredo.jpg', 'All pasta', 52),
    ('Lazania Pasta',             'Layered lasagne baked with rich meat sauce and bubbling cheese.',                                  'Rs. 750',  'assets/images/menu-small/dishes/pasta-lazania.jpg', 'All pasta', 53),
    ('Special Pasta',             'Our chef''s special pasta in a signature creamy-spicy fusion sauce.',                               'Rs. 700',  'assets/images/menu-small/dishes/pasta-special.jpg', 'All pasta spicy', 54),
    -- ===== Wings =====
    ('Hot Wings',                 'Fiery chicken wings tossed in a spicy hot sauce.',                                                 'Rs. 450',  'assets/images/menu-small/dishes/wings-hot.jpg', 'All wings spicy', 55),
    ('B.B.Q Wings',               'Sticky, smoky barbecue-glazed chicken wings.',                                                     'Rs. 450',  'assets/images/menu-small/dishes/wings-bbq.jpg', 'All wings', 56),
    ('Honey Wings',               'Sweet honey-glazed wings with a hint of garlic.',                                                  'Rs. 450',  'assets/images/menu-small/dishes/wings-honey.jpg', 'All wings', 57),
    ('Peri Peri Wings',           'African-style peri peri wings with a tangy, spicy kick.',                                          'Rs. 480',  'assets/images/menu-small/dishes/wings-peri-peri.jpg', 'All wings spicy', 58)
    ) AS v(Name, Description, Price, Image, FilterTags, Ord)
)
INSERT INTO MenuFilterItems (Name, Description, Price, Image, FilterTags, SortOrder, IsActive)
SELECT d.Name, d.Description, d.Price, d.Image, d.FilterTags, @base + d.Ord, 1
FROM Dishes d
WHERE NOT EXISTS (SELECT 1 FROM MenuFilterItems m WHERE m.Name = d.Name);
GO

SELECT COUNT(*) AS TotalMenuItems FROM MenuFilterItems;
GO
