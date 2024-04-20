w---------------- Creating Tables -------------- 
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
	mobile_number INT,
	email VARCHAR(50)
)

ALTER TABLE customer
ADD CONSTRAINT unique_customer_email UNIQUE (email);


CREATE TABLE movie (
    movie_id SERIAL PRIMARY KEY,
    genre TEXT CHECK(genre IN ('Action','Adventure', 'Comedy', 'Drama', 'Fantasy', 'Horror', 'Romance', 'Sci-Fi', 'Thriller', 'Other')),
    movie_name VARCHAR(200),
    movie_poster VARCHAR(255) NOT NULL,
    running_time INT,
    language VARCHAR(50),
    subtitle VARCHAR(50)
);

ALTER TABLE movie
ADD COLUMN streaming_status VARCHAR(30) DEFAULT 'coming_soon'
CHECK (streaming_status IN ('playing_now', 'coming_soon', 'not_playing'));


CREATE TABLE movie_details(
	movie_details_id SERIAL PRIMARY KEY,
	movie_id INT NOT NULL,
    release_date DATE,
	cast_crew TEXT,
    rating INT,
    synopsis TEXT,
    CONSTRAINT fk_movie_id FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE
)

ALTER TABLE movie_details ADD CONSTRAINT unique_movie_id UNIQUE (movie_id);


CREATE TABLE cinema(
	cinema_id SERIAL PRIMARY KEY,
	address_id INT NOT NULL,
	name VARCHAR(50),
	CONSTRAINT fk_address_id FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE CASCADE
)


CREATE TABLE address(
	address_id SERIAL PRIMARY KEY,
    zip_code VARCHAR(10) UNIQUE,
    city_name VARCHAR(50),
	location TEXT
)


CREATE TABLE screen(
	screen_id SERIAL PRIMARY KEY,
	cinema_id INT NOT NULL,
	screen_number INT,
	CONSTRAINT fk_cinema_id FOREIGN KEY (cinema_id) REFERENCES cinema(cinema_id) ON DELETE CASCADE  
)

ALTER TABLE screen
ADD CONSTRAINT unique_screen_number UNIQUE (screen_number, cinema_id);

ALTER TABLE screen
ADD COLUMN screen_type VARCHAR(30) 
CHECK (screen_type IN ('standard','IMAX','Prime'));

UPDATE screen
SET screen_type = 'Prime'  
WHERE screen_id = 10;

CREATE TABLE seat(
	seat_id SERIAL PRIMARY KEY,
	screen_id INT NOT NULL,
	seat_row VARCHAR(10) NOT NULL,
	seat_number INT NOT NULL,
	CONSTRAINT fk_screen_id FOREIGN KEY (screen_id) REFERENCES screen(screen_id) ON DELETE CASCADE
)
ALTER TABLE seat 
ADD COLUMN seat_status VARCHAR(30) 
CHECK (seat_status IN ('Available','Selected','Occupied'));

UPDATE seat
SET seat_status = 'Available'  


CREATE TABLE showtime(
	showtime_id SERIAL PRIMARY KEY,
	screen_id INT NOT NULL,
	movie_id INT NOT NULL,
    cinema_id INT NOT NULL,
	start_time TIME,
	date DATE,
	CONSTRAINT fk_screen_id FOREIGN KEY (screen_id) REFERENCES screen(screen_id) ON DELETE CASCADE,
	CONSTRAINT fk_movie_id FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE,
    CONSTRAINT fk_cinema_id FOREIGN KEY (cinema_id) REFERENCES cinema(cinema_id) ON DELETE CASCADE

)

------- Booking or Ticket ------- 
CREATE TABLE booking(
	booking_id SERIAL PRIMARY KEY,
	customer_id INT NOT NULL,
	showtime_id INT NOT NULL,
	seat_id INT NOT NULL,
	date DATE,
	price INT,
    is_paid BOOLEAN,
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CONSTRAINT fk_showtime_id FOREIGN KEY (showtime_id) REFERENCES showtime(showtime_id),
    CONSTRAINT fk_seat_id FOREIGN KEY (seat_id) REFERENCES seat(seat_id)
)





