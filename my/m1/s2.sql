/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Minimal SQL
 */
 
-- select all
select *
from service;

-- insert a new row
insert into service (name)
    values ('Scratchaway');

-- update a row
update service
set location_id = 13
where name = 'Scratchaway';

-- delete a row
delete from service
where name = 'Scratchaway';
