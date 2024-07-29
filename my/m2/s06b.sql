/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples left/right outer join - from "one" perspective
 */
use hron;

-- Treasury is a department
select department_id, name
from department
where department_id in (11, 12);

-- the inner join skips Treasury
select e.first_name, e.last_name, d.name
from employee e inner join department d
using (department_id)
where d.department_id in (11, 12);

-- right outer join
select e.first_name, e.last_name, d.name
from employee e right outer join department d
using (department_id)
where d.department_id in (11, 12);

-- as above, rewritten as left outer join
select e.first_name, e.last_name, d.name
from department d left outer join employee e
using (department_id)
where d.department_id in (11, 12);