--------- Inserting Records into the Tables -----------
INSERT INTO customer (first_name, last_name, mobile_number, email)
VALUES ('John', 'Doe', 123456789, 'johndoe@email.com'),
       ('Mac', 'Smith', 987654321, 'janesmith@email.com');


INSERT INTO movie (genre, movie_name, movie_image, running_time, language, subtitle)
VALUES ('Fantasy', 'Harry Potter and the Sorcerer''s Stone', 'https://example.com/harrypotter.jpg', 152, 'English', 'Spanish'),
       ('Sci-Fi', 'The Martian', 'https://example.com/martian.jpg', 144, 'English', 'French'),
       ('Sci-Fi', 'Interstellar', 'https://example.com/interstellar.jpg', 169, 'English', 'German');
INSERT INTO movie (genre, movie_name, movie_image, running_time, language, subtitle)
VALUES ('Adventure', 'The Lord of the Rings: The Fellowship of the Ring', 'https://example.com/lotr1.jpg', 178, 'English', 'Multiple'),
       ('Fantasy', 'Spirited Away', 'https://example.com/spiritedaway.jpg', 125, 'Japanese', 'English'),
       ('Comedy', 'The Big Lebowski', 'https://example.com/biglebowski.jpg', 117, 'English', 'Spanish'),
       ('Drama', 'Schindler''s List', 'https://example.com/schindlerslist.jpg', 195, 'English', 'Multiple'),
       ('Fantasy', 'The Princess Bride', 'https://example.com/princessbride.jpg', 98, 'English', 'French'),
       ('Horror', 'Get Out', 'https://example.com/getout.jpg', 104, 'English', 'None'),
       ('Other', 'La La Land', 'https://example.com/lalaland.jpg', 101, 'English', 'Spanish'),
       ('Thriller', 'Knives Out', 'https://example.com/knivesout.jpg', 169, 'English', 'Multiple'),
       ('Thriller', 'Parasite', 'https://example.com/parasite.jpg', 132, 'Korean', 'English'),
       ('Action', 'Saving Private Ryan', 'https://example.com/savingprivateryan.jpg', 169, 'English', 'Multiple');
INSERT INTO movie (genre, movie_name, movie_image, running_time, language, subtitle)
VALUES ('Action', 'Mad Max: Fury Road', 'https://example.com/madmaxfuryroad.jpg', 120, 'English', 'Spanish'),
       ('Adventure', 'Raiders of the Lost Ark', 'https://example.com/raidersofthelostark.jpg', 115, 'English', 'Multiple'),
       ('Comedy', 'The Truman Show', 'https://example.com/trूमैनshow.jpg', 103, 'English', 'French'),
       ('Horror', 'The Godfather', 'https://example.com/thegodfather.jpg', 175, 'English', 'Italian'),
       ('Drama', 'Free Solo', 'https://example.com/freesolo.jpg', 100, 'English', 'None'),
       ('Fantasy', 'Pirates of the Caribbean: The Curse of the Black Pearl', 'https://example.com/piratesofthecaribbean1.jpg', 143, 'English', 'Multiple'),
       ('Drama', 'Gladiator', 'https://example.com/gladiator.jpg', 155, 'English', 'Latin'),
       ('Drama', 'A Star is Born', 'https://example.com/astarisborn.jpg', 136, 'English', 'Spanish'),
       ('Other', 'Blade Runner 2049', 'https://example.com/bladerunner2049.jpg', 164, 'English', 'Multiple'),
       ('Romance', 'The Notebook', 'https://example.com/thenotebook.jpg', 123, 'English', 'French'),

       ('Sci-Fi', 'Arrival', 'https://example.com/arrival.jpg', 116, 'English', 'Chinese'),
       ('Sci-Fi', 'Ex Machina', 'https://example.com/exmachina.jpg', 108, 'English', 'None'),
       ('Drama', 'Raging Bull', 'https://example.com/ragingbull.jpg', 128, 'English', 'Spanish'),
       ('Thriller', 'Tinker Tailor Soldier Spy', 'https://example.com/tinkertaylorsoldierspy.jpg', 127, 'English', 'Russian'),
       ('Other', 'The Dark Knight', 'https://example.com/thedarkknight.jpg', 152, 'English', 'None'),
       ('Thriller', 'Se7en', 'https://example.com/se7en.jpg', 127, 'English', 'None'),
       ('Drama', 'Dunkirk', 'https://example.com/dunkirk.jpg', 106, 'English', 'French'),
       ('Other', 'The Good, the Bad and the Ugly', 'https://example.com/thegoodthebadandtheugly.jpg', 161, 'Italian', 'English'),
       ('Comedy', 'Monty Python and the Holy Grail', 'https://example.com/montypythonholygrail.jpg', 91, 'English', 'Spanish'),
       ('Action', 'John Wick', 'https://example.com/johnwick.jpg', 101, 'English', 'Russian');




