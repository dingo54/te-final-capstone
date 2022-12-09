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
	('2nd Story Brewing Co.', '(267) 314-5770', '117 Chestnut St, Philadelphia, PA 19106', 'M-F: 7-12 S-S: 8-2', 'https://eventective-media.azureedge.net/3099496_lg.jpg',
	'We all have a first story. It’s the one we tell to strangers, job interviewers and people we meet during the course of a day. It’s who we are, where we’re from, what we do, people we know. But our second story is all about the passion we have deep inside. It’s the things we love to do because it defines who we are. At 2nd Story Brewing Co., our passion is the craft beer that you can witness for yourself being brewed on the second floor. It’s where our second story comes together. It’s where our stellar beer is hand-crafted and handed down.','true', 10),
	('Mainstay Independent Brewing Company', '(215) 422-3561', ' 901 N Delaware Ave, Philadelphia, PA 19123', 'M-F: 4-12 S-S: 8-2', 'https://mainstaybrewing.com/images/beerlist_breaker.jpg','Craft Hall is Philadelphia’s largest beer hal where you’ll enjoy Mainstay Independent’s delicious brews in a creative, family-friendly atmosphere.This lively space for aficionados of artisanal foods and craft beer connoisseurs includes a large scale open gourmet kitchen provisioned by Lost Bread Company, a fully operational independent bakery operation serving Craft Hall and the region. The space features two full bars and multiple seating areas—from quiet lounges to lively group settings—a playground for kids and adults alike, a live music stage showcasing rotating talent and more than you can absorb in a single visit. Craft Hall is a dining and drinking experience truly born, brewed and crafted in Philly! ',true, 10),
	('Philadelphia Brewing Co.', '(215) 427-2739', '2440 Frankford Ave, Philadelphia, PA 19125', 'M-F: 8-11 S-S: 8-2', 'https://guidetophilly.com/wp-content/uploads/Philadelphia-Brewing-Co-exterior-1.jpg','Decades of brewing experience and an unwavering passion for the science of brewing are what define us best. We skillfully create our recipes by using only the best ingredients available. By adapting old world beer styles with modern brewing techniques, we have developed unique flavors that represent Philadelphia proudly. With more than a dozen different styles of ales and lagers brewed annually we have a beer for every discerning palate.',true, 10),
	('Victory Brewing Company Philadelphia', '(445) 223-1130', '1776 Benjamin Franklin Pkwy, Philadelphia, PA 19103', 'M-F: 11-11 S-S: 11-10', 'https://victorybeer.com/wp-content/uploads/2022/03/Victory-Brewing-Company.png','We pour a full lineup of Victory beers and seltzers in addition to beer and cider from our sister brands Southern Tier Brewing Company, Sixpoint Brewing Company, and Bold Rock Hard Cider, plus spirits from Southern Tier Distilling Company. We also offer a wide selection of packaged beer and spirits to go!',true, 10),
	('Triple Bottom Brewing', '(267) 764-1994', '915 Spring Garden St, Philadelphia, PA 19123', 'M-F: 12-7 S-S: 12-10', 'https://images.squarespace-cdn.com/content/v1/57d21485197aea6d03f1c001/1609256061933-7BLMDSYFP9GUQA3OKERA/brewery+%2B+taproom?format=1000w','Triple Bottom Brewing is a craft brewery with a social mission in Philadelphia, Pennsylvania. We celebrate community through delicious beer and creative collaboration. As a fair chance brewery, we create meaningful, living-wage jobs for people who have experienced homelessness or incarceration, and may otherwise be excluded from the mainstream economy. We’re a certified B Corp, and we believe everyone in every community should have the opportunity to craft something great. Come say hello next time you’re in the neighborhood! ',true, 10),
	('Love City Brewing', '(215) 398-1900', '1023 Hamilton St, Philadelphia, PA 19123', 'M-F: 4-12 S-S: 12-12', 'https://cdn.shortpixel.ai/spai/w_670+h_447+q_lossless+ret_img+to_webp/http://phillyviews.com/wp-content/uploads/2018/04/IMG_4365.jpg','We believe that beer isnt supposed to be complicated. Sure, brewing a good one is part art, part science, but that doesnt mean the culture surrounding it needs to be so... much. Beer should be approachable and so should the places we drink it. After all, beer is the workers drink and theres something nice about the simplicity of the pastime a special kind of unity born of people from different walks of life coming together to unwind in the same way. Were about good people, good beer, and a good way to cap off the day. It doesnt need to be more complicated than that.',true, 10),
	('Urban Village Brewing Company', '(267) 687-1961', '1001 N 2nd St, Philadelphia, PA 19123', 'M-F: 12-11 S-S: 12-12', 'https://i0.wp.com/beerbusterspodcast.com/wp-content/uploads/2017/06/interior-1-2.jpg?ssl=1','Urban Village is all about supporting the local community and creating value for the locals as the heart of a growing Philadelphia and northern liberties community. We were very proud to collaborate with them to show that sense of community. We are only as strong as each other.',true, 10),
	('Dock Street Brewery South', '(215) 337-3103', '2118 Washington Ave, Philadelphia, PA 19146', 'M-F: 11-10 S-S: 11-11', 'https://images.squarespace-cdn.com/content/v1/55c8df6be4b051f0536b7701/1439314441907-D4IQ698DE1O2BCJBOSX3/image-asset.png','Welcome to Dock Street South, the newest location of Philadelphia’s First Craft Brewing Co. Our Point Breeze location serves Lunch, Dinner and Weekend Brunch. Enjoy our menu of hand-tossed, wood-fired pizzas, brasserie-inspired sandwiches, salads and noms that stand on their own and also pair beautifully with great beer and cocktails. Think: classic and creative pizzas, craveable and shareable plates like our Whipped Ricotta, Mac + Cheese, and an incredible Smash Burger, and inventive, fresh salads, to name a few. Stay in the comfort of your own home and enjoy  locally brewed craft beer and delicious food by ordering online today!',true, 10),
	('Attic Brewing Company', '(267) 748-2495', '137 Berkley St, Philadelphia, PA 19144', 'M-F: 4-11 S-S: 3-12', 'https://phillyofficeretail.com/wp-content/uploads/2020/04/Attic-for-web1.jpg','Come spend some time with us in the historic Germantown neighborhood of Philadelphia!  We have 14 of our very own, award winning craft beers on tap, along with wine, cider, cocktail, and spirit options. Visit our taproom located in what used to be the historic Blaisdell Pencil factory, or hang out in our huge beer garden behind the taproom.  Food trucks rotate through on a daily basis, and we host live music, comedy, and vinyl DJ.s throughout the week!',true, 10),
	('Wissahickon Brewing Company', '(215) 483-8833', '3705 W School House Ln, Philadelphia, PA 19129', 'M-F: 4-11 S-S: 8-10', 'https://www.wissahickonbrew.com/wp-content/uploads/2021/11/wissahickon-merch-2.jpg','Wissahickon Brewing Company is a family owned & operated brewery located in East Falls, Philadelphia, PA. The story begins with a dad and his sons and daughter homebrewing in their mother’s kitchen. After years of recipe formulation, education, and a lot of hard work and ambition, the Gill family fulfilled their dream and officially opened the doors of Wissahickon Brewing Company in their hometown of Philadelphia. After opening in 2017, the brewery has since grown tremendously. Wissahickon attributes its growth to brewing premium quality beer, staying involved within the local community, and challenging the status quo. Come join the family and experience what Wissahickon has to offer!',true, 10),
	('Cartesian Brewing', '', '1326 E Passyunk Ave, Philadelphia, PA 19147', 'M-F: 3-12 S-S: 3-10', 'https://philadelphiaweekly.com/wp-content/uploads/2022/01/image_64834414-1024x768.jpg','FOOD OUR TAPROOM IS BRING-YOUR-OWN FOOD WE HAVE A SMALL SELECTION OF LOCAL SNACKS INCLUDING CHIPS AND PRETZELSWE OFTEN HAVE FOOD TRUCKS AND POP-UP FOOD VENDORS CHECK SOCIAL MEDIA FOR THE VENDOR SCHEDULEPETS WE LOVE PETS, BUT UNFORTUNATELY PETS ARE NOT ALLOWED INSIDE THE BREWERY OR ON OUR BACK PATIO WE DO ALLOW PETS TO SIT OUT FRONT AT OUR CAFE SEATING OR AT THE FRONT TABLES IF THE GARAGE DOOR IS OPEN',true, 10),
	('Source Urban Brewery', '(267) 519-3237', '1101 Frankford Ave, Philadelphia, PA 19125', 'M-F:28-11 S-S: 8-12', 'https://resizer.otstatic.com/v2/photos/xlarge/2/47224574.jpg','Family and balance is a focus at the Source. Our first floor taproom welcomes families with kids, second floor mezzanine and rooftop terrace is reserved for adults only and our biergarten and grounds are open to all to enjoy, including dogs.',true, 10),
	('Other Half Brewing', '(215) 497-0640', '1002 Canal St, Philadelphia, PA 19123', 'M-F: 10-11 S-S: 2-10', 'https://media.bizj.us/view/img/12200954/img2168*750xx4032-2268-0-378.jpg','Sam Richardson, Matt Monahan, and Andrew Burman founded Other Half Brewing Company in Brooklyn, NY in 2014 with a simple mission: to create beer that they wanted to drink from a company that they wanted to be a part of. Their vision was to push the boundaries of beer and the culture that surrounds it by representing the “Other Half” of the industry.',true, 10),
	('Chestnut Hill Brewing Company', '(215) 247-0330', '8221 Germantown Ave, Philadelphia, PA 19118', 'M-F: 11-9 S-S: 4-9', 'https://www.chestnuthillbrewingcompany.com/wp-content/uploads/2022/08/bar-1.jpg','We decided to tweak that model and offer beer, brewed on site, along with Neapolitan, wood-fired pizza. Our founding mascot, Newfoundland, Ralph, was a large part of our life and is also the company mascot. Since his passing in March of 2018, Barley and Hopz have joined our family and Chestnut Hill Brewing Company as the second generation mascots and heirs to the throne.',true, 10),
	('Iron Hill Brewery & Restaurant', '(267) 507-7365', '1150 Market St, Philadelphia, PA 19107', 'M-F: 11-12 S-S: 11-11', 'https://www.ironhillbrewery.com/assets/craft/_locationPic1x/CC-Exterior.jpg','NOTHING’S TRUER TO WHO WE ARE than letting our craft beers and handcrafted foods inspire one another in unexpected ways. And while we’re themost award-winning breweryeast of the Mississippi,we’re not in it for the fame or the glory.We’re in it because we love what we do.Which is brewing beer.Getting creative in the kitchen.And integrating our passion from tap to table.We’re more than a scratch kitchen.We’re more than a craft brewery.We’re CRAFT KITCHEN. SCRATCH BREWERY.Local Brewers. Award-winning Beer. WELCOME.',true, 10),
	('Twisted Gingers Brewing Co', '(267) 766-6614', '4317 Fleming St, Philadelphia, PA 19128', 'M-F: 4-10 S-S: 4-9', 'https://s3-media0.fl.yelpcdn.com/bphoto/YU6fUg9d6RzK7xJ7T5U93A/l.jpg','Twisted Gingers Brewing Company is a neighborhood taproom and Artisan Pizza Kitchen powered by passion for doing great things in life and taking a moment to celebrate them!  Our 101 year old taproom is nestled in the hills of Manayunk halfway between Ridge Pike and Main Street Manayunk. Progressing the 1918 tavern legacy, the purpose is simple: Offer a fun craft beer experience with the freshest beer and pizza.  Rotating 8 beers brewed onsite weekly plus hard seltzers & ciders, canned cocktails and sparkling spring waters there is something for everyone to enjoy. Our philosophy is to “Celebrate Life with a Twist”. The ‘twist’ is all about finding the positives in your day to continue moving forward in life! No matter how simple or sarcastic it’s what makes your glass always full here!',true, 10),
	('Humble Parlor Brewing Company', '(610) 442-8135', '3237 Amber St Unit 4-2-E, Philadelphia, PA 19134', 'W-T: 5-8 S-S: 2-7', 'https://breweriesinpa.com/wp-content/uploads/2021/11/IMG_0913.jpg','We are opening in a former textile mill from the 1920s. It was bought and repurposed into smaller units, and we are right near many other businesses including manufacturing, artists, and also Sacred Vice Brewing! Out location is about 600 sq/ft and will have about a 14 ft bar with 4-8 taps, and 7 seats. We will have a couch/living room area, and the max occupancy will probably be around 25. There is a sectioned-off space for the brewery, that will be pretty visible for customers. We currently have a half BBL system with a few fermenters and looking to add more very soon. I will be doing split batches when I brew.',true, 10),
	('Barrel Splitters Brewing', '(215) 941-6228', '1890 Woodhaven Rd, Philadelphia, PA 19116', 'M-F: 2-10 S-S: 12-10', 'https://assets.untappd.com/photos/2021_08_27/fb91b1bfa2fb6c2278b17ffb36ef146d_640x640.jpg','We are a local family-owned taproom and hangout for anyone that needs a break from their day. We offer a relaxed environment with exceptional craft beers to enjoy with friends, family, service members, and coworkers.',true, 10),
	('Lucky Cat Brewing Company', '215) 856-3591', '6235 Frankford Ave, Philadelphia, PA 19135', 'M-F: 8-11 S-S: 8-2', 'http://luckycatbrewing.com/pix/dusty2.jpg','Lucky Cat Beer is a nano brewery operated by Mike "Scoats" Scotese and Jason Macias. Due to rapidly changing times, we had to radically change course multiple times over our 3 years of existence. We learned to be nimble and patient. And it got us to where we are now.We have teamed up with Broken Goblet and Trauger Brewering to found Mutual Respect Brewers Co-op in Bensalem, PA. Mutual Respect is housed in Broken Goblets space on State Road, expanding into an additional 6,000 square feet there.Besides brewing whatever strikes our fancy, our focus is on recreating craft beers that have been lost to time for whatever reason. Lucky Cat Beer is the evolution of The Grey Lodge Pub, one of Philadelphias original beer bars.',true, 10),
	('New Ridge Brewing Co.', '(215) 330-4677', ' 6168 Ridge Ave, Philadelphia, PA 19128', 'M-F: 8-11 S-S: 8-2', 'https://cdn.nerdydeeds.dev/portfolio/199A3876.jpg','New Ridge Brewing Co. is a full-scale brewery and restaurant located in the heart of “The Ridge” in Northwest Philadelphia’s Roxborough neighborhood. Our beers are made on site on our 7 barrel brew house, using the highest quality American and European ingredients. We offer a seasonally rotating food menu featuring local and sustainable vendors, along with a curated cocktail and wine list made up of Pennsylvania wineries and distilleries.',true, 10);

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
