/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on inner join
 */
use hron;

-- name of a region and name of countries for that region
select name
from region
where region_id = 1;

select name
from country
where region_id = 1;

-- ...
select name
from region
where region_id = 4;

select name
from country
where region_id = 4;

-- join the two tables and see the full result in a single shot
select region.region_id as r_id, region.name, country_id, country.name
from region, country
where region.region_id = country.region_id;

-- using table (and column) aliases
select r.region_id as r_id, r.name as 'Region Name', c.name as Country
from region r, country c
where r.region_id = c.region_id;
