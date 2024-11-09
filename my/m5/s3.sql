/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on update
 */
use hron;

-- check the current table structure
describe service;

-- check the current table values (and its associated city in the location table)
select s.*, l.city
from service s left outer join location l using (location_id);

-- updating a single row (if found)
update service
set name = right(name, 2), location_id = 3
where service_id = 20;

-- updating (potentially) more rows
update service
set name = 'N/A'
where service_id > 10;

-- updating all rows - by mistake?
-- ??? committing ???
update service
set name = 'mistake!?';

-- you can choose between committing or rolling back
rollback;
commit;

-- check the current salary for IT people
select e.first_name, e.last_name, e.salary, e.manager_id
from employee e join department d using (department_id)
where d.name = 'IT';

-- before building a subquery could be a good idea to test it as a stand-alone querys
select manager_id
from department
where name = 'IT';

-- update - where subquery
-- assuming department name is not duplicated!
update employee
set salary = salary + 100
where manager_id = (
	select manager_id
	from department
	where name = 'IT'
);
