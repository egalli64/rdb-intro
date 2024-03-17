/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

	Intersect example
 */

-- most payed employees
select first_name, last_name, salary, department_id  
from employee
where salary > 12000
order by salary desc;

-- sales employees
select first_name, last_name, salary, department_id  
from employee
where department_id = 8
order by salary desc;

-- most payed sales employees
	select first_name, last_name, salary, department_id  
	from employee
	where salary > 12000
intersect
	select first_name, last_name, salary, department_id  
	from employee
	where department_id = 8
order by salary desc;
	