/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

	Except example
 */

-- managers
select m.first_name first, m.last_name last
from employee e join employee m
on e.manager_id = m.employee_id
group by first, last;

-- employees bar managers
	select first_name first, last_name last
	from employee
except
	select m.first_name, m.last_name
	from employee e join employee m
	on e.manager_id = m.employee_id
order by first, last;