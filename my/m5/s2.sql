/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on insert
 */
use hron;

-- disable implicit commit on each statement
set autocommit = OFF;

-- check the current table structure
describe service;

-- get the current table values (and its associated city in the location table)
select s.*, l.city
from service s
left outer join location l using (location_id);

--  get just the current table values
select *
from service;

-- get the current location values
select location_id, city
from location;

-- plain insert, auto-incremented value for pk
insert into service (name, location_id)
values ('Mayday Shifty Solutions', 21);

-- multiline insert
insert into service (name, location_id)
values ('Old Gondor Raw Equipment', 21), ('Rohan Leather', 21);

-- nullable column could be skipped
insert into service (name)
values ('Multiple Oz Factories');

-- insert relying on column definition on table
-- !!! a value should be provided for each cell in the record !!!
insert into service
values (99, 'Rainydays Carwash', null);

-- get back to the original state
rollback;
