/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 197. Rising Temperature - https://leetcode.com/problems/rising-temperature/description/
 * 
 * Table: Weather
 * +---------------+---------+
 * | Column Name   | Type    |
 * +---------------+---------+
 * | id            | int     |
 * | recordDate    | date    |
 * | temperature   | int     |
 * +---------------+---------+
 */

-- set up for testing on the leet schema
create table weather (
	id serial primary key,
	recordDate date unique,
	temperature int
);

insert into Weather (recordDate, temperature) values ('2015-01-01', 10), ('2015-01-02', 25), ('2015-01-03', 20), ('2015-01-04', 30);

-- Find the id for registrations with with higher temperatures compared to its previous day
select w.id
from weather w cross join weather y
where w.recordDate = y.recordDate + 1 and w.temperature > y.temperature;

-- cleanup of the leet schema
drop table weather;
