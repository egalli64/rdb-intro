/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

	Run this script on MySQL as root - it creates user and schema hron
 */

-- firstly drop anything related with hron, if already there
drop user if exists hron;
drop schema if exists hron;

-- then create user and associated schema
-- !!! change the password with a safe one !!!
create user hron identified by 'password';
create schema hron;

grant all privileges on hron.* to hron;
grant alter routine on hron.* to hron;

use hron;

-- helper used in the setup script
create procedure drop_fk_if_exists(
	in my_table varchar(64),
    in my_fk varchar(64)
) begin
	if exists(
		select enforced
        from information_schema.table_constraints
		where table_schema = schema() and table_name = my_table and constraint_name = my_fk and constraint_type = 'FOREIGN KEY')
	then
		set @query = concat('ALTER TABLE ', my_table, ' DROP FOREIGN KEY ', my_fk, ';');
 		prepare stmt from @query;
		execute stmt;
		deallocate prepare stmt;
 	end if;
end;
