/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on NULL
 */
use hron;

-- check null
select employee_id, first_name, last_name, commission
from employee
where last_name = 'King' and commission is null;

-- !!! WRONG - no row is returned !!!
select employee_id, first_name, last_name, commission
from employee
where last_name = 'King' and commission = null; -- !!! WRONG !!!

-- check not null
select employee_id, first_name, last_name, commission
from employee
where last_name = 'King' and commission is not null;

-- !!! WRONG  - no row is returned !!!
select employee_id, first_name, last_name, commission
from employee
where last_name = 'King' and commission != null; -- !!! WRONG !!!

-- null in operations, null is returned
select first_name, last_name, salary * commission
from employee
where last_name = 'King';

-- using coalesce() to get rid of null
select employee_id, first_name, last_name, salary * coalesce(commission, 0) as 'monthly commission'
from employee
where last_name = 'King';

-- using MySQL ifnull() to get rid of null
select employee_id, first_name, last_name, salary * ifnull(commission, 0) as 'monthly commission'
from employee
where last_name = 'King';

-- compare ifnull() to coalesce()
select ifnull(null, 42), coalesce(null, null, 42);
