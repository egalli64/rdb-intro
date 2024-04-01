/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 570. Managers with at Least 5 Direct Reports - https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/
 * 
 * Report name and bonus of each employee with a bonus less than 1000
 */

-- set up for testing on the leet schema
create table employee (
	id int primary key,
	name varchar(255),
	department varchar(255), 
	managerId int
);

alter table employee add foreign key (managerId) references employee (id);

insert into employee values ('101', 'John', 'A', null), ('102', 'Dan', 'A', '101'),
	('103', 'James', 'A', '101'), ('104', 'Amy', 'A', '101'),
	('105', 'Anne', 'A', '101'), ('106', 'Ron', 'B', '101');

-- the actual exercise
select m.name
from employee m left join employee e on m.id = e.managerId
group by m.id, m.name
having count(e.id) >= 5;

-- cleanup of the leet schema
drop table employee;
