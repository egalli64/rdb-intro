/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 584. Find Customer Referee - https://leetcode.com/problems/find-customer-referee/description/
 */

-- set up for testing on the leet schema
create table customer (
	id serial primary key, 
	name varchar(25),
	referee_id int
);

insert into customer (name, referee_id) values 
	('Will', null), ('Jane', null), ('Alex', 2), ('Bill', null), ('Zack', 1), ('Mark', 2);


-- Find the names of the customer that are not referred by the customer with id = 2
select name
from customer
where referee_id is null or referee_id != 2;

-- cleanup of the leet schema
drop table customer;