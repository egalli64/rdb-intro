/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on view
 */
use hron;

-- check existing table
describe coder;

select *
from coder;

-- create view
create or replace view senior_coder_v as
	select first_name, last_name, hired
	from coder
	where salary > 5000;

-- check the view
describe senior_coder_v;

select *
from senior_coder_v;

update senior_coder_v
set hired = date_add(curdate(), interval 1 day)
where last_name = 'Austin';

-- get rid of a view
drop view senior_coder_v;
