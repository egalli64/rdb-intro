/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

	Using union to emulate an inner join
 */

select region_id, name
from region;

-- 1|Europe
-- 2|Americas
-- 3|Asia
-- 4|Middle East and Africa

	select region_id as r_id, 'Europe' as region, country_id, name
	from country
	where region_id = 1
union
	select region_id as r_id, 'Americas', country_id, name
	from country
	where region_id = 2
union
	select region_id as r_id, 'Asia', country_id, name
	from country
	where region_id = 3
union
	select region_id as r_id, 'Middle East and Africa', country_id, name
	from country
	where region_id = 4
order by r_id, name;

-- The join is much more compact and readable
select r.region_id as r_id, r.name as region, c.country_id, c.name
from country c
join region r using(region_id)
order by r_id, name;
