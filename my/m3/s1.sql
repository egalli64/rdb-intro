/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on casting
 */
use hron;

-- explicit cast to char
select cast(12345.67 as char);

-- explicit cast to date
select cast('2022-01-01' as date);

-- bad format -> NULL
select cast('01-10-2021' as date);

-- explicit cast to datetime
select cast('2022-01-01' as datetime);
