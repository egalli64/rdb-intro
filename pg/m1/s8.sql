/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

    Examples on order by
 */

select first_name, last_name, salary 
from employee
order by last_name, first_name;

-- sorting in natural "ascending" order
select first_name, last_name, salary
from employee
order by salary;

-- descending, limited
select first_name, last_name, salary
from employee
order by salary desc
limit 3;

-- positional notation
select first_name, last_name, salary
from employee
where first_name like 'A%'
order by 3 desc
limit 5;

-- explicit column in order by, "asc" is rarely used
select first_name, last_name, hired
from employee
where first_name like 'A%'
order by hired asc
limit 5;

-- column alias in order by 
select first_name || ' ' || last_name as name, hired
from employee
where first_name like 'A%'
order by name
limit 5;
