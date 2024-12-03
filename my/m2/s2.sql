/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on inner join
 */
use hron;

-- 1. Without join, get the required information in many resultsets

-- 1a. name of a region
select name
from region
where region_id = 1;

-- 1b. name of a region of countries for that region
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

-- 2. With join, get a single resultset with all the required information

-- Join in the "classic" way
select region.region_id as 'Region Id', region.name, country_id, country.name
from region, country
where region.region_id = country.region_id;

-- Using table (and column) aliases make query and resultset more readable
select r.region_id as 'Region Id', r.name as 'Region Name', c.name as Country
from region r, country c
where r.region_id = c.region_id;
