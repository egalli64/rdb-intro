/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

	Examples on full outer join
 */

-- Ki and Kimberely
select first_name, last_name, department_id 
from employee
where first_name like 'Ki%';

-- Treasury
select name
from department
where name like 'T%';

-- inner join, Kimberely and Treasury discarded
select first_name, last_name, name
from employee e join department d 
    using(department_id)
where first_name like 'Ki%' or d.name like 'T%';

-- left join, Treasury discarded
select first_name, last_name, name
from employee e left outer join department d 
    using(department_id)
where first_name like 'Ki%' or d.name like 'T%';

-- right join, Kimberely discarded
select first_name, last_name, name
from employee e right outer join department d 
    using(department_id)
where first_name like 'Ki%' or d.name like 'T%';

-- full join, both Kimberely and Treasury are in!
select first_name, last_name, name
from employee e full outer join department d 
    using(department_id)
where first_name like 'Ki%' or d.name like 'T%';
