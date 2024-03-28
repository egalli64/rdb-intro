/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1148. Article Views I - https://leetcode.com/problems/article-views-i/description/
 */

-- set up for testing on the leet schema

-- !!! As designed, there is no primary key (yuck!)
create table views (
	article_id int,
	author_id int,
	viewer_id int,
	view_date date
);

insert into views (article_id, author_id, viewer_id, view_date) values
	(1, 3, 5, '2019-08-01'), (1, 3, 6, '2019-08-02'), (2, 7, 7, '2019-08-01'),
	(2, 7, 6, '2019-08-02'), (4, 7, 1, '2019-07-22'), (3, 4, 4, '2019-07-21'),(3, 4, 4, '2019-07-21');

-- Find all the authors that viewed at least one of their own articles, as "id", naturally ordered
select distinct author_id as id
from views
where author_id = viewer_id
order by id;

-- cleanup of the leet schema
drop table views;
