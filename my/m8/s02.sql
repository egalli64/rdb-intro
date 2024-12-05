/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Example: life of a Stored Procedure
 */
use hron;

drop procedure if exists hello;

delimiter //

create procedure hello()
begin
	select "Hello!" as greetings;
end;

// delimiter ;

call hello();
