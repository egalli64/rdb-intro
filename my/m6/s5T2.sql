/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on transaction isolation levels -- see s5.sql for the other transaction code
 */
use hron;

--
-- both transactions serialized, no phantom read
--

-- (1)
set transaction isolation level serializable;

-- (2)
start transaction;
-- (3)
select *
from service;

-- (4) T2 hangs until T1 commit
insert into service (name)
values ('Isolation T2 insert');

-- (5)
commit;

--
-- on read committed level a non-repeatable read is ok
--

-- (1) T1
-- set transaction isolation level read committed;

-- (2)
start transaction;
select *

-- (3)
select * from service
where name like 'Isolation%';

-- (4) T2
update service
set name = 'Isolation T2 update'
where name like 'Isolation%';

-- (5) T2
commit;

-- (6) non-repeatable read, both T1 and T2 see the change
select *
from service
where name like 'Isolation%';

-- (7)
commit;

--
-- when on read uncommitted, we could dirty read
--

-- (1) T1
-- set transaction isolation level read uncommitted;

-- (2)
start transaction;

-- (3) T2
update service
set name = 'Isolation dirty'
where name like 'Isolation%';

-- (4) dirty read
select *
from service
where name like 'Isolation%';

-- (5)
rollback;

--
-- lost update
--

-- (1)
set transaction isolation level read uncommitted;

-- (2)
start transaction;

-- (3) T1
-- update service set name = concat(name, '1') where name like 'Isolation%';

-- (4) T2 waits for T1 commit!
update service
set name = concat(name, '2')
where like 'Isolation%';

-- (4)
commit;

-- (5) both 1 and 2, no lost update!
select *
from service
where name like 'Isolation%';

commit;
