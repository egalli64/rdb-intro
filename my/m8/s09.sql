/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples: function
 */
use hron;

drop function if exists get_salary;

delimiter //

/*
 * Only superusers could say if function creators could be trusted!
 *
 * 		SET GLOBAL log_bin_trust_function_creators = 1;
 *
 * or specify that the function is
 *
 * 		deterministic
 *
 * (plus SUPER privileges)
 */
create function get_salary(
	p_coder_id integer
) returns decimal(8, 2)
begin
	declare v_result decimal(8, 2);

	select salary
	into v_result
	from coder
	where coder_id = p_coder_id;

	return v_result;
end;

//
delimiter ;

select get_salary(107) as salary;
