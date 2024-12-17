/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on filtered join
 */
use hron;

-- "classic" join - where is both for join _and_ filtering
select r.name as region, c.name as country
from region r, country c
where r.region_id = c.region_id
  and r.name = 'Europe';

-- join using - simple but limited
select r.name as region, c.name as country
from region r join country c
using (region_id)
where r.name = 'Europe';

-- join on - clear and with full functionality
select r.name as region, c.name as country
from region r join country c
on r.region_id = c.region_id
where r.region_id = 1;
