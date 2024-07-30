/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on regex
 */
use hron;

-- plain LIKE
select last_name
from employee
where last_name like 'A%' or last_name like 'E%'
order by 1;

-- LIKE with regular expression
select last_name
from employee
where regexp_like(last_name, '^[AE]');

select last_name
from employee
where last_name rlike '^[ae]'
order by 1;

select last_name
from employee
where last_name regexp '[nt]$';

select first_name, last_name
from employee
where last_name rlike '^c.*[nt]$';
