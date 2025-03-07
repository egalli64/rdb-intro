/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on join on 3 tables
 */
use hron;

-- extra info on employees - SQL/92 (JOIN - USING)
select e.first_name, e.last_name, d.name as department, l.city
from employee e 
join department d using (department_id)
join location l using (location_id);

-- SQL/92 (JOIN - ON)
select e.first_name, e.last_name, d.name as department, l.city
from employee e
join department d on e.department_id = d.department_id
join location l on l.location_id = d.location_id;

-- SQL/92 (JOIN - ON, navigating in the other direction)
select e.first_name, e.last_name, d.name as department, l.city
from location l
join department d on l.location_id = d.location_id
join employee e on d.department_id = e.department_id;

-- extra info on employees - classic
select e.first_name, e.last_name, d.name as department, l.city
from employee e, department d, location l
where e.department_id = d.department_id 
  and d.location_id = l.location_id;

-- employees based at Toronto
select e.first_name, e.last_name, d.name as department
from employee e
join department d using (department_id)
join location l using (location_id)
where l.city = 'Toronto';

-- extra info on executive employees
select first_name, last_name, city, name
from employee
join department using (department_id)
join location using (location_id)
where name = 'Executive';

-- extra info on executive employees (classic)
select e.first_name, e.last_name, l.city
from employee e, department d, location l
where d.department_id = e.department_id
  and d.location_id = l.location_id
  and d.name = 'Executive';

-- join on a many to many relation
select c.name, s.name
from car c 
join car_service cs using (car_id)
join service s using (service_id);
