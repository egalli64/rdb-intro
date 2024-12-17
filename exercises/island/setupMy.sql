/*
    Introduction to Relational Database (on MySQL)
    
    https://github.com/egalli64/rdb-intro

	Exercise: SQL Island 
	https://sql-island.informatik.uni-kl.de/?lang=en

	Setup for MySQL
 */

drop user if exists island;
drop schema if exists island;

-- !!! change the password with a safe one !!!
create user island identified by 'password';
create schema island;

grant all privileges on island.* to island;

use island;

create table village(
	villageid int primary key auto_increment,
	name varchar(20),
	chief int
);

insert into village(name, chief) values
	('Monkeycity', 1),
	('Cucumbertown', 6),
	('Onionville', 13);

create table inhabitant(
	personid int primary key auto_increment,
	name varchar(20),
	villageid int,
	gender char(1),
	job varchar(20),
	gold int,
	state varchar(20),

	foreign key (villageid) references village (villageid)
);

insert into inhabitant(name, villageid, gender, job, gold, state) values
	('Paul Bakerman', 1, 'm', 'baker', 850, 'friendly'),
	('Ernest Perry', 3, 'm', 'weaponsmith', 280, 'friendly'),
	('Rita Ox', 1, 'f', 'baker', 350, 'friendly'),
	('Carl Ox', 1, 'm', 'merchant', 250, 'friendly'),
	('Dirty Dieter', 3, 'm', 'smith', 650, 'evil'),
	('Gerry Slaughterer', 2, 'm', 'butcher', 4850, 'evil'),
	('Peter Slaughterer', 3, 'm', 'butcher', 3250, 'evil'),
	('Arthur Tailor', 2, 'm', 'pilot', 490, 'kidnapped'),
	('Tiffany Drummer', 1, 'f', 'baker', 550, 'evil'),
	('Peter Drummer', 1, 'm', 'smith', 600, 'friendly'),
	('Dirty Diane', 3, 'f', 'farmer', 10, 'evil'),
	('Otto Alexander', 2, 'm', 'dealer', 680, 'friendly'),
	('Fred Dix', 3, 'm', 'author', 420, 'friendly'),
	('Enrico Carpenter', 3, 'm', 'weaponsmith', 510, 'evil'),
	('Helen Grasshead', 2, 'f', 'dealer', 680, 'friendly'),
	('Ivy Hatter', 1, 'f', 'dealer', 770, 'evil'),
	('Edward Grasshead', 3, 'm', 'butcher', 990, 'friendly'),
	('Ryan Horse', 3, 'm', 'blacksmith', 390, 'friendly'),
	('Ann Meaty', 2, 'f', 'butcher', 2280, 'friendly');

alter table village add foreign key (chief) references inhabitant (personid);

create table item (
	item varchar(20) primary key,
	owner int,

	foreign key (owner) references inhabitant (personid) on delete set null
);

insert into item (item, owner) values
	('teapot', null),
	('cane', 5),
	('hammer', 2),
	('ring', null),
	('coffee cup', null),
	('bucket', null),
	('rope', 17),
	('carton', null),
	('lightbulb', null);
