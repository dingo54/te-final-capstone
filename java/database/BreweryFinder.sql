BEGIN TRANSACTION;

DROP TABLE IF EXISTS favorites, brewery_reviews, beer_reviews, beer, brewery, time, users;

CREATE TABLE brewery (
    brewery_id serial NOT NULL,
    brewery_name varchar(64) NOT NULL,
    phone_number varchar(14) NOT NULL,
    address varchar(64) NOT NULL,
	hours text NOT NULL,
    image_url text NOT NULL,
    description text NULL,
	is_approved boolean DEFAULT false,
    owner int NULL,

    CONSTRAINT pk_brewery PRIMARY KEY (brewery_id)
);

CREATE TABLE users (
	user_id SERIAL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE brewery_reviews (
    review_id serial NOT NULL,
    brewery_id int NOT NULL,
    user_id int NOT NULL,
    rating int NOT NULL,
    review varchar(1000) NULL,
    response varchar(600) NULL,

    CONSTRAINT pk_brewery_review PRIMARY KEY (review_id),
    CONSTRAINT fk_brewery_review_brewery_id FOREIGN KEY (brewery_id) REFERENCES brewery (brewery_id),
    CONSTRAINT fk_brewery_review_user_id FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE favorites (
    brewery_id int NOT NULL,
    user_id int NOT NULL,

    CONSTRAINT pk_favorites_brewery_id_user_id PRIMARY KEY (brewery_id, user_id),
    CONSTRAINT fk_favorites_brewery_id FOREIGN KEY (brewery_id) REFERENCES brewery (brewery_id),
    CONSTRAINT fk_favorites_user_id FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE time (
	brewery_id int NOT NULL,
    day int NULL,
    open_time int NULL,
    close_time int NULL,
    open boolean NOT NULL
);

CREATE TABLE beer (
    beer_id serial NOT NULL,
    brewery_id int NOT NULL,
    name varchar(64) NOT NULL,
    style varchar(64) NULL,
    price money NULL,
    abv float(2) NULL,
    image text NULL,
    description varchar(1000) NULL,

    CONSTRAINT pk_beer PRIMARY KEY (beer_id)
);

CREATE TABLE beer_reviews (
    review_id serial NOT NULL,
    beer_id int NOT NULL,
    user_id int NOT NULL,
    rating int NOT NULL,
    review varchar(600) NULL,

    CONSTRAINT pk_beer_review PRIMARY KEY (review_id),
    CONSTRAINT fk_beer_review_beer_id FOREIGN KEY (beer_id) REFERENCES beer (beer_id),
    CONSTRAINT fk_beer_review_user_id FOREIGN KEY (user_id) REFERENCES users (user_id)
);


INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$10$yM5uZTKxLgY5LQcZzY54DuRSiB7q0amH0r.wMLsbSfWpLn3wh/BGe','ROLE_ADMIN');
INSERT INTO users (username,password_hash,role) VALUES ('user3','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('user4','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('user5','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('user6','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('user7','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('user8','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('user9','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('user10','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_BREWER');




/***********************************************************************************************************
 Populating brewewry table with 8 breweries
***********************************************************************************************************/
INSERT INTO public.brewery(brewery_name, phone_number, address, hours, image_url, description,is_approved, owner) VALUES
	('Second District Brewing', '(215) 575-5900', '1939 S. Bancroft Street Philadelphia, PA 19145', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/7053061e17da04bd978ae77cf085fa9d.jpg',
	'Ben Potts has been brewing in the Philadelphia region for over 14 years, working with some of the areas most well known breweries. With a background focused heavily on experimentation and pushing the boundaries of what we know as ‘beer’, Ben has done it all - from working with exotic fruits and spices, barrel aging, mixed fermentation techniques, to some of the most unconventional brewing ingredients possible. With that in mind, Ben brings all of his experience to Second District, creating both off-the-wall flavors and classically inspired styles, along with everything in between.',true, 7),
	('Crime and Punishment Brewing Company', '(215) 235-2739', '2711 W Girard Ave, Philadelphia, PA 19130', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/fb468bf28e0dcda284e7c7e7adc3095c.jpg',
	'From ales and lagers, to saisons and IPAs, there’s something on tap for everyone. C+P aims to blend the once-great local brewing tradition with newer craft techniques and international inspirations. They have designed a rotating menu of distinctive brews and Russian-influenced dishes done their way. Crime + Punishment is proud to be part of a thriving community. We partner with local organizations to promote the rich culture of Brewerytown. Whether sponsoring the little league or hosting Philly arts events, C+P seeks creative ways to step outside our walls and participate in neighborhood life. It’s not just a place to eat and drink, it’s a place to get to know your neighbors. Great beer.  Great food. Great community. Crime + Punishment welcomes you.',true,7),
	('Yards Brewing Company', '(215) 525-0715', '500 Spring Garden St Philadelphia, PA 19123', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/8c336be5e2177a839bed109d8ba8a193.png',
	'Yards has been brewing Philly''s beer since 1994. We’ve grown from a garage-sized operation in Manayunk all the way up to our current location at 500 Spring Garden Street in Northern Liberties. And we couldn''t have done it without your support through the years. Our beers always have and always will be brewed, bottled, kegged, and canned for the hard working people of Philadelphia and beyond.',true, 7),
	('Love City Brewing', '(215) 398-1900', '1023 Hamiltion Street Philadelphia, PA 19123', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/b88a2a13dedf6a003f4ebf7f6c2bacad.png',
	'We create unfailingly delicious beer that is the centerpiece of Philadelphia’s table. We do whatever it takes to ensure the quality of each beer we serve. At Love City, we take care of each other. We prioritize relationships with our customers, colleagues, and community. We grow at a pace that allows us to maintain these values and priorities. We work hard to demonstrate what a craft brewery should be – a responsible small business that makes outstanding beer while respecting the people that make it possible.',true,7),
	('Weenie Hut General', '(215) 965-2305', '526 Market St, Philadelphia, PA 19106', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/27a97b99ea7739d6436dcaca832d8a49.jpg', 'A silly lil’ brewery!',true,6),
	('The Salty Spitoon', '(215) 763-1800', '2600 Benjamin Franklin Pkwy, Philadelphia, PA 19130', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/f2cafbce2b4497d9d463df0fb6eb8a77.jpg',
	'Ahoy, fair lass, it be the line to get into the Salty Spitoon — the roughest, toughest sailor club ever to be built under the seven seas. Only the baddest of the bad can get in.',true,6),
	('Scorsese', '(215) 236-3300', '2027 Fairmount Ave, Philadelphia, PA 19130', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/06338bb792245ca0d26af0f7dea44dc6.jpg',
	'We love craft beer! Our tap room is designed to be a comfortable place to hang out with family and friends. Come, play in our backyard! Please feel free to bring your own food, have some delivered, or come to enjoy one of our frequent food truck events.',true,6),
	('Goodfellas', '(215) 922-2317', '1136 Arch St, Philadelphia, PA 19107', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/d75fc55c47a9ea82c3b52bf2c3d2eea0.png',
	'We always called each other good fellas. Since the 80''s, two college buds Tony and Artie decided to brew some beer for their friends. Whether it was natural talent or the endless supply of suds, people liked what they tasted and wanted more. They didn''t know it at the time, but this was the beginning of what was to become Goodfellas.',true,6),
	('Test #9 Owned by brewer #5 Unapproved', 'Test Phone', 'Test Address Test Address', 'M-F: 8-11 S-S: 8-2', 'https://www.tampabay.com/resizer//uwoglU_jzFjW3-JIF7HcjaOcK1Q=/900x506/smart/filters:format(webP)/cloudfront-us-east-1.images.arcpublishing.com/tbt/7OKZVBKPIZF4VEK77DUSVTVV7E.jpg', 'Test brewery that should not be approved.',false, 9),
    ('Test #10 Owned by brewer #5 Unapproved', 'Test Phone', 'Test Address Test Address', 'M-F: 8-11 S-S: 8-2', 'https://imageio.forbes.com/specials-images/dam/imageserve/111577230/960x0.jpg', 'Test brewery that should not be approved.',false, 9);

/***********************************************************************************************************
 Populating beer
***********************************************************************************************************/
INSERT INTO public.beer(brewery_id, name, style, price, abv, image, description) VALUES
	(1, 'Bancroft Beer', 'Ale', 6, 4.20, 'https://i.gyazo.com/666f5ded17e8474d2f1be8f99177e91e.png', 'Our daily drinker, named after the street our humble brewery rests on. Brewed with American 2-row and English Maris Otter malt. Singularly hopped with Mosaic. Punchy notes of Satsuma orange rind, lychee flesh, and fresh blueberry muffin with a clean and crisp finish. 4.20% abv'),
	(1, 'Smoked Dunkel', 'Lager', 8, 6, 'https://i.gyazo.com/5ab93c917140b256ba4ca19ab706420a.png', 'Take a jaunt north from Munich to Bamberg with this smoky brown lager. Traditional Munich Dunkel grist with a slightly northern spin combining two of our favorite styles – Munich Dunkel and Bamberg Rauchbier. Brewed with German Pilsner, Munich, and a modest percentage of beechwood smoked malts and a dash of Spalt Select hops. Rich flavors of hearth baked bread smothered in Nutella with a sprinkle of toffee and fire roasted smores. A real Fall treat. 5.5%abv'),
    (1, 'Northeast Extension ’22', 'Malt', 5, 4.5, 'https://i.gyazo.com/cf1ee5040dc5496f1e66abdf26be10dd.png', 'Hoppy American Pils. For this year’s batch of Northeast Extension, an annual exploration of PA grown malt and Estate Grown hops from our own Second District Brew Farm, we utilized a simple base of Colonial Pilsner malt from our friends at Deer Creek and then dressed it up with Brew Farm Cascade and Willamette. We then fermented the resulting wort with our house lager yeast to create a zippy unfiltered pilsner jam-packed with Pennsylvania terroir. Clean crackery malt notes followed by grassy green tea with a hint of orange peel. 4.5% abv'),
    (1, 'Chadwick on Brett', 'Brown Ale', 6, 8, 'https://gyazo.com/933d612124705843ead259c794d20106.png', 'We took a small portion of the original late-Spring batch of Chadwick before carbonation, spiked it with a bit of brett, and let it condition for the Summer. The result is a delicious introspective into what porter might have been like after traveling in oak barrels for long periods of time back in the 1800’s. More dry than the fresh version, woody, bittersweet cacao, gentle twang with a little mystery. *NITRO*'),
    (1, 'Pils Mercato', 'Pilsner', 5, 5.2, 'https://i.gyazo.com/65ab0eb5a2e35969ccfc45f0ae0ac419.png', 'Created with our friends at DiBruno’s as a nod to their history and heritage and the original Italian Market storefront on 9th street. Brewed entirely with lovely German pilsner malt, we then took local Viva Leaf Tea tulsi basil infused honey and added it in the whirlpool to retain as much nuance as possible. Hopped in the kettle with fresh Spalter Select and Hallertauer Mittelfrüher, and then again post fermentation for that modern classic Italian pils profile. Aromas jump out of the glass with honey drizzled bread crust, rolling grassy fields, and gentle black currant. The flavor rides those same waves with a delightfully dry spicy finish. 5.2% abv'),
    (1, 'Entwife', 'Rye Dark Mild', 7, 3.4, 'https://i.gyazo.com/b4109bf6e895e5fc1c3f08134f273474.png', 'Entwife season is here! This beer has a special place in our hearts as one of the first we made for our opening in 2017. Entwife is a Rye Dark Mild built with English Maris Otter, Rye, and Chocolate malts. This year we added English crystal rye as well. Hopped delicately with East Kent Goldings in the kettle. Pint fulls of chocolate Rice Krispies and rich toffee with chewy pumpernickel followed by a spicy finish from the rye. At 3.4%, it’s the perfect beer to accompany a night full of good food and great company.'),
    (2, 'BEHEMOTH', 'Oatmeal Stout', 4, 6.5, 'https://i.gyazo.com/e79924b244c37c84204705bd0f1cc2a0.png', 'Behemoth, our Oatmeal Stout is now on tap! This inky brew''s namesake is an enourmous, demonic, and mischievous black cat from Mikhail Bulgakov''s Novel The Master and Margarita'),
    (2, 'Space Race', 'IPA', 5, 7, 'https://i.gyazo.com/a89c18a03a457b0567047ff78e4db932.png', 'In the world of IPAs, the sky''s the limit. Hopped and dryhopped with Citra, Mosaic, Columbus, and Simcoe. Scents of stone fruits, papaya, and wheat grass commingle with flavors of passionfruit, mango, and grapefruit rind, ultimately leading to a clean, dry finish. Join us on the IPA journey'),
    (2, 'Pig''s Ear', 'Ordinary Bitter', 3, 4.6, 'https://i.gyazo.com/c0b0c7d81c4be21f85fa908c8b6f0539.png', 'Cockney slang for beer! Notes of bran flakes, sourdough bread, plum and raisin. Give us an oxford scholar, take the apples and pears, and try not to spill it on your uncle Bert.'),
    (2, 'Lunokhod', 'IPA', 4, 6, 'https://i.gyazo.com/7a5d893490850846e61c4deb66a04b1c.png', 'Another addition to our family of hoppy beers brewed with barley and hooped with Galaxy and Citra. Lunokhod strikes the perfect balcance of body, hop saturation, and drinkability with notes of ripe mango, melon and ripped green bell peppers.'),
    (3, 'Level Up', 'Tropical IPA', 4, 6.5, 'https://gyazo.com/4e6b56cc414f9f6799578a8dfab5d1c7', 'This isn’t just any old IPA. It’s a legit India Pale Ale with some serious tropical infusion. So drop in a coin and press play. This is some next level stuff, right here.'),
    (3, 'Star Jockey', 'Galaxy Hop Hazy IPA', 5, 7.2, 'https://i.gyazo.com/3191a211edea1ea8d9a8e7a064723052.png', 'Brewed with Cosmic Punch™ and infused with Galaxy hops, this rocket is ready to ride, buckaroo. So saddle up and hold fast! We don''t blast off, we blast ON! And ON! And ON! Across the universe and beyond.'),
    (3, 'VERY MEGA', 'SUPER DELUXE MEGA AWESOME BEER', 5, 9.2, 'https://i.gyazo.com/7d2c12b225e59305c9b9736243c96699.png', 'ENTERING THE RING WEIGHING IN AT 9.2%, THE 2X IPA CHAMPION OF THE MEGAVERSE, VEEERRRYYY MEGA! SWOLE WITH MEGA TROPICAL NOTES! MEGA CITRUS NOTES! VERY MEGA WILL PILEDRIVE YOUR TASTE BUDDIES WITH MEGA HOP AROMAS AND FLAVOR! QUAFF HARD, PEOPLE!'),
    (3, 'Philly Standard', 'Beer', 4, 4.5, 'https://i.gyazo.com/1ea055b1ed376a2061c28d13efaa3d6c.png', 'Sometimes you just want a beer. No bells. No whistles. Just a good, handcrafted, no-nonsense beer that works just as hard as you do. Light. Clean. Easy. The standard beer for every occasion.'),
    (4, 'Love City Lager', 'American Golden Lager', 5, 4, 'https://images.squarespace-cdn.com/content/v1/586d0eeb6a49637ca198ec9e/1612825171549-9XJRD1M096DWAJM9CVVA/LCB_LOVECITY_LAGER_2019+copy.jpg?format=300w', 'Love City Lager is brewed for everybody. Our American Golden Lager is simple, clean, and true to its roots. Lightly malty and a hint of orange aromatics give every bright sip a clean landing.'),
    (4, 'Lime City Lager', 'Lime-infused Lager', 6, 4, NULL, 'That feeling you get when surrounded by good friends & sunshine! Made with lime and sea salt for a bright, refreshing taste. The perfect beer for warm weather & good times.'),
    (4, 'Sure Shot', 'Kölsch', 7, 4.4, NULL, 'The ultimate session beer! Refreshing and light-bodied, our Kölsch is balanced with pilsner malt and features subtle fruit and spice character.'),
    (4, 'Deep Cut', 'Pilsner', 7, 5, NULL, 'Pilsner is the beer that brewers reach for. Like a musician’s favorite track, it’s a Deep Cut. This one is made with all German malt and hops. Lightly bready malt character with floral and herbal hop notes. It’s crisp, complex & crushable.'),
    (4, 'Sylvie', 'Oatmeal Stout', 7, 5, NULL, 'This English-style oatmeal stout is silky smooth and lightly sweet. This year-round stout is brewed with dark, roasted malts that lend rich dark chocolate and espresso flavors. The addition of oats lends a smooth, round finish.'),
    (4, 'Solid State', 'Helles Lager', 7, 5, NULL, 'Solid State is a Munich-style Helles brewed with German malt and hops. Lightly bready with subtle floral, herbal hop character and a crisp finish. The beer to reach for after a long day'),
    (4, 'Unity', 'American IPA', 7, 5.5, NULL, 'This approachable IPA brings hop lovers together around the citrus flavors of our hop blend. It is assertive, yet highly drinkable. Low bitterness and a crisp finish.'),
    (5, 'Lemons To Betsy', 'IPA', 6, 5.5, 'https://i.gyazo.com/e5261c872f72ee002994b946b6ba48c4.jpg', 'A hazy, fruited NEIPA brewed with fresh Meyer lemons. As if the fruit wasn''t enough, we dry hop this beer with Lemondrop and Amarillo to add to the dank aromas of juicy lemon and mandarin oranges and to help balance the sweetness of the fruit. Cloudy, fruity, fresh and hoppy - Lemons to Betsy it''s freaking good.'),
    (5, 'Sour Hound', 'American Sour Ale', 3, 5, 'https://gyazo.com/215f0f445625bc92655eea4d27a35918', 'An original brown ale kettle sour. Lacto drops the pH early in the brewing process delivering a nice tart backbone. The Hound is laced with Belgian chocolate malts and a touch of noble hops. Cola, sour, vanilla, fruity - we''ve heard it all when it comes to this fan favorite sour brown ale.'),
    (5, 'Nice Dreams Gingercake', 'Sour & Barrel Aged', 5, 5, 'https://i.gyazo.com/f0ba8f0d964c29875cd66b3d0e36c5e2.jpg', 'This golden sour spent a year and a half in a white wine barrel while aging on freshly cut ginger and graham cracker in the last 3 months. Notes of vanilla, ginger, stone fruit and a touch of cake sweetness balance the tart and zesty nature of this beer. pH 3.2'),
    (6, 'Two Robbers Pineapple Ginger', 'Hard Seltzer', 6, 5.2, 'https://i.gyazo.com/058eb73990c411dfb177b50e883285c8.png', 'Pineapple and Ginger Hard Seltzer. Pineapple notes and scent are stronger, with a subtle Ginger aftertaste.'),
    (6, 'Two Robbers Peach Berry', 'Hard Seltzer', 6, 5.2, 'https://i.gyazo.com/8ba6ea4ec2bec5b0f32d51b715f671b2.png', 'Two Robbers Peach Berry offers a brilliant balance of fresh white peaches on the aroma, with a variety of fresh berries dominating the taste. Catch notes of blueberry, raspberry and strawberry on the finish of this crystal clear hard seltzer.'),
    (6, 'Coal Porter', 'Ale', 4, 6, 'https://i.gyazo.com/b098f078fc68a295ece6f818586a5a1a.png', 'Nearly opaque dark, dark brown color. Aromas and flavors of dark chocolate, coffee, dark grained baked bread, roasted nuts and a bubbly, medium body finishing with a slight sweet coal smoked flavor. A rock solid beer that will pair nicely with grilled meats and game.'),
    (6, 'Wrong Way', 'Hoppy', 3, 6.3, NULL, 'hazy IPA with crisp citrus notes and a slightly bitter finish'),
    (7, 'Ghost Face Keller', 'Easy', 2.5, 4.8, NULL, 'this delicious cloudy pilsner is made exclusively with Deer Creek PA malts. We combined equal parts of our 3 favorite base malts from them which are their Colonial Pilsner, Pale Wheat and Pale Rye. The outcome is a cloudy easy drinking delicious pilsner with some wonderful malt flavors from the variety of grains as well as Deer Creek’s floor malting process.'),
    (7, 'DIME PEICE (2022)', 'Barrel Aged Belgian Quad', 4, 10, NULL, 'This Belgian Quad is made exclusively with PA malts from Deer Creek and then aged in New Liberty whiskey barrels for three months. Aroma gives up a hearty yeasty spice character of cinnamon toasted malt and caramelized candy sugar. Flavor notes of candied orange vanilla and charred peach'),
    (7, 'Brawler', 'English Mild', 4, 4.2, 'https://i.gyazo.com/c610fcd857512e8ef769c38ffa24363a.png', 'Crafted in the style of an English mild, this malt-forward ale is great when you want to go a few rounds. Its smooth character, hints of caramel and toast and remarkable drinkability define this ruby-colored brew as a knockout session ale.'),
    (8, 'Choking Hazard', 'Hoppy', 4, 5.3, NULL, 'Originally brewed in collaboration with Philly grindcore powerhouse, DIE CHOKING. We used exclusively Nelson Sauvin hops and kept the ABV low at 5.3% to bring you a beer that becomes a “Choking Hazard” when you start crushing these too fast! Notes of grape, gooseberry and dank.'),
    (8, 'Severed Paths', 'Dark Lager', 5, 8.6, NULL, 'Cold fermented using lager yeast, this excellent historic style has characteristics of a dark lager and a porter, but bumped up a few notches. It''s roasty, malty, with a rounded body that covers up any hint of its strong ABV. Notes of dark fruit, molasses, dark chocolate, and toffee.'),
    (8, 'Pitouchi', 'Belgian Quad', 7, 10, 'https://i.gyazo.com/7b269a3b143325b3ec466c69840bae08.png', 'We named this Belgian “quad” after Pitouchi the cat, who was adopted in the trenches by a Belgian officer during World War I. A complex balance of sweet, bready malts, dark fruit esters, and that Belgian Ale spice...this beautiful dark ale finishes perfectly smooth, dry, and delicate with just a slight bit of alcohol warmth.'),
    (8, 'De Niro', 'Oatmeal Stout', 6, 4.6, NULL, 'Our original stout is back! A roasty, toasty, dry stout brewed with lots of flaked oats. Notes of dark chocolate, roasted coffee beans, toasted biscuit, and dark caramel.'),
    (8, 'Ray Liotta', 'Coffee Porter', 6, 5.6, NULL, 'A collaboration with our neighbors over at Germantown Expresso and Many Hands Coffee Co., this porter has been in the works for awhile. To make sure we brewed it well, we experimented many different times with many different techniques, and we think we figured it out. Freshly roasted Peruvian coffee beans went straight into the tank and cold steeped for a little over 24 hours. The result is a merrier world.');

/***********************************************************************************************************
 Populating time
***********************************************************************************************************/
INSERT INTO public.time(brewery_id, day, open_time, close_time, open) VALUES
	(1, 0, 8, 11, true),
	(1, 1, 8, 11, true),
	(1, 2, 8, 11, true),
	(1, 3, 8, 11, true),
	(1, 4, 8, 11, true),
	(1, 5, 8, 11, true),
	(1, 6, 8, 11, false),
	(2, 0, 9, 11, false),
    (2, 1, 9, 11, false),
    (2, 2, 9, 11, true),
    (2, 3, 9, 11, true),
    (2, 4, 9, 11, true),
    (2, 5, 9, 11, true),
    (2, 6, 9, 11, false),
    (3, 0, 5, 12, false),
    (3, 1, 5, 12, false),
    (3, 2, 5, 12, false),
    (3, 3, 5, 12, false),
    (3, 4, 5, 12, true),
    (3, 5, 5, 12, true),
    (3, 6, 5, 12, true),
    (4, 0, 8, 11, true),
    (4, 1, 8, 11, true),
    (4, 2, 8, 11, true),
    (4, 3, 8, 11, true),
    (4, 4, 8, 11, true),
    (4, 5, 8, 11, true),
    (4, 6, 8, 11, false),
    (5, 0, 9, 11, false),
    (5, 1, 9, 11, false),
    (5, 2, 9, 11, true),
    (5, 3, 9, 11, true),
    (5, 4, 9, 11, true),
    (5, 5, 9, 11, true),
    (5, 6, 9, 11, false),
    (6, 0, 5, 12, false),
    (6, 1, 5, 12, false),
    (6, 2, 5, 12, false),
    (6, 3, 5, 12, false),
    (6, 4, 5, 12, true),
    (6, 5, 5, 12, true),
    (6, 6, 5, 12, true),
    (7, 0, 8, 11, true),
    (7, 1, 8, 11, true),
    (7, 2, 8, 11, true),
    (7, 3, 8, 11, true),
    (7, 4, 8, 11, true),
    (7, 5, 8, 11, true),
    (7, 6, 8, 11, false),
    (8, 0, 8, 11, true),
    (8, 1, 8, 11, true),
    (8, 2, 8, 11, true),
    (8, 3, 8, 11, true),
    (8, 4, 8, 11, true),
    (8, 5, 8, 11, true),
    (8, 6, 8, 11, false);

/***********************************************************************************************************
 Populating brewewry review
***********************************************************************************************************/
INSERT INTO public.brewery_reviews(brewery_id, user_id, rating, review) VALUES
    (1, 3, 5, 'I was pleasantly surprised! Great beer selection and the food was delicious. Large portions and reasonably priced. A bunch of vegan options, and outdoor seating. Will definitely be returning!'),
    (1, 4, 5, 'I had one of their IPAs at another restaurant, and it was so good I had to come here. All of their IPAs were flavorful, but actually the most impressive one was the Pilsner! Most pilsners I''ve had up until now were kind of simple and boring, but this one was really delicious, citrusy, and full of character.'),
    (1, 5, 5, 'Good line up of beers, fries are good. Buffalo cauliflower doesn’t have a hint of Buffalo at all unfortunately. Great breading and very fresh otherwise. Just want that SPICE, the dip page sauce is on point though. Great lil buddy “citywide” too. Cool late night spot to go with friends.'),
    (2, 3, 5, 'Decided to walk up to Crime and Punishment on a humid end of Summer Saturday. The interior was relaxed and inviting, and service great overall. We grabbed a seat and were treated to several delicious beers and surprisingly good pierogis. Would definitely come back next time we''re in the area!'),
    (2, 4, 4, 'A cool lowkey spot in Brewerytown. The Space Race IPA was pretty good. Definitely worth a stop if you''re in the neighborhood and like beer.'),
    (2, 5, 5, 'Small craft brewery. Excellent, friendly staff. We tried several different beers and all were excellent. Tender toward more happy IPA flavors but also had a nice lager, pilsner and one more like a sour. A few small nosh foods. We had awesome pirogies and spicy dipping sauce and pita bread. The pretzels also looked great. Reasonable prices but boy the Philly alcohol AND beer taxes are crazy. On-street parking so may need to park a couple blocks away. Recommend you drop by and give them a try!'),
    (3, 3, 5, 'Me & girlfriend took the tour which was amazing. Mike was phenomenal & very knowledgeable. Tour is roughly 45 minutes. Very informative. Clean environment, clean place and clean staff! For 10$ a person, I HIGHLY HIGHLY recommend the tour. You get a sample, canned beer & a souvenir. Which would equate to more than 10$. Very nice historical education of yards. 10/10 recommend. Will likely return'),
    (3, 4, 4, 'Good food. Pretty much something for everyone. Beer is also really really good. When I first went here I didn''t care for what they had on tap but they''ve def added more variety (I''m pretty sure feel free to call me out on being wrong lol). Cool venue. We saw a wedding reception there once. Their merch store is A+. Bought several things there over the course of several trips lol. To put it in perspective, this was the first place my fiance wanted to go to after running the Philadelphia Marathon. She said it was worth it. 💙'),
    (3, 5, 5, 'Great beer. Great people. Awesome atmosphere. We loved it! Been on our list for awhile and we were so happy to check it off our brewery list! Thanks for making a great experience'),
    (4, 3, 5, 'Visited Love City Brewing after a concert at Franklin Music Hall and had a wonderful, chill time. The beers were on point and the crowd was all having a great experience. Some more food options would have been nice, but it''s a minor complaint. Highly recommend a visit!'),
    (4, 4, 5, 'Cool effing place, great beers and cool people pulling the taps! I just popped in on the word of a friend and I’m glad I did. $4 pints happy hour specials until 6:00!'),
    (4, 5, 5, 'Some excellent and somewhat unique beer options and great service.  No flights offered but the friendly and helpful bartender more than made up for it by her willingness to let us sample a whole bunch.  Dreamcycle and Driponomics were the two standout offerings for us.'),
    (5, 3, 3, 'Had a great time. Good drinks and watched football all day. However the owners decided they wanted our table and the one next to us. So they told us we had to close out. Day went from a 10 to a 1. Disappointed that patrons would be treated this way. Understandable that they wanted to watch Eagles vs. Cowboys. We planned to watch that game here also and already had a $200 tab. Would I come back again to see if things are different a other weekend? Yes.'),
    (5, 4, 2, 'I have been to this establishment many times, but have never been disrespected in the way I have tonight. The server, "Devon" approached our table and noticed we already had beers. Thus he refused to serve our table water because we had drinks already, unless we started a tab. There is not an establishment in Philadelphia that would make such a request. Honestly, we got drinks before the table became available and we intended on buying more rounds, but this behavior is unacceptable! If I''m a paying customer, which is clear because we had round of drinks, I should not have to start a tab for WATER! This was the worst service I''ve ever had in a bar in Philly.  My friends and I should not be subjected to this behavior. Please correct this as we would have had many rounds of drinks, but given this behavior, we will spend our money elsewhere. Btw, the bar was not that busy!'),
    (5, 5, 2, 'Wayyyyy below average. Cocktails are all drowning in lime juice and food all seems to be frozen prior to cooking. Not impressed at all'),
    (6, 5, 5, NULL),
    (7, 4, 4, NULL),
    (8, 4, 5, NULL);


;


COMMIT;

GRANT ALL
ON ALL TABLES IN SCHEMA public
TO final_capstone_owner;

GRANT ALL
ON ALL SEQUENCES IN SCHEMA public
TO final_capstone_owner;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO final_capstone_appuser;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO final_capstone_appuser;
