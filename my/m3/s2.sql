/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on string functions
 */
use hron;

-- string concatenation
select concat(first_name, ' ', last_name) as name
from employee;

-- upper and lower case
select upper('upper') up, lower('LOWER') low;

-- find substring
select position('ba' in 'crab' ) as "not found";
select position('ra' in 'crab' ) as pos;
select locate('ab', 'crab abba rabid cab') as pos;
select locate('ab', 'crab abba rabid cab', 13) as pos;

-- string size (with implicit conversion)
select length('name'), length(42000), length(4 / 3);

-- char and its representation
select ascii('A') as 'A is 65', convert(char(90) using utf8) as '90 is Z';

-- left and right padding
select lpad('tom', 30, '.') 'left padded tom', rpad('tim', 30, '_- -_') 'right padded tim';

-- left, right, both trim
select ltrim(' Hi!') "left", concat('[', rtrim('Hi! '), ']') "right", concat('[', trim('  Hi! '), ']') "both";

-- left, right, both trim
select trim(leading 'xy' from 'xy!xy') "left", trim(trailing 'xy' from 'xy!xy') "right", trim(both 'xy' from 'xy!xy') "both";

-- left/rightmost chars
select left('ABCdiscardedXYZ', 3), right('ABCdiscardedXYZ', 3);

-- extract a substring
select hired, right(hired, 2) as day, substr(hired, 6, 2) as month, left(hired, 4) as year
from employee;
