/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on ordering
 */
use hron;

-- a plain query generating an ordered resultset 
select first_name, last_name
from employee
order by last_name;

-- ordering by more columns
select last_name, first_name
from employee
order by last_name, first_name;

-- natural order is not always what we want
select first_name, last_name, salary
from employee
order by salary;

-- descending and limited
select first_name, last_name, salary
from employee
order by salary desc
limit 6;

-- ...
select first_name, last_name, salary 
from employee
where first_name like 'b%'
order by salary desc;

-- positional notation
select first_name, last_name
from employee
order by 1, 2;

-- using alias
select first_name name, last_name surname
from employee
order by name, surname;

-- ordering by a column not included in the select clause
select first_name, last_name
from employee
where first_name like 'c%'
order by hired desc;
