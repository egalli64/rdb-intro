/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

	Simplified emulation of full outer join by union
 */

-- Left join for department 12 + 'Grant' -> Treasury is missing
select first_name, last_name, name, department_id
from employee left outer join department
    using (department_id)
where department_id = 12 or last_name = 'Grant';

-- Right join for department 12 + 'Grant' -> Kimberely is missing
select first_name, last_name, name, department_id
from employee right outer join department
    using (department_id)
where department_id = 12 or last_name = 'Grant';

-- Full join for department 12 + 'Grant' -> both Kimberely and Treasury are present
select first_name, last_name, name, department_id
from employee full outer join department
    using (department_id)
where department_id = 12 or last_name = 'Grant';


-- Emulation of a FULL OUTER JOIN by UNION
	select first_name, last_name, name, department_id
	from employee left outer join department
	   using (department_id)
	where department_id = 12 or last_name = 'Grant'
union
	select first_name, last_name, name, department_id
	from employee right outer join department
	   using (department_id)
	where department_id = 12 or last_name = 'Grant';

-- Use ALL to keep the duplicated Douglas from left and right tables
	select first_name, last_name, name, department_id
	from employee left outer join department
	   using (department_id)
	where department_id = 12 or last_name = 'Grant'
union all
	select first_name, last_name, name, department_id
	from employee right outer join department
	   using (department_id)
	where department_id = 12 or last_name = 'Grant';
