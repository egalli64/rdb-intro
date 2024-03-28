/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1683. Invalid Tweets - https://leetcode.com/problems/invalid-tweets/description/
 */

-- set up for testing on the leet schema
create table tweets(
	tweet_id serial primary key,
	content varchar(50)
);

insert into tweets (content) values ('Vote for Biden'), ('Let us make America great again!');

-- Find the invalid tweets having content sized more than 15
select tweet_id
from tweets
where length(content) > 15;

-- cleanup of the leet schema
drop table tweets;
