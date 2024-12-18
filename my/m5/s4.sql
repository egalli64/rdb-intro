/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on delete
 */
use hron;
set autocommit = OFF;

-- check the current table status
select *
from service;

-- delete a single row (or none)
delete from service
where service_id = 20;

-- multiline delete - be extra careful with it!
delete from service
where location_id = 22;

-- even more careful here!
-- anyway this statement won't work, for referential integrity problems
delete from service;

-- this table has a many to on relation with service
describe car_service;

select * from car_service;

-- deleting all rows from it first makes delete from service working
delete from car_service;

rollback;
