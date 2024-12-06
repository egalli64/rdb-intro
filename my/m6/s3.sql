/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on transaction
 */
use hron;

-- current status
select * 
from service;

--
-- 1. can't rollback if autocommit is on
--

-- 1a. ensure autocommit is active
set autocommit = on;

-- 1b. if there is no service with PK 10 insert it
insert into service
values (10, 'Test', 2);

-- 1c. change name for service PK 10
update service
set name = 'Car 42'
where service_id = 10;

-- 1d. can't rollback, it has been autocommitted!
rollback;

--
-- 2. rollback when autocommit is off
--

-- 2a. ensure autocommit is not active
set autocommit = off;

-- 2b. change name for service PK 10
update service
set name = 'mistake!'
where service_id = 10;

-- 2c. in this case a rollback makes sense
rollback;

--
-- 3. explicit transaction
--

-- 3a. the following DML commands are not autocommitted
start transaction;

-- 3b. not committed
update service
set name = 'Example 1'
where service_id = 10;

-- 3c. terminate the transaction
rollback;

--
-- 4. explicit transaction with savepoint
--

-- 4a.
start transaction;

-- 4b.
update service
set name = 'Example 2'
where service_id = 10;

-- 4c.
savepoint first_step;

-- 4d. new row
insert into service (name)
values ('Example 2');

-- 4e. keep the update, rollback the insert
rollback to first_step;

-- 4f. persist the update
commit;

-- 4g. rollback after commit is useless
rollback;
