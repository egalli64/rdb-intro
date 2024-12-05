/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples: trigger
 */
use hron;

drop trigger if exists before_update_salary;

delimiter //

create trigger before_update_salary
	before update on coder
    for each row
begin
	set new.salary = round(new.salary, -1);
end;

//
delimiter ;

update coder
set salary = salary + 3
-- set salary = salary + 7;
where coder_id = 103;

select * from coder;
