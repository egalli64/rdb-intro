/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    An example on emulating a full outer join by union
 */
use hron;

-- Left join for department 12 or 'Grant' -> Treasury is missing
select e.first_name, e.last_name, d.name, d.department_id
from employee e
left outer join department d using (department_id)
where d.department_id = 12 or e.last_name = 'Grant';

-- Right join for department 12 or 'Grant' -> Kimberely is missing
select e.first_name, e.last_name, d.name, d.department_id
from employee e
right outer join department d using (department_id)
where d.department_id = 12 or e.last_name = 'Grant';

-- Emulation of a FULL OUTER JOIN
	select e.first_name, e.last_name, d.name, d.department_id
	from employee e
	left outer join department d using (department_id)
	where d.department_id = 12 or e.last_name = 'Grant'
union
	select e.first_name, e.last_name, d.name, d.department_id
	from employee e
	right outer join department d using (department_id)
	where d.department_id = 12 or e.last_name = 'Grant';

-- Union all keeps duplicated rows
	select e.first_name, e.last_name, d.name, d.department_id
	from employee e
	left outer join department d using (department_id)
	where d.department_id = 12 or e.last_name = 'Grant'
union all
	select e.first_name, e.last_name, d.name, d.department_id
	from employee e
	right outer join department d using (department_id)
	where d.department_id = 12 or e.last_name = 'Grant';
