/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples: a procedure with a local variable, a select into, an if-else
 */
use hron;

drop procedure if exists total_salaries_coders;

delimiter //

create procedure total_salaries_coders()
begin
	declare v_total decimal(8, 2);

	select sum(e.salary)
	into v_total
	from employee e join department d using (department_id)
	where d.name = 'IT';

	if v_total > 0 then
		select v_total as "total salaries";
	else
		select "no salary information available for coders!" as warning;
	end if;
end;

//
delimiter ;

call total_salaries_coders();
