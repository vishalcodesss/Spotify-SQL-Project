create database spotify;
use spotify;

SET GLOBAL LOCAL_INFILE = 1;
truncate table spotify_data;
drop table spotify_data;

CREATE TABLE spotify_data (
    Artist VARCHAR(100),
    Track VARCHAR(200),
    Album VARCHAR(200),
    Album_type VARCHAR(50),
    Danceability FLOAT,
    Energy FLOAT,
    Loudness FLOAT,
    Speechiness FLOAT,
    Acousticness FLOAT,
    Instrumentalness FLOAT,
    Liveness FLOAT,
    Valence FLOAT,
    Tempo FLOAT,
    Duration_min FLOAT,
    Title VARCHAR(300),
    Channel VARCHAR(100),
    Views BIGINT,
    Likes BIGINT,
    Comments BIGINT,
    Licensed varchar(10),
    official_video varchar(10),
    Stream BIGINT,
    EnergyLiveness FLOAT,
    most_playedon VARCHAR(50)
);

select * from spotify_data;

-- LOAD DATA LOCAL INFILE 'D:/End to End Projects/Spotify Sql Project/cleaned_dataset/spotifydata.csv'
-- INTO TABLE spotify_data
-- FIELDS TERMINATED BY ',' 
-- lines terminated by '\n'
-- IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'D:/End to End Projects/Spotify Sql Project/cleaned_dataset/spotifydata.csv'
INTO TABLE spotify_data
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- EDA 

select * from spotify_data;

select count(*) from spotify_data;
select count(distinct artist) from spotify_data; 
select count(distinct album_type) from spotify_data;
select distinct album_type from spotify_data;
select max(duration_min) from spotify_data;
select min(duration_min) from spotify_data;

select * from(			-- 2nd most highest duration_min record of the table
select * , rank() over (order by duration_min desc) rnk from spotify_data
 ) lulu
where rnk = 2;
 
select * from spotify_data
where duration_min <= 0;
set sql_safe_updates = 0;

desc spotify_data;

alter table spotify_data
change column Licensed Licensed Boolean;

alter table spotify_data
change column official_video official_video boolean;


select * from spotify_data;