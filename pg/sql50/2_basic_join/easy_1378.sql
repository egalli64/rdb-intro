/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1378. Replace Employee ID With The Unique Identifier - https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/
 */

-- set up for testing on the leet schema
create table employees (
	id int primary key,
	name varchar(20)
);

insert into employees (id, name) values
	(1, 'Alice'), (7, 'Bob'), (11, 'Meir'), (90, 'Winston'), (3, 'Jonathan');

create table employeeUNI (
	id int,
	unique_id int,

	primary key(id, unique_id),
	foreign key (id) references employees(id)
);

insert into EmployeeUNI (id, unique_id) values (3, 1), (11, 2), (90, 3);

-- Find the unique ID of each user, if a user does not have a unique ID just show null
select u.unique_id, e.name
from employees e left outer join employeeUNI u using(id);

-- cleanup of the leet schema
drop table employeeUNI;
drop table employees;
