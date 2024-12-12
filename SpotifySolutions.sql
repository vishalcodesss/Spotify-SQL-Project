use spotify;

-- 1. Retrieve the name of all tracks that have more than 1 billion streams

select  distinct Track, stream
from spotify_data
where stream > 1000000000;

-- 2. List all albums along with their respective artists

select distinct album, artist
from spotify_data;

-- 3. Get the total no of comments for tracks where licensed = TRUE

select count(Comments) as count_of_comments
from spotify_data
where Licensed = True;

-- 4. Find all tracks that belong to the album type single

select track, Album_type
from spotify_data
where album_type = 'single';

-- 5. Count the total no of tracks by each artist

select artist, count(track) as totalTracks
from spotify_data
group by artist
order by totalTracks;

-- 6. Calculate the average danceability of tracks in each album.
select * from spotify_data;

select album, round(avg(danceability), 3) as Avg_danceability
from spotify_data
group by album
order by avg_danceability desc;

-- 7. Find the top 5 tracks with the highest energy values

select distinct track, max(energy) as Highest_energy
from spotify_data
group by track
order by 2 desc
limit 5;

-- 8. List all tracks along with their views and likes where official_video = True

select track, 
	sum(views) as total_views,
    sum(likes) as total_likes
from spotify_data
where official_video = 'True'
group by track
order by total_views desc;

-- 9. For each album, calculate the total views of all associated tracks.

select album, 
		track, 
        sum(views) as total_views
from spotify_data
group by 1,2
order by total_views desc;

-- 10. Retrieve the track names that have been streamed on Spotify more than Youtube

select track from(
select track,
		coalesce(sum(case when most_playedon = 'Youtube' then stream end), 0) as Stream_on_Youtube,
        coalesce(sum(case when most_playedon = 'Spotify' then stream end),0) as Stream_on_Spotify
from spotify_data
group by track
) as t
where Stream_on_Spotify > Stream_on_Youtube;


-- 11. Find the top 3 most viewed tracks for each artist using window functions.

select *
from ( 
select artist, track, sum(views) as total_views, dense_rank() over (partition by artist order by sum(views) desc) rnk
from spotify_data
group by artist, track
) t1
where rnk <= 3;


-- 12. Write a query to find tracks where the liveness score is above the average.

select track, artist, liveness
from spotify_data
where liveness > (select avg(liveness) from spotify_data);


-- 13. Use the WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
select * from spotify_data where album like '÷%';

with cte as(
select album,
		max(energy) as highest_energy,
        min(energy) as lowest_energy
from spotify_data
group by album
)
select album, 
(highest_energy-lowest_energy) as energy_difference
from cte;

-- 14. Find tracks where the energy-to-liveness ratio is greater than 1.2

WITH cte1 as (
select track, (energy/liveness) as energy_liveness_ratio
from spotify_data
)
select track, energy_liveness_ratio
from cte1
where energy_liveness_ratio > 1.2;


-- 15. Calculate the cummulative sum of likes for tracks ordered by the number of views, using window functions

select track,
		sum(likes) over (order by views desc ) as cum_sum
	from spotify_data;

-- OR

select track,
		sum(likes) over (order by views desc ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cum_sum
from spotify_data;
-- Both the queries gives the same output as it is a default process to include unbounded preceding rows and current row by mysql
-- but second one enhances readability and clarity by mentioning it in the query  

