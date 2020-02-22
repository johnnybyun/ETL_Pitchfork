CREATE TABLE merged_table (
  id INT PRIMARY KEY NOT NULL,
  id_rolling_stones_ranking INT,
  album_name VARCHAR,
  artist_name VARCHAR,
  subgenre VARCHAR,
  pitchfork_score FLOAT
);

CREATE TABLE pitchfork_reviews (
  id INT PRIMARY KEY NOT NULL,
  review_id FLOAT,
  album_name VARCHAR,
  artist_name VARCHAR,
  url VARCHAR,
  pitchfork_score INT,
  author VARCHAR,
  pub_date DATE,
  genre VARCHAR
);

CREATE TABLE rolling_stone (
    id INT PRIMARY KEY NOT NULL,
	id_rolling_stones_ranking INT,
	year_released INT,
	album_name VARCHAR,
    artist_name VARCHAR,
	subgenre VARCHAR
);