/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on delete
 */
use hron;

-- check the current table status
select *
from service;

-- delete a single row (or none)
delete from service
where service_id = 20;

-- multiline delete - be extra careful with it!
delete from service
where service_id > 10;

-- even more careful here!
-- anyway this statement won't work, for referential integrity problems
delete from service;

-- this table has a many to on relation with service
describe car_service;

select * from car_service;

-- deleting all rows from it first makes delete from service working
delete from car_service;
