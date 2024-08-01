/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on transaction isolation levels -- see s8T2.sql for the other transaction code
 */
use hron;

-- cleanup
start transaction;
	delete from service where service_id = 22;
    select * from service;
commit;

-- both transactions serialized, no phantom read
set transaction isolation level serializable; -- (1)
start transaction; -- (2)
	select * from service; -- (3)
	-- insert into service (service_id, name) values (22, 'T2 insert'); -- (4) T2 hangs until T1 commit
commit; -- (7)

-- on read committed level a non-repeatable read is ok
set transaction isolation level read committed; -- (1) T1
start transaction; -- (2)
	select * from service where service_id = 22; -- (3)
	-- update service set name = 'T2 update' where service_id = 22; -- (4) T2
	-- commit; -- (5) T2
	select * from service where service_id = 22; -- (6) non-repeatable read, both T1 and T2 see the change
commit; -- (7)

-- when on read uncommitted, we could dirty read
set transaction isolation level read uncommitted; -- (1) T1
start transaction; -- (2)
	-- update service set name = 'dirty' where service_id = 22; -- (3) T2
	select * from service where service_id = 22; -- (4) dirty read
rollback; -- (5)

-- lost update
set transaction isolation level read uncommitted; -- (1)
start transaction; -- (2)
	update service set name = concat(name, '1') where service_id = 22; -- (3) T1
	-- update service set name = concat(name, '2') where service_id = 22; -- (4) T2
commit; -- (4)
select * from service where service_id = 22; -- (5) both 1 and 2, no lost update!
commit;
