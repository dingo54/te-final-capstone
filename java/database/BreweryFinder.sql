BEGIN TRANSACTION;

DROP TABLE IF EXISTS brewery_beer, beer, brewery, time;

CREATE TABLE brewery (
    brewery_id serial NOT NULL,
    brewery_name varchar(64) NOT NULL,
    phone_number varchar(14) NOT NULL,
    address varchar(64) NOT NULL,
    image_url text NULL,

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
    name varchar(64) NOT NULL,
    description varchar(120) NULL,
    style varchar(64) NULL,
    region varchar(64)  NULL,
    price money NULL,
    abv float(2) NULL,

    CONSTRAINT pk_beer PRIMARY KEY (beer_id)
);

CREATE TABLE brewery_beer (
    brewery_id int NOT NULL,
    beer_id int NOT NULL,

    CONSTRAINT pk_brewery_beer_brewery_id_beer_id PRIMARY KEY (brewery_id, beer_id),
    CONSTRAINT fk_brewery_beer_brewery_id FOREIGN KEY (brewery_id) REFERENCES brewery (brewery_id),
    CONSTRAINT fk_brewery_beer_beer_id FOREIGN KEY (beer_id) REFERENCES beer (beer_id)
);

/***********************************************************************************************************
 Populating brewewry table with 8 breweries
***********************************************************************************************************/
INSERT INTO public.brewery(brewery_name, phone_number, address, image_url) VALUES
	('The Salty Spitoon', '(561)-532-1958', '1515 Arch St #11, Philadelphia, PA 19102', 'https://imgur.com/gallery/dtArU'),
	('Krusty Krab', '(561)-511-4356', '5931 Berch St #11, Philadelphia, PA 13333', 'https://imgur.com/gallery/dtArU'),
	('Chum Bucket', '(561)-351-3464', '9999 Almighty St #11, Philadelphia, PA 19102', 'https://imgur.com/gallery/dtArU'),
	('Sandys', '(561)-989-6054', '1515 Arch St #11, Philadelphia, PA 19102', 'https://imgur.com/gallery/dtArU'),
	('Goodfellas', '(561)-111-5422', '1515 Arch St #11, Philadelphia, PA 19102', 'https://imgur.com/gallery/dtArU'),
	('Weenie Hut General', '(561)-432-1958', '1515 Arch St #11, Philadelphia, PA 19102', 'https://imgur.com/gallery/dtArU'),
	('The Salty Spitoon', '(561)-969-1958', '1515 Arch St #11, Philadelphia, PA 19102', 'https://imgur.com/gallery/dtArU'),
	('The Salty Spitoon', '(561)-532-1958', '1515 Arch St #11, Philadelphia, PA 19102', 'https://imgur.com/gallery/dtArU');

/***********************************************************************************************************
 Populating beer
***********************************************************************************************************/
INSERT INTO public.beer(name, description, style, region, price, abv) VALUES
	('Sapporo', 'Oldest beer brand in Japan', 'Lager', 'Japan', 6.99, 5),
	('Modelo', 'Authentic Mexican beer', 'Lager', 'Mexico', 7.99, 4.4),
	('The Good Stuff', 'Best stuff you can get', 'Ale', 'Local', 5.49, 8);

/***********************************************************************************************************
 Populating brewery_beer (Brewerys have these beers)
***********************************************************************************************************/
INSERT INTO public.brewery_beer(brewery_id, beer_id) VALUES
    (1,1), (2,1), (3,1), (4,1), (5,1), (6,1), (7,1), (8,1),
    (1,2), (2,2), (3,2), (4,2), (5,2), (6,2), (7,2), (8,2),
    (1,3);

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
