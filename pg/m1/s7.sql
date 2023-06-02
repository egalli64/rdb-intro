/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

    Examples on regular expressions by operator ~
 */

-- a lowercase 'k' anywhere in a string
select first_name, last_name
from employee
where first_name ~ 'k';

-- a upper/lower 'k' anywhere in a string
select first_name, last_name
from employee
where first_name ~* 'k';

-- without a lowercase 'a' anywhere in a string
select first_name, last_name
from employee
where first_name !~ 'a'
order by 1;

-- without a upper/lower 'a' anywhere in a string
select first_name, last_name
from employee
where first_name !~* 'a'
order by 1;

-- starting by 'A'
select first_name, last_name
from employee
where first_name ~ '^A';

-- ending by 'x'
select first_name, last_name
from employee
where first_name ~ 'x$';

-- an 'e' in second position
select first_name, last_name
from employee
where first_name ~ '^.e';

-- an 'l' in the last position or immediately before
select first_name, last_name
from employee
where first_name ~ 'l.?$';

-- an 'i', at least an 's', an 'o'
select first_name, last_name
from employee
where last_name ~ 'is+o';

-- an 'i', possibily one or more 's', an 'o'
select first_name, last_name
from employee
where last_name ~ 'is*o';

-- an 'i', one or no 's', an 'o'
select first_name, last_name
from employee
where last_name ~ 'is?o';

-- whichever among f,w,z
select first_name, last_name
from employee
where first_name ~ '[fwz]';

-- whichever has at least a letter (upper/lower) not in the set
select first_name, last_name
from employee
where first_name ~* '[^abcdefghijklmnoprstuvxy ]';

-- whichever has at least a letter (upper/lower) not in a..z
select first_name, last_name
from employee
where first_name ~* '[^a-z]';

-- with a space in it
select first_name, last_name
from employee
where first_name ~ '\s';
