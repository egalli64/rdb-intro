/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 577. Employee Bonus - https://leetcode.com/problems/employee-bonus/description/
 * 
 * Report name and bonus of each employee with a bonus less than 1000
 */

-- set up for testing on the leet schema
create table employee (
	empId serial primary key,
	name varchar(255),
	supervisor int,
	salary int
);

insert into employee (name, supervisor, salary) values ('John', 3, 1000), ('Dan', 3, 2000), ('Brad', null, 4000), ('Thomas', 3, 4000);

create table bonus (
	empId int primary key, 
	bonus int,
	
	foreign key (empId) references employee(empId) 
);

insert into bonus values (2, 500), (4, 2000);

-- the actual exercise
select e.name, b.bonus
from employee e left join bonus b using (empId)
where b.bonus is null or b.bonus < 1000;

-- cleanup of the leet schema
drop table bonus;
drop table employee;