INSERT INTO movie_details (movie_id, release_date, cast_crew, rating, synopsis)
VALUES
  ((SELECT movie_id FROM movie WHERE movie_name = 'Harry Potter and the Sorcerer''s Stone'), '2001-11-16', 'Daniel Radcliffe, Rupert Grint, Emma Watson, Richard Harris', 8, 'An orphaned boy discovers he''s a wizard and is whisked away to Hogwarts School of Witchcraft and Wizardry.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'The Martian'), '2015-09-24', 'Matt Damon, Jessica Chastain, Jeff Daniels, Chiwetel Ejiofor', 7.4, 'An astronaut is presumed dead and left behind on Mars, but he isn''t giving up on survival.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Interstellar'), '2014-11-07', 'Matthew McConaughey, Anne Hathaway, Jessica Chastain, Michael Caine', 8.6, 'A team of astronauts travel through a wormhole in search of a new home for humanity.')
INSERT INTO movie_details (movie_id, release_date, cast_crew, rating, synopsis)
VALUES
  ((SELECT movie_id FROM movie WHERE movie_name = 'The Lord of the Rings: The Fellowship of the Ring'), '2001-12-19', 'Elijah Wood, Ian McKellen, Orlando Bloom, Sean Astin', 8.8, 'A hobbit named Frodo inherits the One Ring and embarks on a quest to destroy it.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Spirited Away'), '2001-07-20', 'Rumi Hiiragi (voice), Yukiko Tamaki (voice), Yasuko Sawada (voice), Tatsuya Ishihara (voice)', 8.9, 'A young girl wanders into a world of spirits and must find a way to save herself and her parents.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'The Big Lebowski'), '1998-03-06', 'Jeff Bridges, John Goodman, Julianne Moore, Steve Buscemi', 8.1, 'The Dude, a laid-back bowler, is mistaken for another Jeffrey Lebowski, a millionaire, and finds himself dragged into a crazy mess.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Schindler''s List'), '1993-12-15', 'Liam Neeson, Ralph Fiennes, Ben Kingsley, Amon Göth', 8.9, 'The true story of Oskar Schindler, a German businessman who saved the lives of over a thousand Jews during the Holocaust.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'The Princess Bride'), '1987-09-25', 'Cary Elwes, Robin Wright, Mandy Patinkin, Christopher Guest', 8.1, 'Westley must rescue his princess Buttercup from the evil Prince Humperdinck.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Get Out'), '2017-02-24', 'Daniel Kaluuya, Allison Williams, Bradley Whitford, Catherine Keener', 7.7, 'A Black man visits his white girlfriend''s family for the weekend, and discovers a disturbing truth about them.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'La La Land'), '2016-12-09', 'Ryan Gosling, Emma Stone, John Legend, Rose Byrne', 8.0, 'A jazz pianist and an aspiring actress fall in love while pursuing their dreams in Los Angeles.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Knives Out'), '2019-11-27', 'Daniel Craig, Chris Evans, Ana de Armas, Jamie Lee Curtis, Michael Shannon',8.2,'A detective investigates a wealthy family after the patriarch is found dead.'  );

