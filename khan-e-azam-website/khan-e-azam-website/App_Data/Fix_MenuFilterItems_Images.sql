-- Repoint MenuFilterItems that were still using the old round-robin
-- placeholder set (menu-small/grid/pic1-8.png) to the correctly-matching
-- real dish photos already sitting in assets/images/menu-small/dishes/.
-- Idempotent: plain UPDATEs by exact Name match, safe to re-run.
USE KhanEAzamDB;
GO

UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/sandwich-grilled.jpg' WHERE Name='Grilled Sandwich';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/sandwich-panini.jpg' WHERE Name='Panini Sandwich';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/sandwich-bbq.jpg' WHERE Name='Bar.B.Q Sandwich';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/sandwich-club.jpg' WHERE Name='Club Sandwich';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/sandwich-smokey.jpg' WHERE Name='Smokey Sandwich';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/shawarma-grilled.jpg' WHERE Name='Grilled Shawarma';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/shawarma-chicken.jpg' WHERE Name='Chicken Shawarma';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/shawarma-zinger.jpg' WHERE Name='Zinger Shawarma';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/shawarma-zinger.jpg' WHERE Name='Zinger Cheez Shawarma';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/shawarma-chicken.jpg' WHERE Name='Chicken Cheez Shawarma';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/shawarma-malai-boti.jpg' WHERE Name='Malai Boti Shawarma';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/burger-big-eleven.jpg' WHERE Name='Big Eleven Burger';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/burger-grilled.jpg' WHERE Name='Grilled Burger';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/burger-grilled.jpg' WHERE Name='Smokey Grilled Burger';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/burger-zinger.jpg' WHERE Name='Zinger Burger';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/burger-zinger.jpg' WHERE Name='Zinger Cheez Burger';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/burger-fillet.jpg' WHERE Name='Filet Burger';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/burger-grand-king.jpg' WHERE Name='Grand King Burger';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/wrap-matrila.jpg' WHERE Name='Matsila Rap Roll';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/roll-stuff.jpg' WHERE Name='Stuff Roll';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/roll-bihari.jpg' WHERE Name='Behari Roll';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/paratha-chicken.jpg' WHERE Name='Grilled Paratha Roll';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/paratha-chicken.jpg' WHERE Name='Chicken Paratha Roll';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/paratha-chicken.jpg' WHERE Name='Chicken Cheez Paratha Roll';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/paratha-zinger.jpg' WHERE Name='Zinger Paratha Roll';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/paratha-zinger.jpg' WHERE Name='Zinger Cheez Paratha Roll';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/paratha-malai-boti.jpg' WHERE Name='Malai Boti Paratha Roll';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/fries-loaded.jpg' WHERE Name='Loaded Fries';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/fries-crinkle.jpg' WHERE Name='Crinkle Fries';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/fries-mayo-garlic.jpg' WHERE Name='Mayo Garlic Fries';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/fries-regular.jpg' WHERE Name='Regular Fries';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pasta-alfredo.jpg' WHERE Name='Al-Afredo Pasta';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pasta-lazania.jpg' WHERE Name='Lasagna Pasta';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pasta-special.jpg' WHERE Name='Special Pasta';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pasta-alfredo.jpg' WHERE Name='Creamy Pasta';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/wings-bbq.jpg' WHERE Name='Bar.B.Q Wings';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/wings-honey.jpg' WHERE Name='Honey Wings';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/wings-peri-peri.jpg' WHERE Name='Peri Peri Wings';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/nuggets.jpg' WHERE Name='Nuggets';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/hot-shots.jpg' WHERE Name='Hot Shot';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/broast-quarter.jpg' WHERE Name='Quarter Broast';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/broast-half.jpg' WHERE Name='Half Broast';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/broast-full.jpg' WHERE Name='Full Broast';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pizza-tikka.jpg' WHERE Name='Tikka Pizza';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pizza-malai-boti.jpg' WHERE Name='Malai Boti Pizza';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pizza-fajita.jpg' WHERE Name='Fajita Pizza';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pizza-bbq.jpg' WHERE Name='Bar.B.Q Pizza';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pizza-cheese-lover.jpg' WHERE Name='Cheez Lover Pizza';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pizza-khan-special.jpg' WHERE Name='Special Pizza';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pizza-bihari-kabab.jpg' WHERE Name='Behari Kabab Pizza';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pizza-crown-crust.jpg' WHERE Name='Crown Crust Pizza';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pizza-kabab-stuff.jpg' WHERE Name='Kabab Stuffer Pizza';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pizza-lazania.jpg' WHERE Name='Lasagna Pizza';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/pizza-super-supreme.jpg' WHERE Name='Super Supreme Pizza';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/salad-russian.jpg' WHERE Name='Russian Salad';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/salad-russian-namkeen.jpg' WHERE Name='Russian Namkeen Salad';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/cake-molten-lava.jpg' WHERE Name='Molten Lava Cake';
UPDATE MenuFilterItems SET Image='assets/images/menu-small/dishes/cake-brownie.jpg' WHERE Name='Brownie';

-- Today's Special: reuse the same verified real photos already sourced for Browse Our Menu
UPDATE TodaysSpecials SET Image='assets/images/menu-small/dishes/chicken-karahi.jpg' WHERE Name='Chicken Karahi';
UPDATE TodaysSpecials SET Image='assets/images/menu-small/dishes/mutton-biryani.jpg' WHERE Name='Mutton Biryani';
UPDATE TodaysSpecials SET Image='assets/images/menu-small/dishes/seekh-kebab.jpg' WHERE Name='Seekh Kebab';
GO
