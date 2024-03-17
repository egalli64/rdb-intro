/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

	Examples on cross join
 */

-- cartesian product - SQL/92
select r.name, s.name
from region r cross join service s;

-- "classic" cartesian product
select r.name, s.name
from region r, service s;