INSERT INTO movie_details (movie_id, release_date, cast_crew, rating, synopsis)
VALUES
  ((SELECT movie_id FROM movie WHERE movie_name = 'Mad Max: Fury Road'), '2015-05-15', 'Tom Hardy, Charlize Theron, Nicholas Hoult', 8.1, 'In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search of her homeland with the aid of a group of female prisoners, a psychotic worshiper, and a drifter named Max.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Raiders of the Lost Ark'), '1981-06-12', 'Harrison Ford, Karen Allen, Paul Freeman', 8.4, 'In 1936, archaeologist and adventurer Indiana Jones is hired by the U.S. government to find the Ark of the Covenant before Adolf Hitler''s Nazis can obtain its awesome powers.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'The Truman Show'), '1998-06-05', 'Jim Carrey, Ed Harris, Laura Linney', 8.1, 'An insurance salesman discovers his whole life is actually a reality TV show.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'The Godfather'), '1972-03-24', 'Marlon Brando, Al Pacino, James Caan', 9.2, 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Free Solo'), '2018-09-28', 'Alex Honnold, Tommy Caldwell, Jimmy Chin', 8.2, 'Alex Honnold attempts to become the first person to ever free solo climb El Capitan.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Pirates of the Caribbean: The Curse of the Black Pearl'), '2003-07-09', 'Johnny Depp, Geoffrey Rush, Orlando Bloom', 8, 'Blacksmith Will Turner teams up with eccentric pirate "Captain" Jack Sparrow to save his love, the governor''s daughter, from Jack''s former pirate allies, who are now undead.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Gladiator'), '2000-05-05', 'Russell Crowe, Joaquin Phoenix, Connie Nielsen', 8.5, 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'A Star is Born'), '2018-10-05', 'Lady Gaga, Bradley Cooper, Sam Elliott', 7.7, 'A musician helps a young singer find fame as age and alcoholism send his own career into a downward spiral.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Blade Runner 2049'), '2017-10-06', 'Harrison Ford, Ryan Gosling, Ana de Armas', 8, 'A young blade runner''s discovery of a long-buried secret leads him to track down former blade runner Rick Deckard, who''s been missing for thirty years.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'The Notebook'), '2004-06-25', 'Ryan Gosling, Rachel McAdams, Gena Rowlands', 7.8, 'A poor yet passionate young man falls in love with a rich young woman, giving her a sense of freedom, but they are soon separated because of their social differences.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Arrival'), '2016-11-11', 'Amy Adams, Jeremy Renner, Forest Whitaker', 7.9, 'A linguist is recruited by the military to assist in translating alien communications.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Ex Machina'), '2015-04-10', 'Alicia Vikander, Domhnall Gleeson, Oscar Isaac', 7.7, 'A young programmer is selected to participate in a ground-breaking experiment in synthetic intelligence by evaluating the human qualities of a highly advanced humanoid A.I.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Raging Bull'), '1980-12-19', 'Robert De Niro, Cathy Moriarty, Joe Pesci', 8.2, 'The life of boxer Jake LaMotta, whose violence and temper that led him to the top in the ring destroyed his life outside of it.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Tinker Tailor Soldier Spy'), '2011-12-09', 'Gary Oldman, Colin Firth, Tom Hardy', 7.1, 'In the bleak days of the Cold War, espionage veteran George Smiley is forced from semi-retirement to uncover a Soviet agent within MI6.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'The Good, the Bad and the Ugly'), '1966-12-29', 'Clint Eastwood, Eli Wallach, Lee Van Cleef', 8.8, 'A bounty hunting scam joins two men in an uneasy alliance against a third in a race to find a fortune in gold buried in a remote cemetery.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Monty Python and the Holy Grail'), '1975-05-23', 'Graham Chapman, John Cleese, Eric Idle', 8.2, 'King Arthur and his Knights of the Round Table embark on a surreal, low-budget search for the Holy Grail, encountering many, very silly obstacles.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'John Wick'), '2014-10-24', 'Keanu Reeves, Michael Nyqvist, Alfie Allen', 7.4, 'An ex-hit-man comes out of retirement to track down the gangsters that killed his dog and took everything from him.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Se7en'), '1995-09-22', 'Morgan Freeman, Brad Pitt, Kevin Spacey', 8.6, 'Two detectives, a rookie and a veteran, hunt a serial killer who uses the seven deadly sins as his motives.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'Dunkirk'), '2017-07-21', 'Fionn Whitehead, Barry Keoghan, Mark Rylance', 7.9, 'Allied soldiers from Belgium, the British Empire, and France are surrounded by the German Army and evacuated during a fierce battle in World War II.'),
  ((SELECT movie_id FROM movie WHERE movie_name = 'The Dark Knight'), '2008-07-18', 'Christian Bale, Heath Ledger, Aaron Eckhart', 9, 'When the menace known as The Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.');
  -- 

