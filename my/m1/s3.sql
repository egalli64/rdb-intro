/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on select
 */
use hron;

-- select all
select *
from region;

-- selecting a single column and a single row (if exists)
select name
from region
where region_id = 1;

-- select a single column, no row filtering
select manager_id
from employee;

-- selecting only non-duplicated values
select distinct manager_id
from employee;

-- select with changes on values and column names
select title, min_salary, min_salary * 2 as 'doubled min salary'
from job;

-- other ways to specify column aliases
select title, min_salary as min, max_salary max
from job;

-- the dual table and the function current_date
select current_date;
-- from dual;

select sqrt(25);

-- concatenation
select concat(region_id, ': ' ,country_id) as 'the countries'
from country;

-- limit to get a result set with a specified max size
select first_name, last_name
from employee
limit 10;

select concat(last_name, ' ', first_name) as name
from employee
limit 3;

-- the second block of ten employees
select first_name, last_name
from employee
limit 10, 10;

-- there are less than 110 employees, so this result set is smaller than 10
select first_name, last_name
from employee
limit 100, 10;
