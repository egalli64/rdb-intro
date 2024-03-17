/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

	Left/right outer join - from "many" perspective
 */

-- Kimberely is an employee
select employee_id, first_name, last_name, department_id 
from employee
where last_name like 'Gr%';

-- the inner join skips Kimberely
select e.employee_id, first_name, last_name, d.name as "department name"
from employee e join department d
    on e.department_id = d.department_id
where last_name like 'Gr%';

-- left outer join
select e.first_name, e.last_name, d.name as "department name"
from employee e left outer join department d
    using (department_id)
where e.last_name like 'Gr%';

-- rewritten as right outer join
select e.first_name, e.last_name, d.name as "department name"
from department d right outer join employee e
    using (department_id)
where e.last_name like 'Gr%';

-- "left" / "right" imply "outer"
select e.first_name, e.last_name, d.name as "department name"
from employee e left join department d
    using (department_id)
where e.last_name = 'Grant';
