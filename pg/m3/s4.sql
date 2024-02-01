-- examples on date functions

-- current date
select current_date;

-- current date-time with time zone
select current_timestamp, now();

-- current date-time (no time zone)
select localtimestamp, current_timestamp::timestamp;

-- current date-time, with and  without time zone
select current_time, current_time::time, localtime;

-- operators -, +
select current_date - 1 as yesterday, current_date + 1 as tomorrow;

select extract(year from now()), extract(month from now()), extract(dow from now()), extract(doy from now());
