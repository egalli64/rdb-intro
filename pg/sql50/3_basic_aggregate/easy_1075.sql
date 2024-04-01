/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1075. Project Employees I - https://leetcode.com/problems/project-employees-i/description/
 */

-- set up for testing on the leet schema
create table employee (
	employee_id serial primary key,
	name varchar(10),
	experience_years int
);

insert into employee (name, experience_years) values ('Khaled', 3), ('Ali', 2), ('John', 1), ('Doe', 2);

create table project (
	project_id int,
	employee_id int,
	
	primary key (project_id, employee_id),
	foreign key (employee_id) references employee (employee_id)
);

insert into project (project_id, employee_id) values (1, 1), (1, 2), (1, 3), (2, 1), (2, 4);

-- Find the average experience of all the employees for each project, rounded to 2 digits
select project_id, round(avg(experience_years), 2) average_years
from project join employee using(employee_id)
group by project_id;

-- cleanup of the leet schema
drop table project;
drop table employee;
