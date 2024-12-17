/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

	Exercise: SQL Island 
	https://sql-island.informatik.uni-kl.de/?lang=en
    Game saved with ID: Wz8BfH1vre
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

-- Task 10: Find a friendly dealer or merchant inhabitant
select *
from inhabitant
where state = 'friendly' and job in ('dealer', 'merchant');

-- Task 11: Set 15 as owner for 'ring' and 'teapot'
update item
set owner = 15
where item in ('ring', 'teapot');

-- Given: increase Stranger gold by 120
update inhabitant
set gold = gold + 120
where personid = 20;

-- Task 12: Change the Stranger name 
update inhabitant
set name = 'Manny'
where personid = 20;

-- Task 13: List bakers ordered by gold, from the richest one
select *
from inhabitant
where job = 'baker'
order by gold desc;

-- Given: Change Manny gold
update inhabitant
set gold = gold + 100 - 150 
where personid = 20;

-- Given: add sword among Manny items
insert into item (item, owner) VALUES ('sword', 20);

-- Task 14: Check for pilots
select *
from inhabitant
where job = 'pilot';

-- Given: find the village where 'Dirty Dieter' lives
select village.name
from village, inhabitant
where village.villageid = inhabitant.villageid and inhabitant.name = 'Dirty Dieter';

-- Task 15: find the name of the 'Onionville' 'chief'
select i.name
from village v join inhabitant i
on v.chief = i.personid
where v.name = 'Onionville';

-- Given: inhabitants in Onionville
select count(*)
from inhabitant, village
where village.villageid = inhabitant.villageid and village.name = 'Onionville';

-- Task 16: how many women there are in Onionville?
select count(*)
from village v join inhabitant i
using (villageid)
where v.name = 'Onionville' and i.gender = 'f';

-- Task 17: name of the only woman in Onionville
select i.name
from village v join inhabitant i
using (villageid)
where v.name = 'Onionville' and i.gender = 'f';

-- Given: total gold of Cucumbertown inhabitants
select sum(inhabitant.gold)
from inhabitant, village
where village.villageid = inhabitant.villageid and village.name = 'Cucumbertown';

-- Task 18: total gold owned by bakers, dealers and merchants
select sum(gold)
from inhabitant
where job in ('baker', 'dealer', 'merchant');

-- Given: average gold, depending on job
select job, sum(inhabitant.gold), avg(inhabitant.gold) average
from inhabitant
group by job
order by average;

-- Task 19: average gold, depending on state
select state, avg(inhabitant.gold) average
from inhabitant
group by state
order by average;

-- Given: Kill 'Dirty Dieter'
delete from inhabitant
where name = 'Dirty Dieter';

-- Task 20: kill 'Dirty Diane'
delete from inhabitant
where name = 'Dirty Diane';

-- Task 21: free the kidnapped guy
update inhabitant
set state = 'friendly'
where state = 'kidnapped';

-- Given: leave the island
update inhabitant
set state = 'emigrated'
where personid = 20
