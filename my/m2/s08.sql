/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on cross join
 */
use hron;

-- cartesian product - following the SQL/92 syntax
select r.name, s.name
from region r cross join service s;

-- cartesian product - non SQL/92 compliant!
select r.name, s.name
from region r join service s;

-- "classic" cartesian product
select r.name, s.name
from region r, service s;
