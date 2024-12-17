/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples: a procedure with parameters
 */
use hron;

drop procedure if exists get_coder_salary;
drop procedure if exists get_coder_name;

delimiter //

create procedure get_coder_salary(
	in p_coder_id integer,
    out p_salary decimal(8, 2)
) begin
	select salary
	into p_salary
	from coder
	where coder_id = p_coder_id;
end;

create procedure get_coder_name(
	in p_coder_id integer,
    out p_name varchar(50)
) begin
	select concat(first_name, ' ', last_name)
	into p_name
	from coder
	where coder_id = p_coder_id;
end;

//
delimiter ;

call get_coder_salary(103, @my_salary);
select @my_salary;

call get_coder_name(107, @my_name);
select @my_name;

-- exercise
-- create procedure get_department_led
-- in: employee id
-- out: department name
--        name of department led by in param, or '!!!'

-- exercise /2
-- create procedure get_department_name
-- in: employee id
-- out: department name in which the employee works or '!!!'
