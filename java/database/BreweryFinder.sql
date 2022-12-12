BEGIN TRANSACTION;

DROP TABLE IF EXISTS favorites, brewery_reviews, beer_reviews, beer, brewery, time, users;

CREATE TABLE brewery (
    brewery_id serial NOT NULL,
    brewery_name varchar(64) NOT NULL UNIQUE,
    phone_number varchar(45) NOT NULL,
    address varchar(120) NOT NULL,
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
	brewery_id int NOT NULL,
    rating int NOT NULL,
    review varchar(600) NULL,
	
	

    CONSTRAINT pk_beer_review PRIMARY KEY (review_id),
    CONSTRAINT fk_beer_review_beer_id FOREIGN KEY (beer_id) REFERENCES beer (beer_id),
    CONSTRAINT fk_beer_review_user_id FOREIGN KEY (user_id) REFERENCES users (user_id),
	CONSTRAINT fk_beer_review_brewery_id FOREIGN KEY (brewery_id) REFERENCES brewery (brewery_id)
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
	('2nd Story Brewing Co.', '(267) 314-5770', '117 Chestnut St, Philadelphia, PA 19106', 'M-F: 7-12 S-S: 8-2', 'https://eventective-media.azureedge.net/3099496_lg.jpg',
	'We all have a first story. It’s the one we tell to strangers, job interviewers and people we meet during the course of a day. It’s who we are, where we’re from, what we do, people we know. But our second story is all about the passion we have deep inside. It’s the things we love to do because it defines who we are. At 2nd Story Brewing Co., our passion is the craft beer that you can witness for yourself being brewed on the second floor. It’s where our second story comes together. It’s where our stellar beer is hand-crafted and handed down.','true', 10),
	('Mainstay Independent Brewing Company', '(215) 422-3561', ' 901 N Delaware Ave, Philadelphia, PA 19123', 'M-F: 4-12 S-S: 8-2', 'https://mainstaybrewing.com/images/beerlist_breaker.jpg','Craft Hall is Philadelphia’s largest beer hal where you’ll enjoy Mainstay Independent’s delicious brews in a creative, family-friendly atmosphere.This lively space for aficionados of artisanal foods and craft beer connoisseurs includes a large scale open gourmet kitchen provisioned by Lost Bread Company, a fully operational independent bakery operation serving Craft Hall and the region. The space features two full bars and multiple seating areas—from quiet lounges to lively group settings—a playground for kids and adults alike, a live music stage showcasing rotating talent and more than you can absorb in a single visit. Craft Hall is a dining and drinking experience truly born, brewed and crafted in Philly! ',true, 10),
	('Philadelphia Brewing Co.', '(215) 427-2739', '2440 Frankford Ave, Philadelphia, PA 19125', 'M-F: 8-11 S-S: 8-2', 'https://guidetophilly.com/wp-content/uploads/Philadelphia-Brewing-Co-exterior-1.jpg','Decades of brewing experience and an unwavering passion for the science of brewing are what define us best. We skillfully create our recipes by using only the best ingredients available. By adapting old world beer styles with modern brewing techniques, we have developed unique flavors that represent Philadelphia proudly. With more than a dozen different styles of ales and lagers brewed annually we have a beer for every discerning palate.',true, 10),
	('Victory Brewing Company Philadelphia', '(445) 223-1130', '1776 Benjamin Franklin Pkwy, Philadelphia, PA 19103', 'M-F: 11-11 S-S: 11-10', 'https://victorybeer.com/wp-content/uploads/2022/03/Victory-Brewing-Company.png','We pour a full lineup of Victory beers and seltzers in addition to beer and cider from our sister brands Southern Tier Brewing Company, Sixpoint Brewing Company, and Bold Rock Hard Cider, plus spirits from Southern Tier Distilling Company. We also offer a wide selection of packaged beer and spirits to go!',true, 10),
	('Triple Bottom Brewing', '(267) 764-1994', '915 Spring Garden St, Philadelphia, PA 19123', 'M-F: 12-7 S-S: 12-10', 'https://images.squarespace-cdn.com/content/v1/57d21485197aea6d03f1c001/1609256061933-7BLMDSYFP9GUQA3OKERA/brewery+%2B+taproom?format=1000w','Triple Bottom Brewing is a craft brewery with a social mission in Philadelphia, Pennsylvania. We celebrate community through delicious beer and creative collaboration. As a fair chance brewery, we create meaningful, living-wage jobs for people who have experienced homelessness or incarceration, and may otherwise be excluded from the mainstream economy. We’re a certified B Corp, and we believe everyone in every community should have the opportunity to craft something great. Come say hello next time you’re in the neighborhood! ',true, 10),
	('Brewery ARS', '(215) 960-5173', '1927 W Passyunk Ave Philadelphia, PA 19145', 'M-F: 4-12 S-S: 12-12', 'https://dixon.philly.com/wp-content/uploads/2017/08/752417_4f44a672fb8b66f.jpg','A SOUTH PHILLY GARAGE BREWERY',true, 10),
	('Urban Village Brewing Company', '(267) 687-1961', '1001 N 2nd St, Philadelphia, PA 19123', 'M-F: 12-11 S-S: 12-12', 'https://i0.wp.com/beerbusterspodcast.com/wp-content/uploads/2017/06/interior-1-2.jpg?ssl=1','Urban Village is all about supporting the local community and creating value for the locals as the heart of a growing Philadelphia and northern liberties community. We were very proud to collaborate with them to show that sense of community. We are only as strong as each other.',true, 10),
	('Dock Street Brewery South', '(215) 337-3103', '2118 Washington Ave, Philadelphia, PA 19146', 'M-F: 11-10 S-S: 11-11', 'https://images.squarespace-cdn.com/content/v1/55c8df6be4b051f0536b7701/1439314441907-D4IQ698DE1O2BCJBOSX3/image-asset.png','Welcome to Dock Street South, the newest location of Philadelphia’s First Craft Brewing Co. Our Point Breeze location serves Lunch, Dinner and Weekend Brunch. Enjoy our menu of hand-tossed, wood-fired pizzas, brasserie-inspired sandwiches, salads and noms that stand on their own and also pair beautifully with great beer and cocktails. Think: classic and creative pizzas, craveable and shareable plates like our Whipped Ricotta, Mac + Cheese, and an incredible Smash Burger, and inventive, fresh salads, to name a few. Stay in the comfort of your own home and enjoy  locally brewed craft beer and delicious food by ordering online today!',true, 10),
	('Attic Brewing Company', '(267) 748-2495', '137 Berkley St, Philadelphia, PA 19144', 'M-F: 4-11 S-S: 3-12', 'https://phillyofficeretail.com/wp-content/uploads/2020/04/Attic-for-web1.jpg','Come spend some time with us in the historic Germantown neighborhood of Philadelphia!  We have 14 of our very own, award winning craft beers on tap, along with wine, cider, cocktail, and spirit options. Visit our taproom located in what used to be the historic Blaisdell Pencil factory, or hang out in our huge beer garden behind the taproom.  Food trucks rotate through on a daily basis, and we host live music, comedy, and vinyl DJ.s throughout the week!',true, 10),
	('Wissahickon Brewing Company', '(215) 483-8833', '3705 W School House Ln, Philadelphia, PA 19129', 'M-F: 4-11 S-S: 8-10', 'https://www.wissahickonbrew.com/wp-content/uploads/2021/11/wissahickon-merch-2.jpg','Wissahickon Brewing Company is a family owned & operated brewery located in East Falls, Philadelphia, PA. The story begins with a dad and his sons and daughter homebrewing in their mother’s kitchen. After years of recipe formulation, education, and a lot of hard work and ambition, the Gill family fulfilled their dream and officially opened the doors of Wissahickon Brewing Company in their hometown of Philadelphia. After opening in 2017, the brewery has since grown tremendously. Wissahickon attributes its growth to brewing premium quality beer, staying involved within the local community, and challenging the status quo. Come join the family and experience what Wissahickon has to offer!',true, 10),
	('Cartesian Brewing', '(215) 543-6000', '1326 E Passyunk Ave, Philadelphia, PA 19147', 'M-F: 3-12 S-S: 3-10', 'https://philadelphiaweekly.com/wp-content/uploads/2022/01/image_64834414-1024x768.jpg','We believe in farm-to-table, grower-to-glass, producer-to-pint. That''s why we started Cartesian Brewing. When you drink a glass of our beer or fill a growler of our cider, you won''t just know the ABVs and IBUs, you''ll know the name of the people who malted the grains, who grew the hops, who picked the apples, who opened the tap. Local Origin Ales and Ciders.',true, 10),
	('Source Urban Brewery', '(267) 519-3237', '1101 Frankford Ave, Philadelphia, PA 19125', 'M-F:28-11 S-S: 8-12', 'https://resizer.otstatic.com/v2/photos/xlarge/2/47224574.jpg','Family and balance is a focus at the Source. Our first floor taproom welcomes families with kids, second floor mezzanine and rooftop terrace is reserved for adults only and our biergarten and grounds are open to all to enjoy, including dogs.',true, 10),
	('Other Half Brewing', '(215) 497-0640', '1002 Canal St, Philadelphia, PA 19123', 'M-F: 10-11 S-S: 2-10', 'https://media.bizj.us/view/img/12200954/img2168*750xx4032-2268-0-378.jpg','Sam Richardson, Matt Monahan, and Andrew Burman founded Other Half Brewing Company in Brooklyn, NY in 2014 with a simple mission: to create beer that they wanted to drink from a company that they wanted to be a part of. Their vision was to push the boundaries of beer and the culture that surrounds it by representing the “Other Half” of the industry.',true, 10),
	('Chestnut Hill Brewing Company', '(215) 247-0330', '8221 Germantown Ave, Philadelphia, PA 19118', 'M-F: 11-9 S-S: 4-9', 'https://www.chestnuthillbrewingcompany.com/wp-content/uploads/2022/08/bar-1.jpg','We decided to tweak that model and offer beer, brewed on site, along with Neapolitan, wood-fired pizza. Our founding mascot, Newfoundland, Ralph, was a large part of our life and is also the company mascot. Since his passing in March of 2018, Barley and Hopz have joined our family and Chestnut Hill Brewing Company as the second generation mascots and heirs to the throne.',true, 10),
	('Iron Hill Brewery & Restaurant', '(267) 507-7365', '1150 Market St, Philadelphia, PA 19107', 'M-F: 11-12 S-S: 11-11', 'https://www.ironhillbrewery.com/assets/craft/_locationPic1x/CC-Exterior.jpg','NOTHING’S TRUER TO WHO WE ARE than letting our craft beers and handcrafted foods inspire one another in unexpected ways. And while we’re themost award-winning breweryeast of the Mississippi,we’re not in it for the fame or the glory.We’re in it because we love what we do.Which is brewing beer.Getting creative in the kitchen.And integrating our passion from tap to table.We’re more than a scratch kitchen.We’re more than a craft brewery.We’re CRAFT KITCHEN. SCRATCH BREWERY.Local Brewers. Award-winning Beer. WELCOME.',true, 10),
	('Twisted Gingers Brewing Co', '(267) 766-6614', '4317 Fleming St, Philadelphia, PA 19128', 'M-F: 4-10 S-S: 4-9', 'https://s3-media0.fl.yelpcdn.com/bphoto/YU6fUg9d6RzK7xJ7T5U93A/l.jpg','Twisted Gingers Brewing Company is a neighborhood taproom and Artisan Pizza Kitchen powered by passion for doing great things in life and taking a moment to celebrate them!  Our 101 year old taproom is nestled in the hills of Manayunk halfway between Ridge Pike and Main Street Manayunk. Progressing the 1918 tavern legacy, the purpose is simple: Offer a fun craft beer experience with the freshest beer and pizza.  Rotating 8 beers brewed onsite weekly plus hard seltzers & ciders, canned cocktails and sparkling spring waters there is something for everyone to enjoy. Our philosophy is to “Celebrate Life with a Twist”. The ‘twist’ is all about finding the positives in your day to continue moving forward in life! No matter how simple or sarcastic it’s what makes your glass always full here!',true, 10),
	('Humble Parlor Brewing Company', '(610) 442-8135', '3237 Amber St Unit 4-2-E, Philadelphia, PA 19134', 'W-T: 5-8 S-S: 2-7', 'https://breweriesinpa.com/wp-content/uploads/2021/11/IMG_0913.jpg','We are opening in a former textile mill from the 1920s. It was bought and repurposed into smaller units, and we are right near many other businesses including manufacturing, artists, and also Sacred Vice Brewing! Out location is about 600 sq/ft and will have about a 14 ft bar with 4-8 taps, and 7 seats. We will have a couch/living room area, and the max occupancy will probably be around 25. There is a sectioned-off space for the brewery, that will be pretty visible for customers. We currently have a half BBL system with a few fermenters and looking to add more very soon. I will be doing split batches when I brew.',true, 10),
	('Barrel Splitters Brewing', '(215) 941-6228', '1890 Woodhaven Rd, Philadelphia, PA 19116', 'M-F: 2-10 S-S: 12-10', 'https://assets.untappd.com/photos/2021_08_27/fb91b1bfa2fb6c2278b17ffb36ef146d_640x640.jpg','We are a local family-owned taproom and hangout for anyone that needs a break from their day. We offer a relaxed environment with exceptional craft beers to enjoy with friends, family, service members, and coworkers.',true, 10),
	('Lucky Cat Brewing Company', '215) 856-3591', '6235 Frankford Ave, Philadelphia, PA 19135', 'M-F: 8-11 S-S: 8-2', 'http://luckycatbrewing.com/pix/dusty2.jpg','Lucky Cat Beer is a nano brewery operated by Mike "Scoats" Scotese and Jason Macias. Due to rapidly changing times, we had to radically change course multiple times over our 3 years of existence. We learned to be nimble and patient. And it got us to where we are now.We have teamed up with Broken Goblet and Trauger Brewering to found Mutual Respect Brewers Co-op in Bensalem, PA. Mutual Respect is housed in Broken Goblets space on State Road, expanding into an additional 6,000 square feet there.Besides brewing whatever strikes our fancy, our focus is on recreating craft beers that have been lost to time for whatever reason. Lucky Cat Beer is the evolution of The Grey Lodge Pub, one of Philadelphias original beer bars.',true, 10),
	('New Ridge Brewing Co.', '(215) 330-4677', '6168 Ridge Ave, Philadelphia, PA 19128', 'M-F: 8-11 S-S: 8-2', 'https://cdn.nerdydeeds.dev/portfolio/199A3876.jpg','New Ridge Brewing Co. is a full-scale brewery and restaurant located in the heart of “The Ridge” in Northwest Philadelphia’s Roxborough neighborhood. Our beers are made on site on our 7 barrel brew house, using the highest quality American and European ingredients. We offer a seasonally rotating food menu featuring local and sustainable vendors, along with a curated cocktail and wine list made up of Pennsylvania wineries and distilleries.',true, 10),
	('Human Robot', '(215) 978-4000', '1710 N. 5th St Philadelphia, Pennsylvania 19122', 'M-F: 11-11 S-S: 5-9', 'https://arc-anglerfish-arc2-prod-pmn.s3.amazonaws.com/public/4OPFHHUJJ5CY3GDCVJ7PIH5XAA.jpg','Human Robot Beer is very chill, not intimidating, and is a place for beer drinking perfectly executed, no nonsense beer. We often talk about craft lager rising in popularity in the vast sea of IPA. With the type of formula Human Robot Beer is using to fill a much needed void, I can see this being part of a turning point in current craft beer culture. There was no aspect of hype culture, ticking culture, collecting culture, hoarding culture as far as I could tell, and that made for a very enjoyable to day visit.',true, 10),
	('Fermentery Form', 'bottles@fermenteryform.com', '1700 N. Palethorp St., Philadelphia, PA, United States, Pennsylvania', 'M-F: 12-11 S-S: 7-2', 'https://dixon.philly.com/wp-content/uploads/2018/01/1005733_65b9a0dfbcca668.jpg','We are a small artisan brewery in West Kensington, Philadelphia. We produce delicate and flavorful beers, fermented with our own mixed cultures. A central pillar of our production is our Solera system. This pyramid of barrels contains beer of various ages, in an array of oak types from around the world. This allows us a broad palette for blending beers to our unique taste. Please enjoy them with us.',true, 10),
	('Punch Buggy Brewing Company', 'punchbuggybrewingcompany.com', '1445 N American St, Philadelphia, PA 19122', 'M-F: 12-8 S-S: 12-8', 'https://i.gyazo.com/cb81f2e37fa599a5c693811d468ea9b9.png','Small-batch Philadelphia-based nanobrewery.',true, 10),
	('Separatist South Philly', '(267) 534-4879', '1646 S 12th St, Philadelphia, PA 19147', 'M-F: 4-11 S-S: 12-12', 'https://www.inquirer.com/resizer/SbQjVPw_EhpxbzAC9IU1sLc4CI8=/760x507/smart/filters:format(webp)/arc-anglerfish-arc2-prod-pmn.s3.amazonaws.com/public/NL76OKCBSRD3NLMEE26YPIFD44.jpg','If you ask us what we are all about at Separatist Beer Project, the answer is simple: Hops, Lagerbier and Spontaneous Fermentation. From our classic, easy-drinking quintessential Cream Ale to our Wild Ale Blendery series we aim to create the best beer possible. While we brew a large variety of hoppy IPAs and crisp Lagers, our true passion can be found within the Blendery—a space we have dedicated to rustic brewing. Here amongst the barrels you can find us working on an array of spontaneously fermented ales based on the traditional methods we learned while studying in Europe. With the recent addition of a Koelschip, our Blendery has become our sanctuary to the art of brewing.',true, 10),
	('Evil Genius Beer Company', '(215) 425-6820', '1727 N Front St, Philadelphia, PA 19122', 'M-F: 12-8 S-S: 12-8', 'https://media.timeout.com/images/104011097/image.jpg','VERY SILLY NAMES FOR VERY SERIOUS BEERS. Beer – it’s why we’re all here. Check out what’s available year-round, seasonally & at The Lab.',true, 10),
	('Liquid Art Barrel House', '(215) 995-6792', '990 Spring Garden St, Philadelphia, PA 19123', 'M-F: 1-10 S-S: 1-8', 'https://images.squarespace-cdn.com/content/v1/57c5ee5220099e12c27b69c3/1496177786942-1DH024Z10IW0F7Z10IXW/RoyPitz_990__31.JPG','The Liquid Art Barrel House is a Philadelphia brewpub from the Liquid Art Brewing Company. Built and designed to reflect and showcase the artistry and craftsman behind the beer, food and the space itself. The Barrel House is fitting in the industrial style of the building, built directly into the old truck docks and is the newest fixture in the developing Spring Arts neighborhood. The bar features the full portfolio of award winning beer in addition to some location specific sour, funk and barrel aged Liquid Art specialties along with Pennsylvania craft spirits and wine. The menu at the Barrel House continues the tradition of local and farm fresh ingredients paired alongside the Liquid Art.',true, 10),
	('Sacred Vice Brewing Company', '(215) 690-1686', '3233 Amber St, Philadelphia, PA 19134', 'M-F: Closed S-S: 12-6', 'https://arc-anglerfish-arc2-prod-pmn.s3.amazonaws.com/public/MWXG5IMMCBEAPJ4TSOQAKJX35I.jpg','Artisan brewery located at 3233 Amber St., somewhere between Kensington and Port Richmond. We offer handcrafted beers to go through contactless pickup.',true, 10),
	('Meyers Brewing Company', '(267) 928-3620', '436 E Girard Ave, Philadelphia, PA 19125', 'M-F: 5-11 S-S: 12-12', 'https://breweriesinpa.com/wp-content/uploads/2021/07/img_6682.jpg','Nano brewery in the Fishtown section of Philadelphia.',true, 10)

;


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
    (3, 'Level Up', 'Tropical IPA', 4, 6.5, 'https://cdn.shopify.com/s/files/1/0405/4247/0302/files/PS_01Can_12oz_front_LevelUp_Yards_shopify-2021.png?v=1626360378', 'This isn’t just any old IPA. It’s a legit India Pale Ale with some serious tropical infusion. So drop in a coin and press play. This is some next level stuff, right here.'),
    (3, 'Star Jockey', 'Galaxy Hop Hazy IPA', 5, 7.2, 'https://cdn.shopify.com/s/files/1/0405/4247/0302/files/PS_01Can_12oz_front_StarJockey_Yards.png?v=1645811469', 'Brewed with Cosmic Punch™ and infused with Galaxy hops, this rocket is ready to ride, buckaroo. So saddle up and hold fast! We don''t blast off, we blast ON! And ON! And ON! Across the universe and beyond.'),
    (3, 'VERY MEGA', 'SUPER DELUXE MEGA AWESOME BEER', 5, 9.2, 'https://cdn.shopify.com/s/files/1/0405/4247/0302/files/PS_01Can_12oz_front_VeryMega_Yards-Shopify.png?v=1664550355', 'ENTERING THE RING WEIGHING IN AT 9.2%, THE 2X IPA CHAMPION OF THE MEGAVERSE, VEEERRRYYY MEGA! SWOLE WITH MEGA TROPICAL NOTES! MEGA CITRUS NOTES! VERY MEGA WILL PILEDRIVE YOUR TASTE BUDDIES WITH MEGA HOP AROMAS AND FLAVOR! QUAFF HARD, PEOPLE!'),
    (3, 'Philly Standard', 'Beer', 4, 4.5, 'https://cdn.shopify.com/s/files/1/0405/4247/0302/files/PS_01Can_12oz_front_PhillyStandard_Yards_shopify-2021.png?v=1626360378', 'Sometimes you just want a beer. No bells. No whistles. Just a good, handcrafted, no-nonsense beer that works just as hard as you do. Light. Clean. Easy. The standard beer for every occasion.'),
    (4, 'Love City Lager', 'American Golden Lager', 5, 4, 'https://images.squarespace-cdn.com/content/v1/586d0eeb6a49637ca198ec9e/1612825171549-9XJRD1M096DWAJM9CVVA/LCB_LOVECITY_LAGER_2019+copy.jpg?format=300w', 'Love City Lager is brewed for everybody. Our American Golden Lager is simple, clean, and true to its roots. Lightly malty and a hint of orange aromatics give every bright sip a clean landing.'),
    (4, 'Lime City Lager', 'Lime-infused Lager', 6, 4, 'https://scontent-mia3-1.xx.fbcdn.net/v/t39.30808-6/277168343_3587052554854557_3126678053493744048_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=2c4854&_nc_ohc=DXOAWk8rpigAX8DRMFt&_nc_ht=scontent-mia3-1.xx&oh=00_AfDF8bsRo6DLQLjNB25FjzNVE6i2lwly25xPfoyv9LZBNA&oe=639A2BC0', 'That feeling you get when surrounded by good friends & sunshine! Made with lime and sea salt for a bright, refreshing taste. The perfect beer for warm weather & good times.'),
    (4, 'Sure Shot', 'Kölsch', 7, 4.4, 'https://d2j6dbq0eux0bg.cloudfront.net/images/12606017/2942890261.jpg', 'The ultimate session beer! Refreshing and light-bodied, our Kölsch is balanced with pilsner malt and features subtle fruit and spice character.'),
    (4, 'Deep Cut', 'Pilsner', 7, 5, 'https://products1.imgix.drizly.com/ci-love-city-deep-cut-pilsner-aae10f18eb143fa1.png?auto=format%2Ccompress&ch=Width%2CDPR&fm=jpg&q=20', 'Pilsner is the beer that brewers reach for. Like a musician’s favorite track, it’s a Deep Cut. This one is made with all German malt and hops. Lightly bready malt character with floral and herbal hop notes. It’s crisp, complex & crushable.'),
    (4, 'Sylvie', 'Oatmeal Stout', 7, 5, 'https://products1.imgix.drizly.com/ci-love-city-sylvie-stout-ad5d1f487acff0ef.png?auto=format%2Ccompress&ch=Width%2CDPR&fm=jpg&q=20', 'This English-style oatmeal stout is silky smooth and lightly sweet. This year-round stout is brewed with dark, roasted malts that lend rich dark chocolate and espresso flavors. The addition of oats lends a smooth, round finish.'),
    (4, 'Solid State', 'Helles Lager', 7, 5, 'https://pbs.twimg.com/media/FhTGpVtWIAMm7v5?format=jpg&name=4096x4096', 'Solid State is a Munich-style Helles brewed with German malt and hops. Lightly bready with subtle floral, herbal hop character and a crisp finish. The beer to reach for after a long day'),
    (4, 'Unity', 'American IPA', 7, 5.5, 'https://products3.imgix.drizly.com/ci-love-city-unity-ipa-1bdae5d9c48a64f3.png?auto=format%2Ccompress&ch=Width%2CDPR&fm=jpg&q=20', 'This approachable IPA brings hop lovers together around the citrus flavors of our hop blend. It is assertive, yet highly drinkable. Low bitterness and a crisp finish.'),
    (5, 'Declaration IPA', 'American IPA', 6, 6.5, 'https://i.gyazo.com/0968f45c3d2976510ecec0d379045285.png', 'Warrior, Chinook, Centennial, Amarillo and Simcoe. Cheers to life, liberty and the pursuit of hoppiness!'),
    (5, 'Amarillo Sky', 'Pilsner', 3, 5.5, 'https://i.gyazo.com/684737b315bef0d99f1bcdf1889d3827.png', 'A crisp, crushable homage to all that take the tractor another round. Classic pilsner bit with a light lemon back and toasted cracker finish.'),
    (5, 'Brighter Dayz', 'Hazy IPA', 5, 8.2, 'https://i.gyazo.com/ca93ffa87eb76b4883eafc07b8ca8734.png', 'Our latest collaboration that we brewed with our friends from Suburban, Newtown and Simple Days breweries. Flavors of orange, papaya and a little touch of Pacific Northwest. Make this the very not blue part of your week/weekend'),
    (6, 'Poplar Pils', 'Hard Seltzer', 6, 5, 'https://mainstaybrewing.com/uploads/images/mainstay_poplar_pilsner.png', 'Imported malt from Bavaria combines with Tettnang and Hallertau hops to create a bone-dry brew with a bracing hop forwardness. Light bodied, dry and full of Nobel hop aroma.'),
    (6, 'King Laird Weisse', 'Wheat Beer', 6, 5.3, 'https://mainstaybrewing.com/uploads/images/kinglaird.png', 'At one time in Bavarian history, wheat beer was only brewed by royal license at the King’s brewery. This traditional Hefe Weitzen is brewed in honor of Rolston Laird, an Irish immigrant who lived and farmed wheat on Petty Island. Laird was pronounced King of Petty Island in the late 1800s.'),
    (6, 'Harness Bend', 'India Pale Ale', 4, 5.7, 'https://mainstaybrewing.com/uploads/images/harnessbend.png', 'Harness Bend was created by tying two beer styles together. Long forgotten Decoction Mashing and a traditional German Weisse wort combine with new world American hops to fuel this wheat IPA. Spicy wheat malt and Mosaic, Citra and Cascade hops blend together to mold a balanced hop forward American ale. Unfiltered, firm bodied with notes of peach, mango and citrus.'),
    (6, 'Constitution Lager', 'Lager', 3, 5, 'https://mainstaybrewing.com/uploads/images/mainstay_constitution_lager.png', 'Just as the Constitution established the principle rights of our country, this lager is the foundation for our cold fermented brewing. Imported Vienna and Munich style malts give this beer a rich but delicate malt backbone while Tettnang and Hallertau hops deliver a delicate Nobel hop spiciness and aroma. Cooper, malty, and balanced'),
    (7, 'Space Cowboy IPA', 'Unfiltered IPA', 3, 7, 'https://philadelphiabrewing.com/wp-content/uploads/2022/04/SC_Can_Clean.jpg', 'Unfiltered IPA for a taste that''s out of this world!'),
    (7, 'Harvest From the Hood', 'Fresh-hopped Beer', 4, 7, 'https://philadelphiabrewing.square.site/uploads/1/3/0/2/130266077/s879816252768587221_p291_i3_w1080.jpeg', 'Every autumn we release this fresh-hopped beer brewed with hops grown by Philadelphia Brewing Co.® right in our brewery courtyard, along with more hops grown by friends around Philadelphia like Greensgrow Farms. Harvest from the Hood is brewed on the same day that the locally grown hops are hand picked – giving this brew a juicy, bright hop flavor and aroma.'),
    (7, 'PHL Session IPA', 'IPA', 6, 3.9, 'https://philadelphiabrewing.com/wp-content/uploads/2015/05/PHL_Sweat.png', 'Philadelphia’s hoppy and light session IPA. PHL has all of the hop aroma and flavor that you would expect from an IPA with the alcohol content of a light beer.'),
	(8, 'Birthday Batch', 'Stout - Pastry', 4, 7.6, 'https://assets.untappd.com/photos/2022_12_10/f6ccb7337c515277eb908526ea0d3892_640x640.jpg', 'It''s our Birthday Batch! Brewed with 7 different grains, lactose, brown sugar, cocoa nibs and REAL birthday cake, this syrupy black brew is filled with layers of chocolate flavor that will have you watering at the mouth.'),
    (8, 'Harvest Autumn IPA', 'American IPA', 5, 6.7, 'https://assets.untappd.com/photo/2022_12_10/86619443c92331ce8ea1171c8cc56507_c_1228369118_640x640.jpg', 'Our Harvest IPA is brewed with American hops, cracked barley and hard work as a tribute to what makes our beer so special – the harvest. The deep ruby color evokes a bright autumn mountainside where a warm sweater, a good beer and the gratitude for the seasons are all you need. Cheers to the harvest, whatever it may bring you!'),
    (8, 'Coffee Blonde', 'Blonde Ale', 7, 7, 'https://assets.untappd.com/photos/2022_12_03/67503e3bfa34250452aa834aec192c58_640x640.jpg', 'Blonde Ale featuring Kohana Coffee'),
    (8, 'Dark Thunder Storm King', 'Stout - Imperial / Double', 6, 9.1, 'https://assets.untappd.com/photos/2022_12_11/a4596ddf2234ee06e167f72a2f086201_640x640.jpg', 'A downpour of toasted coconut and coffee meets dense, dark chocolate note of Storm King to deliver an indulgent twist on this bellowed Imperial Stout. Let the thunder roll.'),
    	(9, 'Lawn Chair Parking Spot', 'West Coast IPA', 5, 7, 'https://images.squarespace-cdn.com/content/v1/57d21485197aea6d03f1c001/1613426167602-SEVB5PJ679CCNVQTZ9YQ/58B10892-9B3A-4A0A-BE26-0BEDB1636AC3_1_201_a.jpeg', 'One of our favorite styles is a great, fresh, West Coast IPA. This one is piney and resinous, with notes of fresh wild flower meadows and bright citrus. It’s in honor of all Philadelphians who have done what it takes to get that spot. We see you. We love you.'),
    	(9, 'Stormy Escapes', 'Imperial Stout', 8, 10.9, 'https://images.squarespace-cdn.com/content/v1/57d21485197aea6d03f1c001/1603832716029-2D9U7TI7DZDT0LT9F4FK/IMG_1133.jpeg?format=1000w', 'Like drinking 85% cacao dark chocolate, with lingering flavors of dried tart cherries, dates, and sticky toffee pudding. (Named for the legendary cow, Stormy, who escaped an Old City nativity scene!)'),
    	(9, 'Lawn Chair Parking Spot', 'West Caost IPA', 5, 7, 'https://images.squarespace-cdn.com/content/v1/52393eeae4b05b013e6e213b/1633818067154-KW955B5FEYXH1XR5XEJA/Screen+Shot+2021-10-09+at+6.19.34+PM.png', 'One of our favorite styles is a great, fresh, West Coast IPA. This one is piney and resinous, with notes of fresh wild flower meadows and bright citrus. It’s in honor of all Philadelphians who have done what it takes to get that spot. We see you. We love you.'),
	(10, 'Out Of Line', 'Hazy IPA', 4, 7, 'https://breweryars.square.site/uploads/1/3/1/2/131260309/s866874591780701212_p720_i1_w941.jpeg?dpr=1', 'Hazy india pale ale brewed with all motueka hops'),
	(10, 'Penny Candy Hazy Double IPA', 'Hazy Double IPA', 4, 8, 'https://breweryars.square.site/uploads/1/3/1/2/131260309/s866874591780701212_p715_i1_w942.jpeg?dpr=1', 'Hazy double IPA hopped with HBC 630, citra, & simcoe'),
	(10, 'Waynes Pale Ale', 'Hazy Pale Ale', 4, 5.7, 'https://breweryars.square.site/uploads/1/3/1/2/131260309/s866874591780701212_p713_i1_w1476.jpeg?width=1280&dpr=1', 'Our flagship hazy pale ale hopped with citra, simcoe & mosaic hops Tasting Notes: Citrusy sunshine on a cloudy day. This beer is named after our dear old man who has Parkinson''s Disease. A portion of the sales of every pint goes straight to Parkinson''s Disease research. Drink up.'),
	(10, 'Taking A Break From Life Watermelon Gose', 'Gose', 4, 5, 'https://breweryars.square.site/uploads/1/3/1/2/131260309/s866874591780701212_p687_i1_w905.jpeg?dpr=1', 'Gose brewed with watermelon, coriander, & a touch of fleur de sel | 5% ABV Tasting Notes: All the sweet and juicy watermelons followed by a refreshingly tart finish'),

(12, 'DOCK STREET BOHEMIAN PILSNER', 'Pilsner', 5, 5, 'https://images.squarespace-cdn.com/content/v1/55c8df6be4b051f0536b7701/38437b38-e85a-4580-a577-85d3c76eceb1/pouring+draft+beer.jpg', 'Brewed in the style of the original pilsner beers of Bohemia. A grist consisting solely of German pilsner malt is carefully decocted to produce a bright golden color and soft, nutty malt flavor. The wort is hopped frequently and exclusively with Czech Saaz hops, is fermented cool and slowly, and then lagered extensively. The final product is crisp and refreshing with a gentle noble hop nose and clean dry finish.'),
(11, 'Dime Piece - 2021 ', 'Belgin Quadrupel', 9, 10, 'https://assets.untappd.com/site/beer_logos_hd/beer-5102090_815f9_hd.jpeg', 'This Belgian Quad is made exclusively with PA malts from Deer Creek and then aged in New Liberty whiskey barrels for three months. Aroma gives up a hearty yeasty spice character of cinnamon toasted malt and caramelized candy sugar. Flavor notes of candied orange vanilla and charred peach'),
    	(11, 'Night Howler - 2021', 'Stout - Imperial / Double Oatmeal', 10, 10.1, 'https://assets.untappd.com/site/beer_logos_hd/beer-4557263_d2a11_hd.jpeg', 'After taking 2020 off the Night Howler is excited to return in 2021! Aged in New Liberty Whiskey Barrels, this rich imperial stout boasts a strong barrel flavor with delicious notes of chocolate, coffee, vanilla and a touch of cinnamon. We hope you enjoy this year’s release. Cheers!'),
    	(11, 'Chump Change', 'IPA - American', 6, 6.8, 'https://assets.untappd.com/site/beer_logos_hd/beer-3814244_2dd41_hd.jpeg', 'This IPA is the little brother of Straight Cash, Homie. Same killer hop blend of Citra and Mosaic at a more session-able ABV.'),
    	(12, 'DOCK STREET FUTURO ', 'ITALIAN PILSNER', 8, 4.8, 'https://s3-media0.fl.yelpcdn.com/bphoto/IPJfaCh8dd6ZmY7XcI0_uA/l.jpg', ' A nod to Dock Street''s founder, an Italian immigrant. A grist of German Pilsner malt is carefully decocted to develop a delicate and crisp malt base, onto which an assertive noble hop profile is built with frequent kettle additions of Hallertau Tradition, Hallertau Blanc, and Styrian Aurura. Dry hopped post fermentation with Blanc and Aurora, then lagered extensively. Dynamic flavor and aroma of herbal nobility, soft melon, and blooming wildflowers. Unfiltered and unpasteurized, served in the Keller-Style.'),
    	(12, 'Dock Street WINTER HAZE', 'WINTER HAZE',7, 5.2, 'https://images.squarespace-cdn.com/content/v1/55c8df6be4b051f0536b7701/a2063838-76ea-49c2-b466-ca9a841f0ab0/winter+haze+can+label.JPG', 'The sky is the brightest blue we’ve seen in a while, and the air is so crisp and clear you might just forget traffic jams on 76 and potholes that could swallow your car whole. The only thing to do now is grab a sled and head to the Philadelphia Museum of Art steps for some legendary sledding with friends - and some Dock Street Beer. This wintry version of our seasonal Pale Ale showcases spelt and wheat malt, orange peel, and an abundance of Simcoe hop additions, and perfectly pairs with cold noses and warm fires.'),
    	(12, 'DOCK STREET BOHEMIAN PILSNER', 'DOCK STREET BOHEMIAN PILSNER', 5, 5, 'https://whatnowphilly.com/wp-content/uploads/sites/14/2022/05/Dock-Street-Brewery-To-Open-Tasting-Room-In-Fishtown.jpg', 'This classic, Czech-style pilsner has been our flagship beer since 1985! Brewed in the style of the original pilsner beers of Bohemia in a tradition that dates back to 1842. We use pilsner malts and a generous amount of Bohemian Saaz Hops to produce a golden color, soft, nutty malt flavor and floral hop bouquet.'),
    	(13, 'Plugstreet', 'Belgian Blonde', 6,6.9, 'https://static.wixstatic.com/media/745f6c_b4e228eeb812400ab333aa35205b320e~mv2.jpg/v1/fill/w_809,h_809,al_c,q_85,usm_0.66_1.00_0.01/745f6c_b4e228eeb812400ab333aa35205b320e~mv2.jpg', 'This classic Belgian Style beer is bright with fruity esters and notes of spice. It has a slight malty-sweet flavor and beautiful dry finish. '),
    	(13, 'Prolonged Forms', 'Session Ale', 6, 4.4, 'https://static.wixstatic.com/media/745f6c_f374191697124f7683b6363f77c27a39~mv2.jpg/v1/fill/w_809,h_809,al_c,q_85,usm_0.66_1.00_0.01/745f6c_f374191697124f7683b6363f77c27a39~mv2.jpg', 'Super light,easy to drink, but packed full of flavor, this balanced session ale is brewed with German malts and noble hops. Crushable...'),
    	(13, 'Tiger Smile Hazy', 'Belgin Quadrupel', 6, 7.0, 'https://static.wixstatic.com/media/745f6c_874798625c744a97850e4580909e2ee5~mv2.jpg/v1/fill/w_809,h_809,al_c,q_85,usm_0.66_1.00_0.01/745f6c_874798625c744a97850e4580909e2ee5~mv2.jpg', 'Whirlpooled with Sabro and Mosaic hops after the boil, Tiger Smile is a tropical juice coconut explosion with a slight bit of minty bitterness.  It will put a smile on your face.'),
    	(14, 'Devil''s Pool ', 'Double IPA', 5, 9, 'https://wissahickonbrewing.weebly.com/uploads/1/3/1/3/131304840/s306811436750755545_p97_i12_w1080.jpeg', 'Award-winning Double IPA dry hopped w/ Citra & Simcoe.'),
    	(14, 'Frūx: Cranberry Tangerine ', 'Sour - Fruited', 4, 6.5, 'https://wpcdn.us-midwest-1.vip.tn-cloud.net/www.honolulumagazine.com/content/uploads/2022/03/t/q/hana-koa-brewing-shootz-da-bootz-pc-hana-koa-brewing-co.png', 'Fruited Sour Ale w/ cranberry & tangerine purée. Contains lactose.'),
    	(14, 'Gazebo: Peach', 'Hard Cider', 4, 6.5, 'https://i0.wp.com/thecrafthiker.com/wp-content/uploads/2022/05/PXL_20220501_180122293-scaled.jpg?ssl=1', 'Hard Cider w/ Peach Purée. Gluten free.'),
    	(15, 'KNOCKIN’ ABOUT', 'Golden Ale', 5, 4.9, 'https://assets.untappd.com/photos/2022_12_11/fe39c1222b9d547bb7af4c741090968e_raw.jpg', NULL),
    	(15, 'I FOUND MYSELF A QUIET PLACE', 'aLTBIER', 4, 5.3, 'https://assets.untappd.com/photos/2022_10_12/daca3c2ca2bb7da6a479c03f65c40985_640x640.jpg', 'Whole wheat toast, Caramel'),
    	(15, 'SINGLE COIL ON TAPE', 'IPA - New England / Hazy', 6, 7.2, 'https://assets.untappd.com/photos/2022_06_19/38280ee5345ee1173d49cebf1709eeb8_640x640.jpg', 'Fuzzy IPA made with Citra, Oats, and a touch of Eukanot. Notes of dank grapefruit, honey, and creamy oats.'),
    	(16, 'ULTRA GALAXY', 'Double Dry Hopped Imperial ', 7, 8, 'https://assets.untappd.com/photos/2022_11_23/08759db051bbeed1fc320e2017478a81_640x640.jpg', 'We got our hands on some Galaxy hops from Australia’s latest ‘22 hop harvest and, after some sensory analysis and experimentation, we were blown away and decided it was time to bring back Ultra Galaxy to showcase this year’s exceptional crop. Ultra Galaxy pours a beautifully hazy, light yellow-orange hue into a glass and bursts with intense aromas of ripe peach and juicy passionfruit. We softened the mouthfeel of this imperial IPA by adding a large portion of malted wheat and oats in the mash and kept the bitterness restrained to accentuate a juicy finish characterized by delicious hop flavors. Ultra Galaxy was hopped in the whirlpool and then twice more during active fermentation with 100% Galaxy hops. We get notes of ripened peach, tropical passion fruit, juicy tangerine wedges, sweet, resinous pine, apricot marmalade, bright clementine, mango, and lemon Starburst.'),
    	(16, 'GOOOAL!', 'Session Ale',8,7 , 'https://assets3.thrillist.com/v1/image/3014845/1000x666/flatten;crop;webp=auto;jpeg_quality=60.jpg', 'Fruited Smoothie Sour Conditioned on Cherry, Cranberry, Pomegranate, & Sicilian Blood Orange GOOOAL! is a heavily fruited sour ale that we brewed with a base of pale barley malt, wheat malt, and flaked oats. It was fermented with a special, lactic acid producing yeast strain and then conditioned on red morello cherry, cranberry, pomegranate, and Sicilian blood orange. GOOOAL! pours a reddish-pink hue into a glass and leaves behind frothy rings of fruity foam with each gulp. It opens with aromas of sweet, seasonal fruit punch, drinks with a luscious medium body, and closes with a refreshingly tart, fruity finish. We get notes of cranberry juice, grapefruit bubbly, autumnal fruit punch, tangerine, morello cherry, crushed pomegranate, and orange soda.'),
    	(16, 'ENTER THE DRAGON', 'Double IPA', 5, 7, 'https://assets.untappd.com/photos/2022_12_05/9432b9a2fde9ade80414bbae05902312_640x640.jpg', 'Fruited Smoothie Sour Conditioned on Red Dragon Fruit and Mixed Berry Enter the Dragon is a heavily fruited sour ale that we brewed with a base of pale barley malt, wheat malt, and flaked oats. It was fermented with a special, lactic acid producing yeast strain and then conditioned on red dragon fruit and mixed berries (strawberry, blakberry, blueberry, and currant). Enter the Dragon pours a deep, vibrant red with violet hues into a glass and leaves behind frothy rings of fruity foam with each gulp. It opens with aromas of sweet berries and exotic tropical fruit, drinks with a luscious medium body, and closes with a refreshingly tart, fruity finish. We get notes of red dragonfruit smoothie, candied hibiscus, blackberry jam fizz, SweeTart candies, red Starburst, strawberry Fanta, and blended wild berries.'),
    	(17, 'POETR SNAPS', 'Lager', 9, 4.5, 'https://birrapedia.prevista.net/modulos/market/77/44/other-half---poetry-snaps-16614253876788-g.jpg', 'A rice lager in the Japanese style with pils malt and rice plus a beautiful blend of some of our favorite European hops, Czech Saaz and German Saphir. Dry and crisp with a slightly spicy character, followed by floral and sweet citrus. Super crushable for some warm weather hangs or any type of weather if you ask our brewers.'),
    	(17, 'GRAVY BITS', 'PILSNER - ITALIAN', 8, 5.1, 'https://www.sparrowine.com/media/catalog/product/cache/4affeeb0391b580bb11202aa0f1726bb/0/1/01290.jpg', 'You know when you are cookin and you got them delicious lil'' brown bits in the bottom of the skillet and ya just can''t wait to turn ''em into gravy? That is how we feel about Tettnang and Saaz. Sure, Floor Malted Pils and Munich make a tasty beer, but the hops... those are the gravy bits!"'),
    	(17, 'DOUBLE FOREVER CASHMERE', 'Imperial IPA', 8, 8.5, 'https://www.totalwine.com/dynamic/x490,4pk/media/sys_master/twmmedia/hff/h2f/15103315705886.png', 'Our hand selected Cashmere goes into this single hop Imperial IPA. Cashmere is an interesting hop that gives candied lemon and fruity pebbles notes and is clean and bright on the finish.'),
    	(18, 'Four Seam', 'New England Style IPA ', 8, 5.5, 'https://baseballismy.life/wp-content/uploads/2019/05/idle-hands-four-seam-NE-IPA.jpg', '- bursts of citrus, mango, and guava Conjures up thoughts of a tropical paradise with bursts of citrus, mango and guava that sit on top of a refrained malt backbone. Bitterness remains subdued to allow the true character of the hops to shine through while the cloudy appearance elevates the experience.'),
    	(18, 'Gretel', 'German Pilsner ', 8,7, 'https://massbrewbros.com/wp-content/uploads/2020/07/0-6.jpeg', 'We brewed Gretel with a very traditional focus using 100% noble hops and a simple grain bill. The result is a snappy Pils with a light grassy character and touches of spice in the finish.'),
    	(18, 'Farmhouse', 'American Farmhouse Ale ',9, 8, 'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/8ac5c1125870035.612248c68bd5e.jpg', '- notes of stonefruit and pepper Easy drinking farmhouse ale with an American twist. Notes of stone fruit, tropical fruit and bubblegum with a dry peppery finish.'),
    	(19, 'Iron Hill Light Lager', 'Lager - American Light', 5, 4, 'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/h3b/h9a/16574539464734.png', 'Our lightest beer. Brewed to give a crisp, clean, refreshing taste with very subtle malt and hop flavor.'),
    	(19, 'Hipster IPA', 'IPA - New England / Hazy', 5, 6.7, 'https://d3omj40jjfp5tk.cloudfront.net/products/5fc50f992ecffb271c25b265/large.png', 'This hazy, New England style IPA’s been crafted by our finest, tight-pants wearing brewers. It’s a blend of wheat and oats, unironically dry hopped with All American hops. Notes of melon, mango and pine lead to flavor so cool it’ll curl your mustache.'),
    	(19, 'Spruce Moose IPA', 'PA - New England / Hazy', 6, 6, 'https://www.ironhillbrewery.com/assets/craft/cans/_beerCanTransform/spruce-moose-can.png', 'This new wintertime classic from Iron Hill is not only made for sippin’ around the tree, it’s made from the tree! Brewed with spruce needles and a generous kick of Chinook and Simcoe hops, this seasonal IPA balances a crisp flavor with intense aromas of pine and citrus. So here’s to winter! The Moose is loose!'),
    	(20, 'Wicked Wolf', 'IPA - Black / Cascadian Dark Ale', 8, 6.8, 'https://www.noonwhistlebrewing.com/wp-content/uploads/2020/04/noon-whistle-gummytron.png', 'This hoppy black ale brings resinous pine character from Chinook hops combined with English yeast character that brings out mild caramel and dark roasted malt flavor. The slight residual sweetness provides the perfect balance to this limited seasonal release 6.1%'),
    	(20, 'Confuse the Robot', 'Mild - Dark',8, 6.7, 'https://www.noonwhistlebrewing.com/wp-content/uploads/2020/04/noon-whistle-paranormal-gummy.png', 'Next time a robot posing as a human calls to sell you something have a little fun! This malt-forward experience gives your hop senses a break while showcasing several dark malts with notes of caramel, dried fruit and burnt sugar. Own those robo-calls!'),
    	(20, 'This Is the Way', 'Schwarzbier', 6, 5.1, 'https://www.noonwhistlebrewing.com/wp-content/uploads/2020/04/noon-whistle-gummysicle.png', 'Imagine decadent chocolate without the guilt! This German inspired brew is your fall ‘Go-To’ for a seasonal craft beer change up. It lands at an easy 5.1% with a balanced profile that will leave you taking home a 4-pack to avoid withdrawal.'),
    	(21, 'Swing Juice ', 'Hazy Pale Ale', 7, 5.5, 'https://images.squarespace-cdn.com/content/v1/5fe20bb74fdecd01ce4fe193/1610996680208-6Q01TXL369I0O07VG2UW/easy+way+ipa.jpg', 'Brewed with a touch of Munich malt and a lot of Waimea, wai-iti, and Galaxy hops.'),
    	(21, 'ROTH', 'IPA', 4, 5.5, 'https://dydza6t6xitx6.cloudfront.net/ci-21st-amendment-blah-blah-blah-97c67936ffe09cbf.png', 'Each sip pays dividends with a sweet, then bitter tropical citrus punch.'),
    	(21, 'Salem Soup', ' Fall Spiced Brown ale ', 100, 6.5, 'https://beverages2u.com/wp-content/uploads/2021/07/21st-amend-tasty-double-hazy-IPA-1.png', 'A Fall spiced Brown ale that is ready for winter. This was brewed with 15lbs of brown sugar roasted pumpkins, ginger, nutmeg, cinnamon, and organic Madagascar vanilla beans. It has a subtle pumpkin pie flavor with notes of toasted marshmallow and White mocha'),
    	(22, 'Bootlegger’s Pils', 'Strong Pilsner', 8, 6.5, 'https://images.freshop.com/00000001214895/cffd74881b1f42dd23dc62f9feac4dee_4f79e958-a083-4d63-8cc9-afd3908d5c79_large.png', 'This is a recipe from an infamous bootlegger producing beer in a remote area in Northeast Philadelphia during prohibition. He couldn’t keep up with demand for his product, so he doubled down on the alcohol to make his Pilsner style beer twice as strong.'),
    	(22, 'SunDaze FunDaze', 'Wheat Ale', 7, 6.2, 'https://images.freshop.com/00853272006894/b760fde97264dc577110f72b1747d98e_large.png', 'SunDaze FunDaze helps you forget that in less than 24 hours, you have to work again. Better yet, this beer should be enjoyed every day of the week. Brewed with Oats and Wheat Malts, Citra, Mosaic, and Mosaic joined the whirlpool and dry hop to impart Citrusy, Pine, and Sweet Fruit flavors.'),
    	(22, 'General Grant Stout', 'Dry Stout', 6, 5, 'https://images.freshop.com/00853304008186/65ef98b71a853155b6064b4485d95f4b_large.png', 'A dry stout brewed with Roasted Malts that impart a dark chocolate flavor.'),
    	(23, 'Lil Thrills', 'Pilsner - German', 4, 5.9, 'https://craftypint.com/thumb/200x400/fit/https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Ken-Oats-210913-131519.png', 'German pilsner, notes of lemon verbena, sweet bread and floral tones'),
    	(23, 'Day Lite', 'Lager - American', 6, 4, 'https://craftypint.com/thumb/200x400/fit/https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Strata-Smash-210611-125939.png', 'Crisp and crushable. Day Lite features cara cara orange peel for a refreshing, gently sweet citrus flavor. Brewed with white wheat for a smooth body and slightly hazy appearance. Only 100 calories.'),
    	(23, 'Santilli', ' IPA - American', 6,6, 'https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Pillow-Talk-210524-202552.png', 'Santilli is an award-winning, crowd-sourced American IPA named after the brewery’s street address in Everett, MA. It''s also winner of the Bronze Medal in the American IPA category at the 2016 World Beer Cup.Santilli pours bright gold with a nose of grapefruit zest and pine needles. It begins with big citrus flavors and a light, malty sweetness, finishing clean, pleasantly bitter, and crisp.'),
    	(24, 'ROCKY RIDGE ROCK CANDY', 'Fruit Sour', 8, 5.5, 'https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Rock-Candy-221117-213947.png', 'Amid the constant flow of limited and seasonal releases, Rocky Ridge have expanded their core range with a refreshingly tart, fruited sour in the form of Rock Candy – a beer five years in the making that should slot effortlessly into the creative lineup from the Jindong brewers.Passionfruit, kiwifruit and strawberry all feature in the beer''s fruit forward palate while retaining a pleasing drinkability. A short but sharp finish cleanses the palate with each sip, further enhancing its fruity, refreshing nature, while 5.5 percent ABV hints at repeatability – at least when sat alongside many of their far larger concoctions.It makes for a simple but entirely effective offering from Rocky Ridge, with Rock Candy a great all-rounder for those looking for a fruit-leaning sour existing well away from lactose-laden pastry bombs.'),
    	(24, 'ROCKY RIDGE JINDONG JUICY', 'Juicy Pale Ale', 7, 5.5, 'https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Jindong-Juicy-211213-173022.png', 'Brewer''s notes: Pouring with a medium level of hop haze, this juicy pale ale is loaded with tropical fruit and citrus characteristics that are complemented nicely by a low yet cleansing level of bitterness. Well-balanced, highly sessionable and packed with flavour, texture and aroma - it really is a beer for all occasions.'),
    	(24, 'ROCKY RIDGE BABY PEACH', 'Fruited Session IPA', 5, 4, 'https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Baby-Peach-211213-173128.png', 'Brewer''s notes: Live with vibrant peach aromas, this smooth and highly enjoyable fruited IPA has a low level of bitterness that is complemented by a soft & creamy mouthfeel. Made using natural puréed fruit, a lower ABV makes this a highly sessionable beer that is unlike anything else.'),
		(24, 'Example Beer Name', 'Example Style', 100, 5, 'Image url', 'Example Description');

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
