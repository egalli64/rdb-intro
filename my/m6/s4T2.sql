/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on transaction anomalies -- see s4.sql for the other transaction code
 */
use hron;

--
-- phantom read
--

-- (1)
start transaction;

-- (2)
select *
from service;

-- (3) executed by T2
insert into service (service_id, name)
values (22, 'T2 insert');

-- (4) executed by T2
commit;

-- (5) T2 sees the expected result, T1 sees a phantom!
select *
from service;

-- (6) executed by T1
-- commit;

--
-- non-repeatable read
--

-- (1)
start transaction;

-- (2)
select *
from service
where service_id = 22;

-- (3) T2 update the row
update service
set name = 'T2 update'
where service_id = 22;

-- (4) executed by T2
commit; 

-- (5) if T1 sees a change here, it is a non-repeatable read!
-- select * from service where service_id = 22;

-- (6) executed by T1
-- commit;

-- (7) both T1 and T2 see the change
select *
from service
where service_id = 22;

--
-- lost update
--

-- (1)
start transaction;

-- (2) T1
-- update service set name = concat(name, 'X') where service_id = 22;

-- (3) T2 expected to hang until T1 commit
update service
set name = concat(name, 'Z')
where service_id = 22;

-- (4)
commit;

-- (5) both X and Z, or there has been a lost update!
select *
from service
where service_id = 22; 

--
-- dirty read
--

-- (1)
start transaction;

-- (2) T2
update service
set name = 'dirty'
where service_id = 22;

-- (3) if both T1 and T2 read the changed value, this is a dirty read!
select *
from service
where service_id = 22;

-- (4)
rollback;

-- (5) back to previous value
select *
from service
where service_id = 22;
