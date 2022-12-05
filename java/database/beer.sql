BEGIN TRANSACTION;

DROP TABLE IF EXISTS brewery_beer, beer;

CREATE TABLE brewery_beer (
    brewery_id int NOT NULL,
    beer_id int NOT NULL
);

CREATE TABLE beer (
    beer_id serial NOT NULL,
    name varchar(64) NOT NULL,
    description varchar(120) NULL,
    style varchar(64) NULL,
    region varchar(64)  NULL,
    price money NULL,
    abv float(2) NULL
);

COMMIT;
