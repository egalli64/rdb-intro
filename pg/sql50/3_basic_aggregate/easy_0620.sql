/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 620. Not Boring Movies - https://leetcode.com/problems/not-boring-movies/description/
 */

-- set up for testing on the leet schema
create table cinema (
	id serial primary key, 
	movie varchar(255), 
	description varchar(255), 
	rating numeric(2, 1)
);

insert into cinema (movie, description, rating) values
	('War', 'great 3D', 8.9), ('Science', 'fiction', 8.5), ('irish', 'boring', 6.2),
	('Ice song', 'Fantacy', 8.6), ('House card', 'Interesting', 9.1);


-- Find the movies having odd id and description that is not "boring"
-- Order the results by rating in descending order
select *
from cinema
where mod(id, 2) != 0 and description != 'boring'
order by rating desc;

-- cleanup of the leet schema
drop table cinema;