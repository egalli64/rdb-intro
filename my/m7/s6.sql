/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on index
 */
use hron;

-- index on a column
create index coder_last_name_ix
on coder (last_name);

-- index on more columns
create index coder_name_ix
on coder (first_name, last_name);

-- get rid of indices
drop index coder_last_name_ix
on coder;

drop index coder_name_ix
on coder;
