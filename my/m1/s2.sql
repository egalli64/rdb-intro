/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Minimal SQL
 */

-- MySQL feature to disable autocommit: OFF = 0 and ON = 1
set autocommit = OFF;

-- Ensure to work in the specified schema
use hron;

-- select all
select *
from service;

-- insert a new row
insert into service (name)
values ('Scratchaway');

-- update a row
update service
set location_id = 13
where service_id = 1;

-- delete a row
delete from service
where name = 'Scratchaway';

-- do not confirm the changes
rollback;
