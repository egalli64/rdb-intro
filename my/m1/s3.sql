/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

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

-- select with changes in the resultset on values and column names (by alias)
select title, min_salary, min_salary * 2 as 'doubled min salary'
from job;

-- the keyword "as" is not mandatory for column alias
select title, min_salary as min, max_salary max
from job;

-- the dual table and the function current_date
select current_date;
-- from dual;

-- calling a mathematic function known by the DBMS
select sqrt(25);

-- concatenation on values from tables
select concat(region_id, ': ' ,country_id) as 'the countries'
from country;

-- limit to get a result set with a specified max size
select first_name, last_name
from employee
limit 10;

-- column alias for a concat()
select concat(first_name, ' ', last_name) as name
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
