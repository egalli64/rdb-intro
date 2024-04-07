/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1633. Percentage of Users Attended a Contest - https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/
 */

-- set up for testing on the leet schema
create table users (
	user_id int primary key, 
	user_name varchar(20)
);

insert into users (user_id, user_name) values (6, 'Alice'), (2, 'Bob'), (7, 'Alex');

create table register (
	contest_id int,
	user_id int,
	
	primary key(contest_id, user_id)
);

insert into register (contest_id, user_id) values (215, 6), (209, 2), (208, 2), (210, 6),
	(208, 6), (209, 7), (209, 6), (215, 7), (208, 7), (210, 2), (207, 2), (210, 7);

-- find the percentage of users registered in each contest rounded to two decimals
-- ordered by percentage in descending order, then by contest_id in ascending order.
select contest_id, round(count(user_id) * 100.0 /(select count(user_id) from users), 2) as percentage
from register
group by contest_id
order by percentage desc, contest_id;

-- cleanup of the leet schema
drop table register;
drop table users;
