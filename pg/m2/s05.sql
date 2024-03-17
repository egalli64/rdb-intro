/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

	Examples on join on 3 tables
 */

-- join using
select e.first_name, e.last_name , d.name as "department name", l.city
from employee e join department d using (department_id)
	join location l using (location_id);

-- join on
select e.first_name, e.last_name, l.city
from employee e join department d on e.department_id = d.department_id
	join location l on d.location_id = l.location_id
where d.name = 'IT';

-- classic
select e.first_name, e.last_name, d.name as "department name", l.city
from employee e, department d, location l
where d.department_id = e.department_id
	and d.location_id = l.location_id;

-- employees based at Toronto
select e.first_name, e.last_name, d.name as "department name"
from employee e join department d using (department_id)
	join location l using (location_id)
where l.city = 'Toronto';

-- executive employees
select e.first_name, e.last_name, l.city
from employee e join department d using (department_id)
	join location l using (location_id)
where d.name = 'Executive';

-- executive employees (classic)
select e.first_name, e.last_name, l.city
from employee e, department d, location l
where d.department_id = e.department_id
	and d.location_id = l.location_id
    and name = 'Executive';
