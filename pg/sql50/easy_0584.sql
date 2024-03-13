/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 584. Find Customer Referee - https://leetcode.com/problems/find-customer-referee/description/
 * 
 * +-------------+---------+
 * | Column Name | Type    |
 * +-------------+---------+
 * | id          | int     |
 * | name        | varchar |
 * | referee_id  | int     |
 * +-------------+---------+
 * 
 * Find the names of the customer that are not referred by the customer with id = 2.
 */
select name
from customer
where referee_id is null or referee_id != 2;