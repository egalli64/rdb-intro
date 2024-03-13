/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 595. Big Countries - https://leetcode.com/problems/big-countries/description/
 * 
 * Table: World
 * +-------------+---------+
 * | Column Name | Type    |
 * +-------------+---------+
 * | name        | varchar |
 * | continent   | varchar |
 * | area        | int     |
 * | population  | int     |
 * | gdp         | bigint  |
 * +-------------+---------+
 * 
 * Get name, population, and area, of the countries having area 3 million+, or population 25 million+  
 */
select name, population, area
from world
where area >= 3_000_000 or population >= 25_000_000;
