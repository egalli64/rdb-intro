/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

	Examples on left/right outer join - from "many" perspective
 */

-- Treasury is a department
select name
from department
where department_id in (11, 12);

-- the inner join skips Treasury
select e.first_name, e.last_name, d.name as "Department Name"
from employee e inner join department d
    using(department_id)
where d.department_id in (11, 12);

-- right outer join
select e.first_name, e.last_name, d.name as "Department Name"
from employee e right outer join department d
    using(department_id)
where department_id in (11, 12);

-- as above, rewritten as left outer join
select e.first_name, e.last_name, d.name as "Department Name"
from department d left outer join employee e
    on d.department_id = e.department_id 
where d.department_id in (11, 12);
