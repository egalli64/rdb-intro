/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 595. Big Countries - https://leetcode.com/problems/big-countries/description/
 */

-- set up for testing on the leet schema
create table world (
	name varchar(255) primary key,
	continent varchar(255),
	area integer,
	population integer,
	gdp bigint
);

insert into world (name, continent, area, population, gdp) values
	('Afghanistan', 'Asia', 652_230, 25_500_100,  20_343_000_000),
	('Albania', 'Europe',    28_748,  2_831_741,  12_960_000_000),
	('Algeria', 'Africa', 2_381_741, 37_100_000, 188_681_000_000),
	('Andorra', 'Europe',       468,     78_115,   3_712_000_000),
	('Angola', 'Africa',  1_246_700, 20_609_294, 100_990_000_000);

-- Get name, population, and area, of the countries having area 3 million+, or population 25 million+
select name, population, area
from world
where area >= 3_000_000 or population >= 25_000_000;

-- cleanup of the leet schema
drop table world;
