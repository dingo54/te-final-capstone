BEGIN TRANSACTION;

DROP TABLE IF EXISTS brewery_beer, beer, brewery, time;

CREATE TABLE brewery (
    brewery_id serial NOT NULL,
    brewery_name varchar(64) NOT NULL,
    phone_number varchar(14) NOT NULL,
    address varchar(64) NOT NULL,
    image_url text NULL,
    description varchar(1500) NULL,

    CONSTRAINT pk_brewery PRIMARY KEY (brewery_id)
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

/***********************************************************************************************************
 Populating brewewry table with 8 breweries
***********************************************************************************************************/
INSERT INTO public.brewery(brewery_name, phone_number, address, image_url, description) VALUES
	('Second District Brewing', '(215) 575-5900', '1939 S. Bancroft Street Philadelphia, PA 19145', 'https://i.gyazo.com/7053061e17da04bd978ae77cf085fa9d.jpg',
	'Ben Potts has been brewing in the Philadelphia region for over 14 years, working with some of the areas most well known breweries. With a background focused heavily on experimentation and pushing the boundaries of what we know as ‘beer’, Ben has done it all - from working with exotic fruits and spices, barrel aging, mixed fermentation techniques, to some of the most unconventional brewing ingredients possible. With that in mind, Ben brings all of his experience to Second District, creating both off-the-wall flavors and classically inspired styles, along with everything in between.'),
	('Crime and Punishment Brewing Company', '(215) 235-2739', '2711 W Girard Ave, Philadelphia, PA 19130', 'https://i.gyazo.com/fb468bf28e0dcda284e7c7e7adc3095c.jpg',
	'From ales and lagers, to saisons and IPAs, there’s something on tap for everyone. C+P aims to blend the once-great local brewing tradition with newer craft techniques and international inspirations. They have designed a rotating menu of distinctive brews and Russian-influenced dishes done their way. Crime + Punishment is proud to be part of a thriving community. We partner with local organizations to promote the rich culture of Brewerytown. Whether sponsoring the little league or hosting Philly arts events, C+P seeks creative ways to step outside our walls and participate in neighborhood life. It’s not just a place to eat and drink, it’s a place to get to know your neighbors. Great beer.  Great food. Great community. Crime + Punishment welcomes you.'),
	('Yards Brewing Company', '(215) 525-0715', '500 Spring Garden St Philadelphia, PA 19123', 'https://i.gyazo.com/8c336be5e2177a839bed109d8ba8a193.png',
	'Yards has been brewing Philly''s beer since 1994. We’ve grown from a garage-sized operation in Manayunk all the way up to our current location at 500 Spring Garden Street in Northern Liberties. And we couldn''t have done it without your support through the years. Our beers always have and always will be brewed, bottled, kegged, and canned for the hard working people of Philadelphia and beyond.'),
	('Love City Brewing', '(215) 398-1900', '1023 Hamiltion Street Philadelphia, PA 19123', 'https://i.gyazo.com/b88a2a13dedf6a003f4ebf7f6c2bacad.png',
	'We create unfailingly delicious beer that is the centerpiece of Philadelphia’s table. We do whatever it takes to ensure the quality of each beer we serve. At Love City, we take care of each other. We prioritize relationships with our customers, colleagues, and community. We grow at a pace that allows us to maintain these values and priorities. We work hard to demonstrate what a craft brewery should be – a responsible small business that makes outstanding beer while respecting the people that make it possible.'),
	('Weenie Hut General', '(215) 965-2305', '526 Market St, Philadelphia, PA 19106', 'https://i.gyazo.com/27a97b99ea7739d6436dcaca832d8a49.jpg', 'A silly lil’ brewery!'),
	('The Salty Spitoon', '(215) 763-1800', '2600 Benjamin Franklin Pkwy, Philadelphia, PA 19130', 'https://i.gyazo.com/f2cafbce2b4497d9d463df0fb6eb8a77.jpg',
	'Ahoy, fair lass, it be the line to get into the Salty Spitoon — the roughest, toughest sailor club ever to be built under the seven seas. Only the baddest of the bad can get in.'),
	('Scorsese', '(215) 236-3300', '2027 Fairmount Ave, Philadelphia, PA 19130', 'https://i.gyazo.com/06338bb792245ca0d26af0f7dea44dc6.jpg',
	'We love craft beer! Our tap room is designed to be a comfortable place to hang out with family and friends. Come, play in our backyard! Please feel free to bring your own food, have some delivered, or come to enjoy one of our frequent food truck events.'),
	('Goodfellas', '(215) 922-2317', '1136 Arch St, Philadelphia, PA 19107', 'https://i.gyazo.com/d75fc55c47a9ea82c3b52bf2c3d2eea0.png',
	'We always called each other good fellas. Since the 80''s, two college buds Tony and Artie decided to brew some beer for their friends. Whether it was natural talent or the endless supply of suds, people liked what they tasted and wanted more. They didn''t know it at the time, but this was the beginning of what was to become Goodfellas.');

/***********************************************************************************************************
 Populating beer
***********************************************************************************************************/
INSERT INTO public.beer(brewery_id, name, style, price, abv, image, description) VALUES
	(1, 'Bancroft Beer', 'Ale', 6, 4.20, 'https://i.gyazo.com/666f5ded17e8474d2f1be8f99177e91e.png', 'Our daily drinker, named after the street our humble brewery rests on. Brewed with American 2-row and English Maris Otter malt. Singularly hopped with Mosaic. Punchy notes of Satsuma orange rind, lychee flesh, and fresh blueberry muffin with a clean and crisp finish. 4.20% abv'),
	(2, 'Smoked Dunkel', 'Lager', 8, 6, 'https://i.gyazo.com/5ab93c917140b256ba4ca19ab706420a.png', 'Take a jaunt north from Munich to Bamberg with this smoky brown lager. Traditional Munich Dunkel grist with a slightly northern spin combining two of our favorite styles – Munich Dunkel and Bamberg Rauchbier. Brewed with German Pilsner, Munich, and a modest percentage of beechwood smoked malts and a dash of Spalt Select hops. Rich flavors of hearth baked bread smothered in Nutella with a sprinkle of toffee and fire roasted smores. A real Fall treat. 5.5%abv'),
    (3, 'Northeast Extension ’22', 'Malt', 5, 4.5, 'https://i.gyazo.com/cf1ee5040dc5496f1e66abdf26be10dd.png', 'Hoppy American Pils. For this year’s batch of Northeast Extension, an annual exploration of PA grown malt and Estate Grown hops from our own Second District Brew Farm, we utilized a simple base of Colonial Pilsner malt from our friends at Deer Creek and then dressed it up with Brew Farm Cascade and Willamette. We then fermented the resulting wort with our house lager yeast to create a zippy unfiltered pilsner jam-packed with Pennsylvania terroir. Clean crackery malt notes followed by grassy green tea with a hint of orange peel. 4.5% abv'),
    (4, 'Chadwick on Brett', 'Brown Ale', 6, 8, 'https://gyazo.com/933d612124705843ead259c794d20106', 'We took a small portion of the original late-Spring batch of Chadwick before carbonation, spiked it with a bit of brett, and let it condition for the Summer. The result is a delicious introspective into what porter might have been like after traveling in oak barrels for long periods of time back in the 1800’s. More dry than the fresh version, woody, bittersweet cacao, gentle twang with a little mystery. *NITRO*'),
    (5, 'Pils Mercato', 'Pilsner', 5, 5.2, 'https://i.gyazo.com/65ab0eb5a2e35969ccfc45f0ae0ac419.png', 'Created with our friends at DiBruno’s as a nod to their history and heritage and the original Italian Market storefront on 9th street. Brewed entirely with lovely German pilsner malt, we then took local Viva Leaf Tea tulsi basil infused honey and added it in the whirlpool to retain as much nuance as possible. Hopped in the kettle with fresh Spalter Select and Hallertauer Mittelfrüher, and then again post fermentation for that modern classic Italian pils profile. Aromas jump out of the glass with honey drizzled bread crust, rolling grassy fields, and gentle black currant. The flavor rides those same waves with a delightfully dry spicy finish. 5.2% abv'),
    (6, 'Entwife', 'Rye Dark Mild', 7, 3.4, 'https://i.gyazo.com/b4109bf6e895e5fc1c3f08134f273474.png', 'Entwife season is here! This beer has a special place in our hearts as one of the first we made for our opening in 2017. Entwife is a Rye Dark Mild built with English Maris Otter, Rye, and Chocolate malts. This year we added English crystal rye as well. Hopped delicately with East Kent Goldings in the kettle. Pint fulls of chocolate Rice Krispies and rich toffee with chewy pumpernickel followed by a spicy finish from the rye. At 3.4%, it’s the perfect beer to accompany a night full of good food and great company.');

/***********************************************************************************************************
 Populating beer
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
    (3, 6, 5, 12, true);

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
