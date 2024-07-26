-- run it on MySQL as root
-- it creates user and schema hron

-- firstly drop anything related with hron, if already there
drop user if exists hron;
drop schema if exists hron;

-- !!! change the password with a safe one !!!
create user hron identified by 'password';
create schema hron;

grant all privileges on hron.* to hron;
grant alter routine on hron.* to hron;

use hron;

-- the following procedure is used to simplify the setup script
DELIMITER //

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

//
DELIMITER ;
