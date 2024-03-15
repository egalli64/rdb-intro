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
 * 
 * Find the id for registrations with with higher temperatures compared to its previous day
 */
select w.id
from weather w cross join weather y
where w.recordDate = y.recordDate + 1 and w.temperature > y.temperature;
