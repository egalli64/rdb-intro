/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on date/time functions
 */
use hron;

-- current date
select curdate(), current_date(), current_date, now();

-- current date and time
select sysdate(), now(), sleep(1), now(), sysdate();

-- day of week name, month name for the current locale
select dayname(curdate()), monthname(curdate());

-- format date using the specified format (here: weekday day MMM YYYY) for the current locale
select date_format(curdate(), '%a %e %b %Y');

-- format a string to date using the specified format, but always for en_US
select str_to_date('sun 15 sep 2019', '%a %e %b %Y');
select str_to_date('2021-31-12', '%Y-%d-%m');

-- add an interval to date
select date_add(curdate(), interval 7 day);
select date_add(curdate(), interval 1 month);

-- subtract an interval to date
select date_sub(curdate(), interval 7 day);

-- extract a component from date, datetime
select extract(day from curdate()), extract(year from curdate());
select extract(second from now());

-- distance in days between two dates
select datediff('2024-12-31', curdate());

-- last day for the current month
select last_day(now());
