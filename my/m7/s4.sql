/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on truncate / drop table
 */
use hron;

-- get rid of all rows (DML)
delete from other_constrained;

-- get rid of all rows (DDL)
truncate table other_constrained;

-- get rid of the table (DDL)
drop table other_constrained;

-- do not fail if table is missing
drop table if exists other_constrained;
