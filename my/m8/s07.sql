/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples: cursor
 */
use hron;

drop procedure if exists email_coders;

delimiter //

create procedure email_coders()
begin
	declare v_done boolean default false;
	declare v_first_name varchar(20);
	declare v_last_name varchar(25);
	declare v_mailing_list varchar(1000) default '';

	declare cur_coders cursor for
		select first_name, last_name
        from employee e join department d using (department_id)
		where d.name = 'IT';
	declare continue handler for not found
		set v_done = true;

	open cur_coders;
	while not v_done do
		fetch cur_coders into v_first_name, v_last_name;
		set v_mailing_list = concat(v_mailing_list,
			lower(v_first_name), "." , lower(v_last_name), "@accenture.com;");
	end while;
    close cur_coders;

	select v_mailing_list as "mailing list";
end;

//
delimiter ;

call email_coders();
