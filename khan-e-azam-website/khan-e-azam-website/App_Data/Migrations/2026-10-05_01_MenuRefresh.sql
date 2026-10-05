/*
  Khan-E-Azam — full menu refresh (2026-10-05)

  Replaces the website menu with the current printed menu (sandwiches/wraps,
  pizzas, broast, burgers, BBQ, starters, and the bar).

  Approach
    - Existing MenuFilterItems rows are DEACTIVATED (IsActive = 0), not deleted,
      so the previous menu can be restored if a price or item was mis-transcribed.
    - The new items are inserted with IsActive = 1.
    - Re-running is safe: the script keys new rows on Name + FilterTags and skips
      any that are already present, so it will not create duplicates.

  Pricing note
    Pizzas are priced medium/large on the printed menu. They are stored as a
    single row showing both ("Rs. 1400 / 2600") rather than as two items, which
    matches how the card UI renders one price per dish.

  Schema note
    MenuFilterItems lives in dbo on both local and production, but the table is
    still resolved through the caller's default schema first for consistency with
    the other migrations in this folder.
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

PRINT '--- Menu refresh starting ---';
PRINT 'Default schema for this login: ' + SCHEMA_NAME();

DECLARE @menu INT = COALESCE(OBJECT_ID(QUOTENAME(SCHEMA_NAME()) + '.MenuFilterItems'),
                             OBJECT_ID('dbo.MenuFilterItems'));
IF @menu IS NULL
BEGIN
    RAISERROR('MenuFilterItems table not found; nothing to update.', 16, 1);
    RETURN;
END

DECLARE @tbl NVARCHAR(300) = QUOTENAME(OBJECT_SCHEMA_NAME(@menu)) + '.' + QUOTENAME(OBJECT_NAME(@menu));
PRINT 'Updating ' + @tbl;

-- The new menu, staged first so the swap is a single transaction.
DECLARE @new TABLE (
    Name        NVARCHAR(200),
    Description NVARCHAR(1000),
    Price       NVARCHAR(100),
    Image       NVARCHAR(500),
    FilterTags  NVARCHAR(200),
    SortOrder   INT
);

-- ============================ SANDWICHES & WRAPS ============================
INSERT INTO @new (Name, Description, Price, Image, FilterTags, SortOrder) VALUES
('B.B.Q Sandwich',        'Grilled B.B.Q chicken, served with fries.',                                                                    'Rs. 595', 'assets/images/menu-small/dishes/sandwich-bbq.jpg',     'sandwich',        10),
('Jalapeno Tikka Sandwich','Grilled tikka chicken, jalapeno and onion, served with fries.',                                               'Rs. 650', 'assets/images/menu-small/dishes/sandwich-panini.jpg',  'sandwich spicy',  11),
('Grilled Sandwich',      'Grilled chicken, 3 pc bread, iceberg and chipotle sauce, served with fries.',                                  'Rs. 650', 'assets/images/menu-small/dishes/sandwich-grilled.jpg', 'sandwich',        12),
('Special Club Sandwich', '4 pieces of toasted bread, grilled chicken, tomato, iceberg lettuce, cheese slice, fried egg and special sandwich sauce, served with fries.', 'Rs. 750', 'assets/images/menu-small/dishes/sandwich-club.jpg', 'sandwich', 13),
('Dynamite Chicken',      'Marinated crispy fried chicken, hot shots (8 pieces), sesame seeds and special aromatic sauce with crispy hot shot toast.', 'Rs. 750', 'assets/images/menu-small/dishes/hot-shots.jpg', 'sandwich spicy', 14),
('Crispy Jalapeno Wrap',  'Marinated crispy fried chicken, tortilla bread, garlic mayo, tomato, jalapeno, onion, black olives, lettuce and French fries with sauce dip.', 'Rs. 695', 'assets/images/menu-small/dishes/wrap-matrila.jpg', 'roll spicy', 15),
('Chipotle Wrap',         'Crispy marinated fried chicken, garlic mayo, special chipotle tortilla bread, French fries, gherkin pickles, black olives and cheese slices, served with fries.', 'Rs. 695', 'assets/images/menu-small/dishes/roll-stuff.jpg', 'roll', 16);

-- ================================= PIZZAS ==================================
-- Extra topping: Rs. 150 medium / Rs. 250 large.
INSERT INTO @new (Name, Description, Price, Image, FilterTags, SortOrder) VALUES
('Small Pizza',             'Chicken, black olive, mushroom, satay veg and cheese.',                                                       'Rs. 750',          'assets/images/menu-small/dishes/pizza-vegetable.jpg',     'pizza', 20),
('KAF Special Pizza',       'Special chicken, cheese, capsicum, onion, tomato, black olives and chicken sausages, topped with our special sauce.', 'Rs. 1400 / 2600', 'assets/images/menu-small/dishes/pizza-khan-special.jpg', 'pizza', 21),
('KAF Special Kenzon Pizza','Our signature Kenzon pizza, loaded with special toppings.',                                                   'Rs. 1450 / 2800',  'assets/images/menu-small/dishes/pizza-super-supreme.jpg', 'pizza', 22),
('Malai Boti Pizza',        'Onion and olive, topped with malai sauce.',                                                                   'Rs. 1400 / 2600',  'assets/images/menu-small/dishes/pizza-malai-boti.jpg',    'pizza', 23),
('Kabab Behari Pizza',      'Special pizza sauce, marinated fajita chicken, tomato, bell pepper, onion, mushrooms, French creamy sauce and cheese sausage.', 'Rs. 1400 / 2600', 'assets/images/menu-small/dishes/pizza-bihari-kabab.jpg', 'pizza', 24),
('Ranch Pizza',             'Ranch white sauce, marinated and baked chicken, jalapenos, tomato slices and black olives, topped with ranch sauce.', 'Rs. 1400 / 2600', 'assets/images/menu-small/dishes/pizza-bonefire.jpg', 'pizza spicy', 25),
('Crown Crust Pizza',       'Regular pizza base, Italian herb creamy sauce, marinated baked chicken, onion, tomato and jalapenos.',        'Rs. 1400 / 2600',  'assets/images/menu-small/dishes/pizza-crown-crust.jpg',   'pizza spicy', 26),
('Kebab Stuffed Pizza',     'Special chicken, cheese, onion, tomato, black olives and capsicum, topped with our signature sauce.',          'Rs. 1400 / 2600',  'assets/images/menu-small/dishes/pizza-kabab-stuff.jpg',   'pizza', 27),
('Chicken Tikka Pizza',     'Regular pizza sauce, tikka-spiced chicken, bell pepper, tomato, onion, vinaigrette green chili and black olives.', 'Rs. 1250 / 1800', 'assets/images/menu-small/dishes/pizza-tikka.jpg', 'pizza spicy', 28),
('Pepperoni Pizza',         'Regular pizza sauce, beef pepperoni and 100% mozzarella cheese.',                                             'Rs. 1250 / 1800',  'assets/images/menu-small/dishes/pizza-spicy.jpg',         'pizza', 29),
('Chicken Fajita Pizza',    'Regular pizza sauce, fajita-spiced chicken, onion slices, tomato slices, bell pepper slices and button mushrooms.', 'Rs. 1250 / 1800', 'assets/images/menu-small/dishes/pizza-fajita.jpg', 'pizza', 30),
('Cheese Lover Pizza',      'Tomato pizza sauce, cheddar cheese (30%) and mozzarella cheese (70%), topped with a sprinkle of oregano.',     'Rs. 1250 / 1800',  'assets/images/menu-small/dishes/pizza-cheese-lover.jpg',  'pizza', 31);

-- ================================= BROAST ==================================
INSERT INTO @new (Name, Description, Price, Image, FilterTags, SortOrder) VALUES
('Quarter Broast', '2 pieces chicken, fries, 1 bun and garlic sauce.',                   'Rs. 850',  'assets/images/menu-small/dishes/broast-quarter.jpg', 'broast', 40),
('Half Broast',    '4 pieces chicken, 1 bun, 2 garlic sauces and fries.',                'Rs. 1450', 'assets/images/menu-small/dishes/broast-half.jpg',    'broast', 41),
('Full Broast',    '8 pieces chicken, fries, 2 buns and 4 garlic sauces.',               'Rs. 2800', 'assets/images/menu-small/dishes/broast-full.jpg',    'broast', 42);

-- ================================== DEALS ==================================
INSERT INTO @new (Name, Description, Price, Image, FilterTags, SortOrder) VALUES
('Maza Deal',   '4 pieces chicken, fries, 1 bun, garlic sauce and 1 can.',                        'Rs. 1550',  'assets/images/menu-small/dishes/broast-half.jpg', 'deal', 50),
('Couple Deal', '8 pieces chicken, fries, 1 bun, 2 garlic sauces and a 1.5L drink.',              'Rs. 2950',  'assets/images/menu-small/dishes/broast-full.jpg', 'deal', 51),
('Alpha Deal',  '16 pieces chicken, 4 fries, 4 buns, 4 garlic dips and a 1.5L drink.',            'Rs. 5200',  'assets/images/menu-small/dishes/broast-full.jpg', 'deal', 52),
('Beta Deal',   '32 pieces chicken, 8 buns, 8 fries, 8 garlic dips and a 1.5L drink.',            'Rs. 10000', 'assets/images/menu-small/dishes/broast-full.jpg', 'deal', 53);

-- ================================= BURGERS =================================
INSERT INTO @new (Name, Description, Price, Image, FilterTags, SortOrder) VALUES
('Fish Burger',          'Tartar sauce and iceberg, served with fries.',                                  'Rs. 780', 'assets/images/menu-small/dishes/burger-fish.jpg',       'burger', 60),
('Smash Beef Burger',    'Tomato, beef, iceberg and cheese slice with sauce.',                            'Rs. 900', 'assets/images/menu-small/dishes/burger-beef-smash.jpg', 'burger', 61),
('Zinger Burger',        'Marinated chicken thigh, crispy skin fried, served with fries.',                'Rs. 550', 'assets/images/menu-small/dishes/burger-zinger.jpg',     'burger spicy', 62),
('Chicken Grill Burger', 'Grilled chicken, salad, tomatoes, iceberg, cucumber and burger sauce, with fries.', 'Rs. 750', 'assets/images/menu-small/dishes/burger-grilled.jpg', 'burger', 63),
('Chicken Fillet Burger','Plain mayo, iceberg, cheese slice and fillet chicken.',                         'Rs. 480', 'assets/images/menu-small/dishes/burger-fillet.jpg',     'burger', 64);

-- =================================== BBQ ===================================
INSERT INTO @new (Name, Description, Price, Image, FilterTags, SortOrder) VALUES
('Chicken Malai Boti (8 pc)',          'Eight pieces of tender chicken malai boti.',          'Rs. 1999', 'assets/images/menu-small/dishes/malai-boti.jpg',   'bbq', 70),
('Chicken Special Green Boti (8 pc)',  'Eight pieces of special green boti.',                 'Rs. 1299', 'assets/images/menu-small/dishes/malai-boti.jpg',   'bbq', 71),
('Chicken Special Green Boti (12 pc)', 'Twelve pieces of special green boti.',                'Rs. 1899', 'assets/images/menu-small/dishes/malai-boti.jpg',   'bbq', 72),
('Hyderabadi Boti (4 pc)',             'Four pieces of Hyderabadi boti.',                     'Rs. 925',  'assets/images/menu-small/dishes/seekh-kebab.jpg',  'bbq spicy', 73),
('Hyderabadi Boti (8 pc)',             'Eight pieces of Hyderabadi boti.',                    'Rs. 1850', 'assets/images/menu-small/dishes/seekh-kebab.jpg',  'bbq spicy', 74),
('Reshmi Kabab (4 pc)',                'Four pieces of soft reshmi kabab.',                   'Rs. 1799', 'assets/images/menu-small/dishes/seekh-kebab.jpg',  'bbq', 75),
('Rim Jhim Kabab (4 pc)',              'Four pieces of rim jhim kabab.',                      'Rs. 1699', 'assets/images/menu-small/dishes/seekh-kebab.jpg',  'bbq', 76),
('Chicken Tikka (8 pc)',               'Eight pieces of charcoal-grilled chicken tikka.',     'Rs. 1599', 'assets/images/menu-small/dishes/chicken-karahi.jpg','bbq spicy', 77),
('Beef Kabab (4 pc)',                  'Four pieces of beef kabab.',                          'Rs. 1499', 'assets/images/menu-small/dishes/seekh-kebab.jpg',  'bbq', 78),
('Leg Piece',                          'Single charcoal-grilled leg piece.',                  'Rs. 499',  'assets/images/menu-small/dishes/chicken-karahi.jpg','bbq', 79),
('Chest Piece',                        'Single charcoal-grilled chest piece.',                'Rs. 499',  'assets/images/menu-small/dishes/chicken-karahi.jpg','bbq', 80),
('BBQ Temper Sauce',                   'Our house BBQ temper sauce.',                         'Rs. 120',  'assets/images/menu-small/dishes/wings-bbq.jpg',    'bbq', 81),
('Spicy Green Sauce',                  'Fresh spicy green sauce.',                            'Rs. 120',  'assets/images/menu-small/dishes/wings-hot.jpg',    'bbq spicy', 82);

-- ================================ STARTERS =================================
INSERT INTO @new (Name, Description, Price, Image, FilterTags, SortOrder) VALUES
('Kebab Bite',             'Golden kebab bites, freshly fried.',               'Rs. 799',        'assets/images/menu-small/dishes/seekh-kebab.jpg', 'starter', 90),
('Finger Fish (8 pcs)',    'Eight crispy fried fish fingers.',                 'Rs. 1499',       'assets/images/menu-small/dishes/fries-fish.jpg',  'starter', 91),
('Hot & Sour Soup',        'Classic hot and sour soup.',                       'Rs. 450 / 1299', 'assets/images/menu-small/dishes/nihari-special.jpg','starter spicy', 92),
('Chicken Corn Soup',      'Creamy chicken and sweetcorn soup.',               'Rs. 450 / 1299', 'assets/images/menu-small/dishes/nihari-special.jpg','starter', 93),
('Plain Fries',            'Crispy golden French fries.',                      'Rs. 450',        'assets/images/menu-small/dishes/fries-regular.jpg','fries', 94),
('Loaded Fries',           'Fries loaded with sauces and toppings.',           'Rs. 700',        'assets/images/menu-small/dishes/fries-loaded.jpg', 'fries', 95),
('Honey Wings (8 pcs)',    'Eight wings glazed in honey sauce.',               'Rs. 800',        'assets/images/menu-small/dishes/wings-honey.jpg',  'wings', 96),
('Hot Wings (8 pcs)',      'Eight wings tossed in hot sauce.',                 'Rs. 800',        'assets/images/menu-small/dishes/wings-hot.jpg',    'wings spicy', 97),
('B.B.Q Wings (8 pcs)',    'Eight wings coated in B.B.Q sauce.',               'Rs. 800',        'assets/images/menu-small/dishes/wings-bbq.jpg',    'wings', 98),
('Nuggets (12 pcs)',       'Twelve crispy chicken nuggets.',                   'Rs. 1000',       'assets/images/menu-small/dishes/nuggets.jpg',      'starter', 99);

-- ============================== BAR / DRINKS ===============================
INSERT INTO @new (Name, Description, Price, Image, FilterTags, SortOrder) VALUES
('1.5L Cold Drink',   'Chilled 1.5 litre bottle.',              'Rs. 250',  'assets/images/menu-small/dishes/drink-1500ml.jpg', 'drink', 110),
('Water Bottle',      'Chilled mineral water.',                 'Rs. 100',  'assets/images/menu-small/dishes/drink-500ml.jpg',  'drink', 111),
('Can (350ml)',       'Chilled 350ml soft drink can.',          'Rs. 160',  'assets/images/menu-small/dishes/drink-350ml.jpg',  'drink', 112),
('Oreo Shake',        'Thick shake blended with Oreo cookies.', 'Rs. 350',  'assets/images/menu-small/dishes/cake-brownie.jpg', 'shake', 113),
('Vanilla Shake',     'Classic creamy vanilla shake.',          'Rs. 450',  'assets/images/menu-small/dishes/cake-brownie.jpg', 'shake', 114),
('Chocolate Shake',   'Rich chocolate milkshake.',              'Rs. 500',  'assets/images/menu-small/dishes/cake-molten-lava.jpg','shake', 115),
('Nutella Shake',     'Indulgent Nutella milkshake.',           'Rs. 650',  'assets/images/menu-small/dishes/cake-molten-lava.jpg','shake', 116),
('Strawberry Shake',  'Fresh strawberry milkshake.',            'Rs. 450',  'assets/images/menu-small/dishes/cake-brownie.jpg', 'shake', 117),
('Mint Margarita',    'Refreshing mint margarita.',             'Rs. 350',  'assets/images/menu-small/dishes/drink-500ml.jpg',  'drink', 118),
('Fresh Lime',        'Freshly squeezed lime drink.',           'Rs. 300',  'assets/images/menu-small/dishes/drink-500ml.jpg',  'drink', 119),
('Pina Colada',       'Creamy pineapple and coconut cooler.',   'Rs. 550',  'assets/images/menu-small/dishes/drink-500ml.jpg',  'drink', 120),
('Blue Lagoon',       'Signature blue lagoon chiller.',         'Rs. 600',  'assets/images/menu-small/dishes/drink-500ml.jpg',  'drink', 121),
('Blue Lagoon + Sprite','Blue lagoon topped with Sprite.',      'Rs. 350',  'assets/images/menu-small/dishes/drink-500ml.jpg',  'drink', 122),
('Apple Berry',       'Apple and berry blend.',                 'Rs. 500',  'assets/images/menu-small/dishes/drink-500ml.jpg',  'drink', 123),
('Pink Lady',         'Our pink lady mocktail.',                'Rs. 400',  'assets/images/menu-small/dishes/drink-500ml.jpg',  'drink', 124),
('Khan e Azam Special','The house special signature chiller.',  'Rs. 500',  'assets/images/menu-small/dishes/drink-500ml.jpg',  'drink', 125),
('Cold Coffee',       'Chilled blended coffee.',                'Rs. 1000', 'assets/images/menu-small/dishes/drink-500ml.jpg',  'drink', 126);

-- ================================ ICE CREAM ================================
INSERT INTO @new (Name, Description, Price, Image, FilterTags, SortOrder) VALUES
('Vanilla Ice Cream',        'Regular or large scoop.', 'Rs. 250 / 400', 'assets/images/menu-small/dishes/cake-brownie.jpg', 'sweet', 130),
('Chocolate Chip Ice Cream', 'Regular or large scoop.', 'Rs. 250 / 400', 'assets/images/menu-small/dishes/cake-molten-lava.jpg','sweet', 131),
('Tutti-frutti Ice Cream',   'Regular or large scoop.', 'Rs. 250 / 400', 'assets/images/menu-small/dishes/cake-brownie.jpg', 'sweet', 132),
('Pistachio Ice Cream',      'Regular or large scoop.', 'Rs. 250 / 400', 'assets/images/menu-small/dishes/cake-brownie.jpg', 'sweet', 133),
('Kulfi Ice Cream',          'Regular or large scoop.', 'Rs. 250 / 400', 'assets/images/menu-small/dishes/cake-brownie.jpg', 'sweet', 134),
('Mango Ice Cream',          'Regular or large scoop.', 'Rs. 250 / 400', 'assets/images/menu-small/dishes/cake-brownie.jpg', 'sweet', 135),
('Strawberry Ice Cream',     'Regular or large scoop.', 'Rs. 250 / 400', 'assets/images/menu-small/dishes/cake-brownie.jpg', 'sweet', 136);

-- ============================ APPLY THE REFRESH ============================
DECLARE @sql NVARCHAR(MAX);
DECLARE @deactivated INT = 0, @inserted INT = 0;

BEGIN TRAN;

-- 1. Retire the old menu (recoverable: IsActive = 0, rows are kept).
SET @sql = N'UPDATE ' + @tbl + N' SET IsActive = 0 WHERE IsActive = 1';
EXEC sp_executesql @sql;
SET @deactivated = @@ROWCOUNT;

-- 2. Insert the new menu, skipping anything already present by Name + FilterTags.
CREATE TABLE #new (Name NVARCHAR(200), Description NVARCHAR(1000), Price NVARCHAR(100),
                   Image NVARCHAR(500), FilterTags NVARCHAR(200), SortOrder INT);
INSERT INTO #new SELECT Name, Description, Price, Image, FilterTags, SortOrder FROM @new;

SET @sql = N'
    INSERT INTO ' + @tbl + N' (Name, Description, Price, Image, FilterTags, SortOrder, IsActive)
    SELECT n.Name, n.Description, n.Price, n.Image, n.FilterTags, n.SortOrder, 1
    FROM #new n
    WHERE NOT EXISTS (SELECT 1 FROM ' + @tbl + N' m
                      WHERE m.Name = n.Name AND m.FilterTags = n.FilterTags)';
EXEC sp_executesql @sql;
SET @inserted = @@ROWCOUNT;

-- 3. Re-running: make sure the new menu is active and current even if rows existed.
SET @sql = N'
    UPDATE m
       SET m.Description = n.Description,
           m.Price       = n.Price,
           m.Image       = n.Image,
           m.SortOrder   = n.SortOrder,
           m.IsActive    = 1
    FROM ' + @tbl + N' m
    JOIN #new n ON m.Name = n.Name AND m.FilterTags = n.FilterTags';
EXEC sp_executesql @sql;

DROP TABLE #new;
COMMIT;

PRINT 'Deactivated ' + CAST(@deactivated AS NVARCHAR(10)) + ' previous menu item(s).';
PRINT 'Inserted ' + CAST(@inserted AS NVARCHAR(10)) + ' new menu item(s).';

SET @sql = N'SELECT FilterTags, COUNT(*) AS Items FROM ' + @tbl + N' WHERE IsActive = 1 GROUP BY FilterTags ORDER BY FilterTags';
EXEC sp_executesql @sql;

PRINT '--- Menu refresh complete ---';
GO