INSERT INTO cinema (address_id, name)
VALUES ((SELECT address_id FROM address WHERE city_name = 'Riyadh' AND zip_code='12262'), 'Riyadh Gallery 9'),
       ((SELECT address_id FROM address WHERE city_name = 'Al Dawadmi' AND zip_code='17471' ), 'Dawadmi 3');


INSERT INTO address(zip_code, city_name, location)
VALUES ('13521', 'Riyadh','Al Makan Mall, Prince Muhammad Ibn Abdulaziz Rd'),
	   ('17471', 'Al Dawadmi','Al Makan Mall, King Abdulaziz Rd'),
	   ('39811', 'Hafar Al Batin','Al Makan Mall King Abdulaziz Rd ');



INSERT INTO screen(cinema_id, screen_number)
VALUES (1, 1),
       (1, 2),
       (2, 1);


INSERT INTO seat (screen_id, seat_number, seat_row)
VALUES (2, 2, 'A'),
       (2, 3, 'A'),
       (2, 4, 'A'),
       (2, 5, 'A'),
       (2, 1, 'B'),
       (2, 2, 'B');


INSERT INTO showtime (screen_id, movie_id, start_time, date, cinema_id)
VALUES (1, 1, '18:00:00', '2024-04-01', 1),
       (2, 2, '20:00:00', '2024-04-01', 2);
INSERT INTO showtime (screen_id, movie_id, start_time, date, cinema_id)
VALUES (10, 1, '12:00:00', '2024-04-01', 1),
       (9, 2, '2:25:00', '2024-04-01', 2);
INSERT INTO showtime (screen_id, movie_id, start_time, date, cinema_id)
VALUES (10, 3, '12:00:00', '2024-04-01', 1),
       (9, 3, '2:25:00', '2024-04-01', 2),
       (8, 3, '2:25:00', '2024-04-04', 2),
       (9, 3, '4:50:00', '2024-04-01', 2);



INSERT INTO booking (customer_id, showtime_id, seat_id, date, price, isPaid)
VALUES (1, 2, 1, '2024-04-01', 200, TRUE), 
       (1, 2, 2, '2024-04-01', 200, TRUE), 
       (1, 2, 3, '2024-04-01', 200, TRUE);



----------QUERIES--------------



-- See A Movie Tab
SELECT movie_name FROM movie WHERE streaming_status = 'playing_now'

-- find all movies page with filtering
SELECT DISTINCT m.movie_id, m.movie_name, m.movie_image, m.language, md.rating
FROM movie m 
INNER JOIN movie_details md ON m.movie_id = md.movie_id
INNER JOIN showtime st ON m.movie_id = st.movie_id
INNER JOIN screen sc ON st.screen_id = sc.screen_id
WHERE m.streaming_status = 'playing_now' -- AND sc.screen_type = 'IMAX' -- AND m.language = 'English'



-- Our Cinemas tab 
SELECT c.name || ' - ' || a.city_name AS cinema_city -- OR SELECT CONCAT(c.name, ' - ', a.city_name) AS cinema_city
FROM address a
INNER JOIN cinema c ON a.address_id = c.address_id;

--  find all cinema page 
SELECT CONCAT(c.name, ' - ', a.city_name) AS cinema_city, a.location
FROM address a
INNER JOIN cinema c ON a.address_id = c.address_id;



