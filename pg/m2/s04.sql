/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

	Examples on join - on, using, classic - where
 */

-- join using
select r.name as region, c.name as country
from region r join country c
    using (region_id)
where r.name = 'Europe'
order by country;

-- join on
select r.name as region, c.name as country
from region r join country c
	on r.region_id = c.region_id
where r.name = 'Europe'
order by c.name;

select c.name as country
from region r join country c
	on r.region_id = c.region_id
where r.name = 'Europe'
order by c.name;

-- "classic" join
select r.name as region, c.name as country
from region r, country c
where r.region_id = c.region_id
	and r.name = 'Europe'
order by c.name;
