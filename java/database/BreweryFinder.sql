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
    brewery_id int NOT NULL,
    name varchar(64) NOT NULL,
    style varchar(64) NULL,
    price money NULL,
    abv float(2) NULL,
    image text NULL,
    description varchar(1000) NULL
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
	'We always called each other good fellas. Since the 80''s, two college buds Tony and Artie decided to brew some beef for their friends. Whether it was natural talent or the endless supply of suds, people liked what they tasted and wanted more. They didn''t know it at the time, but this was the beginning of what was to become Goodfellas.');

/***********************************************************************************************************
 Populating beer
***********************************************************************************************************/
INSERT INTO public.beer(brewery_id, name, style, price, abv, image, description) VALUES
	('1', 'Bancroft Beer', 'Ale', 6, 4.20, '', 'Our daily drinker, named after the street our humble brewery rests on. Brewed with American 2-row and English Maris Otter malt. Singularly hopped with Mosaic. Punchy notes of Satsuma orange rind, lychee flesh, and fresh blueberry muffin with a clean and crisp finish. 4.20% abv');

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
