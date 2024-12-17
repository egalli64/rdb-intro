/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on aggregate functions
 */
use hron;

select *
from employee;

-- count
select count(*), count(manager_id), count(commission)
from employee;

-- count distinct
select count(distinct manager_id), count(distinct commission)
from employee;

-- max, min
select max(salary), min(salary), max(salary) - min(salary)
from employee;

-- min, max on dates
select min(hired), max(hired)
from employee;

-- sum
select sum(salary)
from employee
where department_id = 5;

-- average
select round(avg(salary), 2)
from employee
where department_id = 1;
