/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples left/right outer join - from the "many" perspective
 */
use hron;

-- Kimberely Grant is the only employee not associated to a department
select first_name, last_name, department_id
from employee
where last_name like 'Gr%';
-- where department_id is null;

-- the inner join skips Kimberely
select e.first_name, e.last_name, d.name as department
from employee e
inner join department d on e.department_id = d.department_id -- or: using (department_id)
where e.last_name like 'Gr%';

-- left outer join preserves Kimberely, giving NULL for the department columns
select e.first_name, e.last_name, d.name as department
from employee e
left outer join department d using (department_id)
where e.last_name like 'Gr%';

-- rewritten as right outer join
select e.first_name, e.last_name, d.name as department
from department d
right outer join employee e using (department_id)
where e.last_name like 'Gr%';

-- "left" or "right" implies "outer"
select e.first_name, e.last_name, d.name as department
from employee e
left join department d using (department_id)
where e.last_name = 'Grant';
