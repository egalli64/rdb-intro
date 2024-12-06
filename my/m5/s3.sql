/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on update
 */
use hron;
set autocommit = OFF;

-- check the current table values (and its associated city in the location table)
select s.*, l.city
from service s left outer join location l using (location_id);

-- insert stub records to be completed in a second moment
insert into service (location_id)
values (21), (22);

-- when possible, a where with equality check on PK is preferred
-- stressing that is requested an update for a single row (if found)
update service
set name = 'Unknown'
where service_id = 4;

-- when required, we can aim to update more rows
update service
set name = 'Missing', location_id = 22
where location_id = 21;

update service
set name = 'N/A'
where location_id = 22;

-- ??? updating all rows - by mistake ???
--- when not in autocommit mode, we can rollback to the original state
update service
set name = 'mistake!?';

--
-- UPDATE with a subquery
--
-- We want to increase by 100 the salary of each employee having as manager
-- the one associated to the department IT
--

-- 1. get the manager id from department
select manager_id
from department
where name = 'IT';

-- 2. check the employees in the IT department
select e.first_name, e.last_name, e.salary, e.manager_id
from employee e
join department d using (department_id)
where d.name = 'IT';

-- 3. update - where subquery
-- assuming department name is not duplicated!
update employee
set salary = salary + 100
where manager_id = (
	select manager_id
	from department
	where name = 'IT'
);

-- get back to the original status
rollback;
