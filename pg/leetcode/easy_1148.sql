/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1148. Article Views I - https://leetcode.com/problems/article-views-i/description/
 * 
 * Table: Views
 * +---------------+---------+
 * | Column Name   | Type    |
 * +---------------+---------+
 * | article_id    | int     |
 * | author_id     | int     |
 * | viewer_id     | int     |
 * | view_date     | date    |
 * +---------------+---------+
 * !!! There is no primary key for this table (yuck!)
 * 
 * Find all the authors that viewed at least one of their own articles, as "id", naturally ordered
 */
