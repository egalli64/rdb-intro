/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

    Examples on select
 */

-- select all
select *
from region;

-- a common select, filtering both on rows and columns
select name
from region
where region_id = 1;

-- select a full single column
select manager_id
from employee;

-- select only distinct values in a column
select distinct manager_id
from employee;

-- using column name alias (in double quotes)
select title, min_salary as "min salary", min_salary as min
from job;

-- a result set with changed data (and column names)
select title, min_salary, min_salary + 200 as "option 1", min_salary + (min_salary * 0.05) as "option 2"
from job;

-- no table involved in this select
select current_date, sqrt(25) as "squared root", 5 / 2 as "integer division";

-- concatenation by operator ||
select region_id || ': ' || country_id as "the countries"
from country;

-- concatenation by concat()
select concat(region_id, ': ', country_id) as "the countries"
from country;

-- limit to get result set with a specified size
select first_name, last_name
from employee
limit 10;

-- second page
select first_name, last_name
from employee
offset 10 limit 10;

-- eleventh page
select first_name, last_name
from employee
limit 10 offset 100;
