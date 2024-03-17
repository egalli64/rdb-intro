/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

	Using UNION to emulate an inner join
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
