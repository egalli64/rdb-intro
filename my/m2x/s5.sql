/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on non-equi join
 */
use hron;

-- ex 1
-- name of department for a given employee
select e.first_name, e.last_name, d.name
from department d
join employee e using (department_id)
where e.employee_id = 107;

-- name of other department for a given employee
select d.name
from department d
join employee e on d.department_id != e.department_id
where e.employee_id = 107;

-- name of other active department for a given employee
select d.name
from department d 
join employee e on d.department_id != e.department_id
where e.employee_id = 107 and d.manager_id is not null;

-- Diana changes job, and she wants to go to Seattle
select d.name
from department d 
join employee e on d.department_id != e.department_id
where e.employee_id = 107 and d.location_id = 8;

-- ex 2
-- given an employee ...
select e.first_name, e.last_name, e.salary, j.title, j.job_id, j.min_salary, j.max_salary
from employee e join job j
using (job_id)
where employee_id = 107;

-- ... list of jobs with a compatible min/max salary
select j.title, j.min_salary, j.max_salary
from employee e
join job j on e.salary between j.min_salary and j.max_salary
where e.employee_id = 107;

-- ... list of _other_ jobs with a compatible min/max salary
select j.title, j.min_salary, j.max_salary
from employee e
join job j on e.salary between j.min_salary and j.max_salary
where e.employee_id = 107 and e.job_id != j.job_id;
