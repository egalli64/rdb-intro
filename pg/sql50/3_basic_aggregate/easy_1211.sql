/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1211. Queries Quality and Percentage - https://leetcode.com/problems/queries-quality-and-percentage/description/
 */

-- set up for testing on the leet schema
create table queries (
	query_name varchar(30),
	result varchar(50), 
	position int check(position between 1 and 500), 
	rating int check(rating between 1 and 5)
);

insert into queries (query_name, result, position, rating) values
	('Dog', 'Golden Retriever', 1, 5), ('Dog', 'German Shepherd', 2, 5), ('Dog', 'Mule', 200, 1),
	('Cat', 'Shirazi', 5, 2), ('Cat', 'Siamese', 3, 3), ('Cat', 'Sphynx', 7, 4);

-- get query_name
--     quality (average of ratio between query rating and its position) rounded to 2 decimal places
--     poor_query_percentage (percentage of queries with rating less than 3) rounded to 2 decimal places
select query_name,
	round(sum(rating::numeric / position) / count(rating), 2) quality,
	round(avg(case when rating < 3 then 1 else 0 end) * 100.0, 2) poor_query_percentage 
from queries
where query_name is not null 
group by query_name;

-- cleanup of the leet schema
drop table queries;
