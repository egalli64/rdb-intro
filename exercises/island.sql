/*
 * SQL Island - https://sql-island.informatik.uni-kl.de/ 
 */

-- Given: list of villages
select *
from village;

-- Task 1: list all inhabitants
select *
from inhabitant;

-- Given: list of butchers
select *
from inhabitant
where job = 'butcher';

-- Task 2: list of friendly inhabitants
select *
from inhabitant
where state = 'friendly';

-- Task 3: list of friendly weaponsmiths
select *
from inhabitant
where state = 'friendly' and job = 'weaponsmith';

-- Task 4: list of friendly smiths
select *
from inhabitant
where state = 'friendly' and job like '%smith';

-- Given: insert new inhabitant
insert into inhabitant (name, villageid, gender, job, gold, state) values ('Stranger', 1, '?', '?', 0, '?');

-- Task 5: Stranger id
select personid
from inhabitant
where name = 'Stranger';

-- Task 6: Stranger gold
select gold
from inhabitant
where personid = 20;

-- Task 7: list of items with no associated owner
select *
from item
where owner is null;

-- Given: associate coffee cup to Stranger
update item
set owner = 20
where item = 'coffee cup';

-- Task 8: associate all free items to Stranger
update item
set owner = 20
where owner is null;

-- Task 9: list all items associated to Stranger
select *
from item
where owner = 20;
