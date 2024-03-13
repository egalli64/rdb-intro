/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1683. Invalid Tweets - https://leetcode.com/problems/invalid-tweets/description/
 *
 * Table: Tweets
 *
 * +----------------+---------+
 * | Column Name    | Type    |
 * +----------------+---------+
 * | tweet_id       | int     |
 * | content        | varchar |
 * +----------------+---------+
 *
 * Find the invalid tweets having content sized more than 15
 */
select tweet_id
from tweets
where length(content) > 15;
