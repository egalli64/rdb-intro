/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1934. Confirmation Rate - https://leetcode.com/problems/confirmation-rate/description/
 */

-- set up for testing on the leet schema
create table signups (
	user_id int primary key,
	time_stamp timestamp
);

insert into signups (user_id, time_stamp) values (3, '2020-03-21 10:16:13'),
	(7, '2020-01-04 13:57:59'), (2, '2020-07-29 23:09:44'), (6, '2020-12-09 10:39:37');


create type status as enum('confirmed','timeout');

create table confirmations (
	user_id int,
	time_stamp timestamp,
	action status,
	
	primary key(user_id, time_stamp),
	foreign key(user_id) references signups(user_id)
);

insert into confirmations (user_id, time_stamp, action) values (3, '2021-01-06 03:30:46', 'timeout'),
	(3, '2021-07-14 14:00:00', 'timeout'), (7, '2021-06-12 11:57:29', 'confirmed'),
	(7, '2021-06-13 12:58:28', 'confirmed'), (7, '2021-06-14 13:59:27', 'confirmed'),
	(2, '2021-01-22 00:00:00', 'confirmed'), (2, '2021-02-28 23:59:59', 'timeout');

-- find the confirmation rate of each user
-- number of confirmed messages divided by the total number of requested confirmation messages
-- confirmation rate for user that did not request any confirmation messages is 0
-- round the confirmation rate to two decimal places
select s.user_id, round(avg(case when c.action = 'confirmed' then 1 else 0 end), 2) as confirmation_rate
from signups s left outer join confirmations c using(user_id)
group by s.user_id;

-- cleanup of the leet schema
drop table confirmations;
drop type status;
drop table signups;

