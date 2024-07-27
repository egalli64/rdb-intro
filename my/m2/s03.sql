/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on inner join: using / on / natural
 */
use hron;

-- pre-SQL/92 join
select r.name as region, c.name as country
from region r, country c
where r.region_id = c.region_id;

-- join-using, handy
select r.name as region, c.name as country
from region r join country c
using (region_id);

-- join-on, flexible
select r.name as region, c.name as country
from region r join country c
on r.region_id = c.region_id;

-- !!! here a natural join leads to the wrong (empty) result set !!!
select r.name as region, c.name as country
from region r natural join country c;
