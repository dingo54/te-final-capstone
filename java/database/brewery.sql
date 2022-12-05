BEGIN TRANSACTION;

DROP TABLE IF EXISTS brewery;

CREATE TABLE brewery (
    brewery_id serial NOT NULL,
    brewery_name varchar(64) NOT NULL,
    phone_number varchar(14) NOT NULL,
    address varchar(64) NOT NULL,
    image_url varchar(100) NULL
);

COMMIT;
