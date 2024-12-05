/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on alter table
 */
use hron;

-- check the current table status
describe item;

-- add a column
alter table item
add column counter decimal(65, 30);

-- drop a column
alter table item
drop column counter;

-- add check
alter table item
add constraint check(status in ('A', 'B', 'X'));

-- Error Code: 3819. Check constraint 'items_chk_1' is violated.
insert into item
values(13, 'Y', 'ciao', 13);

insert into item (item_id, status)
values(43, 'X');

-- Error Code: 3819. Check constraint 'items_chk_1' is violated.
update item
set status = '?';

-- I mean it, make item empty!
delete from item;

-- check the coder table
describe coder;
select * from coder;

-- add unique constraint
alter table coder
add constraint unique (first_name, last_name);

insert into coder
values(1222, 'Bruce', 'Austin', '2021-12-01', 6000.00);

-- Error Code: 1062. Duplicate entry 'Bruce-Austin' for key 'coder.first_name'
insert into coder
values(1223, 'Bruce', 'Austin', '2022-01-01', 6000.00);

insert into coder
values(1223, 'Bruce Jr.', 'Austin', curdate(), 4000.00);

-- add pk, two ways
alter table coder
add constraint primary key(coder_id);
-- alter table coder
-- modify coder_id int primary key;

-- drop pk
alter table coder
drop primary key;

-- add pk w/ autoincrement, two ways
alter table coder
modify coder_id int primary key auto_increment;
-- alter table coder change coder_id coder_id int primary key auto_increment;

-- drop autoincrement from pk
alter table coder
change coder_id coder_id int;

-- add fk
alter table item
add constraint foreign key(coder_id) references coder(coder_id);
