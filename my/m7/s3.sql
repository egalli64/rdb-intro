/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

    Examples on constraints in create table statement
 */
use hron;

create table constrained (
	pk integer primary key,
    a integer,
    b integer not null,
    c integer unique,
    d integer unique not null,
    e integer,
    f integer,
    g integer check (g > 100),
    
    unique(e),
    foreign key (f) references car(car_id)
);

-- Error Code: 1048. Column 'b' cannot be null
insert into constrained (a, b, c, d, e, f, g)
values (null, null, null, null, null, null, null);

-- Error Code: 1048. Column 'd' cannot be null
insert into constrained (a, b, c, d, e, f, g)
values (null, 1, null, null, null, null, null);

-- Error Code: 1364. Field 'pk' doesn't have a default value
insert into constrained (a, b, c, d, e, f, g)
values (null, 1, null, 1, null, null, null);

insert into constrained (pk, a, b, c, d, e, f, g)
values (1, null, 1, null, 1, null, null, null);

insert into constrained (pk, a, b, c, d, e, f, g)
values (2, null, 1, 1, 2, 1, null, null);

-- Error Code: 1062. Duplicate entry '1' for key 'c'
insert into constrained (pk, a, b, c, d, e, f, g)
values (3, 1, 1, 1, 3, 2, null, null);

insert into constrained (pk, a, b, c, d, e, f, g)
values (3, 1, 1, 2, 3, 2, null, null);

-- Error Code: 1062. Duplicate entry '3' for key 'd'
insert into constrained (pk, a, b, c, d, e, f, g)
values (4, 1, 1, 2, 3, 2, null, null);

-- Error Code: 1062. Duplicate entry '2' for key 'e'
insert into constrained (pk, a, b, c, d, e, f, g)
values (4, 1, 1, 3, 4, 2, null, null);

insert into constrained (pk, a, b, c, d, e, f, g)
values (4, 1, 1, 3, 4, 3, null, null);

-- Error Code: 1062. Duplicate entry '4' for key 'PRIMARY'
insert into constrained (pk, a, b, c, d, e, f, g)
values (4, 1, 1, 4, 5, 4, null, null);

insert into constrained (pk, a, b, c, d, e, f, g)
values (5, 1, 1, 4, 5, 4, null, null);

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`hron`.`constrained`, CONSTRAINT `constrained_ibfk_1` FOREIGN KEY (`f`) REFERENCES `car` (`car_id`))
insert into constrained (pk, a, b, c, d, e, f, g)
values (6, 1, 1, 5, 6, 5, 100, null);

insert into constrained (pk, a, b, c, d, e, f, g)
values (6, 1, 1, 5, 6, 5, 1, null);

-- Error Code: 3819. Check constraint 'constrained_chk_1' is violated.
insert into constrained (pk, a, b, c, d, e, f, g)
values (7, 1, 1, 6, 7, 6, 1, 100);

insert into constrained (pk, a, b, c, d, e, f, g)
values (7, 1, 1, 6, 7, 6, 1, 101);

--
--
--

drop table other_constrained;

create table other_constrained (
	pk integer primary key auto_increment,
    a integer,
    b integer,
    f integer not null,
    
--    primary key(pk),
    constraint other_constrained_ab_uq unique(a, b),
	foreign key (f) references car(car_id) on delete cascade
--    constraint foreign key (f) references clients(client_id) on delete set null
);

select * from other_constrained;

insert into other_constrained (f)
values (1);

insert into other_constrained (a, b)
values (1, 1);

-- Error Code: 1062. Duplicate entry '1-1' for key 'other_constrained_ab_uq'
insert into other_constrained (a, b)
values (1, 1);
