/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on transaction
 */
use hron;

-- current status
select * from service;

-- autocommit on
set autocommit = true;

-- the examples are on service 20, if not there, insert it
-- insert into service values (20, 'Test', 2);

-- change a row
update service set name = 'Car 42' where service_id = 20;

-- can't rollback, it has been autocommitted!
rollback;
select * from service;

-- autocommit off
set autocommit = false;

-- change a row
update service set name = 'mistake!' where service_id = 20;

-- the change is there
select * from service;

-- now a rollback makes sense
rollback;
select * from service;

-- ensure autocommit is off for the transaction, regardless of the flag
start transaction;
insert into service (name) values ('Example 1');
select * from service;
savepoint first_step;

insert into service (name) values ('Example 2');
select * from service;
rollback to first_step; -- keep Example 1, rollback Example 2
select * from service;

commit; -- persist Example 1

-- rollback after commit is useless
rollback;
select * from service;

-- if you need some cleanup on the table
-- delete from service where service_id > 10;
-- commit;