-- find all showtimes 
SELECT CONCAT(c.name, ' - ', a.city_name) AS cinema_city,
st.start_time, sc.screen_type, m.movie_name, m.movie_image, m.language, m.genre,
md.release_date, md.cast_crew, md.synopsis, md.rating
FROM address a
INNER JOIN cinema c ON a.address_id = c.address_id
INNER JOIN showtime st ON c.cinema_id = st.cinema_id
INNER JOIN screen sc ON sc.cinema_id = c.cinema_id
INNER JOIN movie m ON st.movie_id = m.movie_id
INNER JOIN movie_details md ON m.movie_id = md.movie_id
WHERE streaming_status = 'playing_now' -- we can add m.movie_id IN (1, 2, 3) 
	AND st.date = '2024-04-01' 
	AND c.name LIKE 'Dawadmi 3'; -- filtering by status, location, date



-- find all the showtimes for a movie
SELECT CONCAT(c.name, ' - ', a.city_name) AS cinema_city,
st.start_time, st.showtime_id, sc.screen_type, m.movie_name, m.movie_image, m.language, m.genre,
md.release_date, md.cast_crew, md.synopsis, md.rating
FROM address a
INNER JOIN cinema c ON a.address_id = c.address_id
INNER JOIN showtime st ON c.cinema_id = st.cinema_id
INNER JOIN screen sc ON sc.cinema_id = c.cinema_id
INNER JOIN movie m ON st.movie_id = m.movie_id
INNER JOIN movie_details md ON m.movie_id = md.movie_id
WHERE streaming_status = 'playing_now' 
	AND m.movie_id = 3 
    AND st.date = '2024-04-01' ;


-- finding a seat for specific movie and screen page
SELECT m.movie_name, md.rating, m.language, CONCAT(c.name, ' - ', a.city_name) AS cinema_city,
st.date , st.start_time, sc.screen_number,
sc.screen_type, CONCAT(se.seat_row, se.seat_number) AS seatNo , se.seat_status, se.seat_id
FROM showtime st
INNER JOIN movie m ON st.movie_id = m.movie_id
INNER JOIN movie_details md ON m.movie_id = md.movie_id
INNER JOIN cinema c ON st.cinema_id = c.cinema_id
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN screen sc ON st.screen_id = sc.screen_id
INNER JOIN seat se ON sc.screen_id = se.screen_id
WHERE m.movie_id = 2 
	AND showtime_id = 2 
    AND st.screen_id = 8 
    AND seat_status ='Available'

-- OR short version of the query
SELECT m.movie_name, sc.screen_number, sc.screen_type, 
	CONCAT(se.seat_row, se.seat_number) AS seatNo , se.seat_status, se.seat_id
FROM showtime st
INNER JOIN movie m ON st.movie_id = m.movie_id
INNER JOIN screen sc ON st.screen_id = sc.screen_id
INNER JOIN seat se ON sc.screen_id = se.screen_id
WHERE m.movie_id = 2 
	AND showtime_id = 2 
	AND st.screen_id = 8 
	AND seat_status ='Available'


INSERT INTO booking (customer_id, showtime_id, seat_id, date, price, isPaid)
VALUES (1, 2, 4, '2024-04-01', 200, TRUE), 



SELECT customer_id, first_name, last_name
FROM customer
WHERE email = 'johndoe@email.com';








-- Find all previous movies
SELECT *
FROM movie_details
WHERE release_date < CURRENT_DATE;


-- Find all bookings made by a specific customer:
SELECT *
FROM Booking
WHERE customer_id = 1;


-- Find all booked seats for a specific showtime :
SELECT s.seat_id
FROM booking b
JOIN seat s ON b.seat_id = s.seat_id
JOIN showtime st ON b.showtime_id = st.showtime_id
WHERE st.showtime_id = 2 


-- Find all available seats for a specific showtime
SELECT s.seat_id
FROM seat s
LEFT JOIN booking b ON s.seat_id = b.seat_id AND b.showtime_id = 2 
WHERE b.seat_id IS NULL;


-- find all screen in a specific cinema 
SELECT sc.screen_id, sc.screen_number 
FROM screen sc
WHERE sc.cinema_id = 1

-- find all cinema in a specific city
SELECT c.name
FROM cinema c
JOIN address a ON c.address_id = a.address_id
WHERE a.city_name = 'Riyadh'; 

-- find all showtime in a particular date
SELECT * 
FROM showtime st
JOIN movie m ON st.movie_id = m.movie_id
WHERE st.date = '2024-04-01';

