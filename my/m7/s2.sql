/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on create table
 */
use hron;

-- create a simple table with a primary key
create table item (
    item_id integer primary key,
    status char,
    name varchar(20),
    coder_id integer
);

describe item;

insert into item (item_id) values (12);

select *
from item;

update item
set status = 'x', name = 'thing'
where item_id = 12;

-- create a table cloning items
create table cloned_item like item;

-- same structure
describe cloned_item;

-- ... but empty
select *
from cloned_item;

-- create a table by data extraction
create table coder as
    select employee_id as coder_id, first_name, last_name, hired, salary
    from employee e
    join department d using(department_id)
    where d.name = 'IT';
    
describe coder;

select *
from coder;
