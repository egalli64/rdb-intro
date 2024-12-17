/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

	Run this script on MySQL as hron (or any user with rights on hron schema)

	Assuming the hron schema has already been created (see once.sql)
	Assuming also that the hron tables have already been created (see setup.sql)
 */

use hron;

-- cleanup
drop procedure if exists get_employee_car;
drop procedure if exists get_employee_salary;

-- DELIMITER //

CREATE PROCEDURE get_employee_car(
	in p_employee_id integer,
    out p_car_name varchar(40)
)
begin
	select name
	into p_car_name
	from car
	where employee_id = p_employee_id;
end;

CREATE PROCEDURE get_employee_salary(
	in p_employee_id integer,
    out p_salary decimal(8, 2)
)
begin
	select salary
	into p_salary
	from employee
	where employee_id = p_employee_id;
end;

-- //
-- DELIMITER ;
