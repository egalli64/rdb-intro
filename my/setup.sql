-- assuming the hron schema has already been created (see once.sql)
-- source this script on MySQL (as hron)

use hron;

-- cleanup

drop table if exists team_employee;
drop table if exists team;
drop table if exists car_service;
drop table if exists service;
drop table if exists car;
-- this call is required to sort a non trivial relation between department and employee table
call drop_fk_if_exists('department', 'department_manager_fk');
drop table if exists employee;
drop table if exists department;
drop table if exists location;
drop table if exists country;
drop table if exists region;
drop table if exists job;

drop procedure if exists get_employee_car;
drop procedure if exists get_employee_salary;

-- a table in a relation one to many: "one" region, "many" countries
create table region(
	region_id integer primary key auto_increment,
	name varchar(25)
);

insert into region (name) values
	('Europe'),
    ('Americas'),
    ('Asia'),
    ('Middle East and Africa');
commit;

-- a table in a many to one relation: "many" countries to "one" region
create table country(
	country_id char(2) primary key,
	name varchar(40),
	region_id integer,

    foreign key (region_id) references region (region_id)
);

-- FK from region table
-- using variables lead to more robust code
-- however, here we are relying on the natural order followed by auto_increment 
-- select region_id into @europe from region where name = 'Europe';
-- select region_id into @americas from region where name = 'Americas';
-- select region_id into @asia from region where name = 'Asia';
-- select region_id into @mea from region where name = 'Middle East and Africa';

insert into country (country_id, name, region_id) values
	('AR', 'Argentina', 2), -- 2 is for Americas
    ('AU', 'Australia', 3), -- 3 is for Asia
    ('BE', 'Belgium', 1), -- 1 is for Europe
    ('BR', 'Brazil', 2),
    ('CA', 'Canada', 2),
    ('CH', 'Switzerland', 1),
    ('CN', 'China', 3),
    ('DE', 'Germany', 1),
    ('DK', 'Denmark', 1),
    ('EG', 'Egypt', 4), -- 4 is for Middle East and Africa
    ('FR', 'France', 1),
    ('IL', 'Israel', 4),
    ('IN', 'India', 3),
    ('IT', 'Italy', 1),
    ('JP', 'Japan', 3),
    ('KW', 'Kuwait', 4),
    ('ML', 'Malaysia', 3),
    ('MX', 'Mexico', 2),
    ('NG', 'Nigeria', 4),
    ('NL', 'Netherlands', 1),
    ('SG', 'Singapore', 3),
    ('UK', 'United Kingdom', 1),
    ('US', 'United States of America', 2),
    ('ZM', 'Zambia', 4),
    ('ZW', 'Zimbabwe', 4);
commit;

-- "many" locations to many departments
create table location(
	location_id integer primary key auto_increment,
	street_address varchar(40),
	postal_code varchar(12),
	city varchar(30) not null,
	state_province varchar(25),
	country_id char(2),

    foreign key (country_id) references country (country_id)
);

-- FK from country table
select country_id into @it from country where name = 'Italy';
select country_id into @jp from country where name = 'Japan';
select country_id into @us from country where name = 'United States of America';
select country_id into @ca from country where name = 'Canada';
select country_id into @cn from country where name = 'China';
select country_id into @in from country where name = 'India';
select country_id into @au from country where name = 'Australia';
select country_id into @sg from country where name = 'Singapore';
select country_id into @uk from country where name = 'United Kingdom';
select country_id into @de from country where name = 'Germany';
select country_id into @br from country where name = 'Brazil';
select country_id into @ch from country where name = 'Switzerland';
select country_id into @nl from country where name = 'Netherlands';
select country_id into @mx from country where name = 'Mexico';

insert into location (street_address, postal_code, city, state_province, country_id) values
	('Via Cola di Rienzo, 1297', '00989', 'Roma', 'RM', @it),
    ('Calle della Testa, 93091', '10934', 'Venice', 'VE', @it),
    ('2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', @jp),
    ('9450 Kamiya-cho', '6823', 'Hiroshima', null, @jp),
    ('2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', @us),
    ('2011 Interiors Blvd', '99236', 'South San Francisco', 'California', @us),
    ('2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', @us),
    ('2004 Charade Rd', '98199', 'Seattle', 'Washington', @us),
    ('147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', @ca),
    ('6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', @ca),
    ('40-5-12 Laogianggen', '190518', 'Beijing', null, @cn),
    ('1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', @in),
    ('12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', @au),
    ('198 Clementi North', '540198', 'Singapore', null, @sg),
    ('8204 Arthur St', null, 'London', null, @uk),
    ('Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', @uk),
    ('9702 Chester Road', '09629850293', 'Stretford', 'Manchester', @uk),
    ('Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', @de),
    ('Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', @br),
    ('20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', @ch),
    ('Murtenstrasse 921', '3095', 'Bern', 'BE', @ch),
    ('Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', @nl),
    ('Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal', @mx);
commit;

-- "one" job to many employees
create table job(
	job_id integer primary key auto_increment,
	title varchar(35) not null,
	min_salary decimal(6,0),
	max_salary decimal(6,0),

    check (min_salary < max_salary)
);

insert into job (title, min_salary, max_salary) values
	('President', 20080, 40000),
	('Vice President', 15000, 30000),
	('Assistant', 3000, 6000),
	('Finance Manager', 8200, 16000),
	('Accountant', 4200, 9000),
	('Accounting Manager', 8200, 16000),
	('Public Accountant', 4200, 9000),
	('Sales Manager', 10000, 20080),
	('Sales Representative', 6000, 12008),
	('Purchasing Manager', 8000, 15000),
    ('Purchasing Clerk', 2500, 5500),
    ('Stock Manager', 5500, 8500),
	('Stock Clerk', 2008, 5000),
	('Shipping Clerk', 2500, 5500),
	('Programmer', 4000, 10000),
	('Marketing Manager', 9000, 15000),
	('Marketing Representative', 4000, 9000),
	('Human Resources Representative', 4000, 9000),
    ('Public Relations Representative', 4500, 10500);
commit;

-- a table with a complicated relation with employee, plus "many" to one location
create table department(
	department_id integer primary key auto_increment,
	name varchar(30) not null,
	manager_id integer unique,
	location_id integer,

    foreign key (location_id) references location (location_id)
);

-- FK from location table
select location_id into @sewa from location where city = 'Seattle';
select location_id into @sltx from location where city = 'Southlake';
select location_id into @toon from location where city = 'Toronto';
select location_id into @lond from location where city = 'London';
select location_id into @sfca from location where city = 'South San Francisco';
select location_id into @muba from location where city = 'Munich';
select location_id into @oxfr from location where city = 'Oxford';

insert into department (name, location_id) values
	('Administration', @sewa),
	('Marketing', @toon),
	('Purchasing', @sewa),
	('Human Resources', @lond),
    ('Shipping', @sfca),
    ('IT', @sltx),
    ('Public Relations', @muba),
    ('Sales', @oxfr),
    ('Executive', @sewa),
    ('Finance', @sewa),
    ('Accounting', @sewa);
commit;

-- other departements, not used
insert into department (name) values
    ('Treasury'),
    ('Benefits'),
    ('Manufacturing'),
    ('Contracting'),
    ('Operations'),
    ('IT Support'),
    ('IT Helpdesk'),
    ('Recruiting');
commit;

-- the core table, with many relations (also a self - manager)
create table employee(
	employee_id integer primary key auto_increment,
	first_name varchar(20),
	last_name varchar(25) not null,
	phone integer unique not null,
	hired date not null,
	salary decimal(8,2),
	commission decimal(2,2),
	job_id integer not null,
	manager_id integer,
	department_id integer,

	check (salary > 0),
    foreign key (job_id) references job (job_id),
    foreign key (department_id) references department (department_id)
);

alter table employee auto_increment = 100;

-- FK from job table
select job_id into @pres from job where title = 'President';
select job_id into @vprs from job where title = 'Vice President';
select job_id into @asst from job where title = 'Assistant';
select job_id into @fimg from job where title = 'Finance Manager';
select job_id into @prog from job where title = 'Programmer';
select job_id into @acct from job where title = 'Accountant';
select job_id into @pumg from job where title = 'Purchasing Manager';
select job_id into @puck from job where title = 'Purchasing Clerk';
select job_id into @stmg from job where title = 'Stock Manager';
select job_id into @stck from job where title = 'Stock Clerk';
select job_id into @samg from job where title = 'Sales Manager';
select job_id into @sarp from job where title = 'Sales Representative';
select job_id into @shck from job where title = 'Shipping Clerk';
select job_id into @mkmg from job where title = 'Marketing Manager';
select job_id into @mkrp from job where title = 'Marketing Representative';
select job_id into @hrrp from job where title = 'Human Resources Representative';
select job_id into @prrp from job where title = 'Public Relations Representative';
select job_id into @acmg from job where title = 'Accounting Manager';
select job_id into @puac from job where title = 'Public Accountant';

-- employees with no commission
insert into employee (first_name, last_name, phone, hired, job_id, salary) values
 ('Steven', 'King', 4511, '2016-06-17', @pres, 24000),
 ('Neena', 'Kochhar', 4568, '2014-09-21', @vprs, 17000),
 ('Lex', 'De Haan', 4518, '2014-01-13', @vprs, 17000),
 ('Alexander', 'Hunold', 4567, '2019-01-06', @prog, 9000),
 ('Bruce', 'Ernst', 4268, '2021-05-21', @prog, 6000),
 ('David', 'Austin', 4571, '2018-06-25', @prog, 4800),
 ('Valli', 'Pataballa', 4560, '2019-02-05', @prog, 4800),
 ('Diana', 'Lorentz', 5567, '2020-02-07', @prog, 4200),
 ('Nancy', 'Greenberg', 4569, '2015-08-17', @fimg, 12008),
 ('Daniel', 'Faviet', 4169, '2015-08-16', @acct, 9000),
 ('John', 'Chen', 4269, '2018-09-28', @acct, 8200),
 ('Ismael', 'Sciarra', 4369, '2018-09-05', @acct, 7700),
 ('Jose Manuel', 'Urman', 4469, '2019-03-07', @acct, 7800),
 ('Luis', 'Popp', 4597, '2020-12-07', @acct, 6900),
 ('Den', 'Raphaely', 4561, '2020-12-02', @pumg, 11000),
 ('Alexander', 'Khoo', 4562, '2021-05-03', @puck, 3100),
 ('Shelli', 'Baida', 4563, '2018-12-24', @puck, 2900),
 ('Sigal', 'Tobias', 4564, '2018-07-24', @puck, 2800),
 ('Guy', 'Himuro', 4565, '2019-11-15', @puck, 2600),
 ('Karen', 'Colmenares', 4566, '2021-08-07', @puck, 2500),
 ('Matthew', 'Weiss', 4330, '2017-07-18', @stmg, 8000),
 ('Adam', 'Fripp', 2234, '2018-04-10', @stmg, 8200),
 ('Payam', 'Kaufling', 3234, '2016-05-01', @stmg, 7900),
 ('Shanta', 'Vollman', 4234, '2018-10-10', @stmg, 6500),
 ('Kevin', 'Mourgos', 4244, '2020-11-16', @stmg, 5800),
 ('Julia', 'Nayer', 4214, '2018-07-16', @stck, 3200),
 ('Irene', 'Mikkilineni', 4224, '2019-09-06', @stck, 2700),
 ('James', 'Landry', 4334, '2020-01-14', @stck, 2400),
 ('Steven', 'Markle', 4434, '2021-03-08', @stck, 2200),
 ('Laura', 'Bissot', 5234, '2018-08-20', @stck, 3300),
 ('Mozhe', 'Atkinson', 6234, '2018-10-30',@stck, 2800),
 ('James', 'Marlow', 7234, '2018-02-16', @stck, 2500),
 ('TJ', 'Olson', 8234, '2020-04-10', @stck, 2100),
 ('Jason', 'Mallin', 1934, '2017-06-14', @stck, 3300),
 ('Michael', 'Rogers', 4834, '2019-08-26', @stck, 2900),
 ('Ki', 'Gee', 4734, '2020-12-12', @stck, 2400),
 ('Hazel', 'Philtanker', 4634, '2021-02-06', @stck, 2200),
 ('Renske', 'Ladwig', 4233, '2016-07-14', @stck, 3600),
 ('Stephen', 'Stiles', 4034, '2018-10-26', @stck, 3200),
 ('John', 'Scantamburlo', 4019, '2019-02-12', @stck, 2700),
 ('Joshua', 'Patel', 4824, '2019-04-06', @stck, 2500),
 ('Trenna', 'Rajs', 4009, '2016-10-17', @stck, 3500),
 ('Curtis', 'Davies', 4994, '2018-01-29', @stck, 3100),
 ('Randall', 'Matos', 4874, '2019-03-15', @stck, 2600),
 ('Peter', 'Vargas', 4004, '2019-07-09', @stck, 2500),
 ('Winston', 'Taylor', 4276, '2019-01-24', @shck, 3200),
 ('Jean', 'Fleaur', 4277, '2019-02-23', @shck, 3100),
 ('Martha', 'Sullivan', 4878, '2020-06-21', @shck, 2500),
 ('Girard', 'Geoni', 4879, '2021-02-03', @shck, 2800),
 ('Nandita', 'Sarchand', 4816, '2017-01-27', @shck, 4200),
 ('Alexis', 'Bull', 4846, '2018-02-20', @shck, 4100),
 ('Juliet', 'Dullinger', 4256, '2019-06-24', @shck, 3400),
 ('Anthony', 'Cabrio', 4271, '2020-02-07', @shck, 3000),
 ('Kelly', 'Chung', 4376, '2018-06-14', @shck, 3800),
 ('Jennifer', 'Dilly', 4872, '2018-08-13', @shck, 3600),
 ('Tim', 'Gates', 4871, '2019-07-11', @shck, 2900),
 ('Randall', 'Perkins', 4576, '2020-12-19', @shck, 2500),
 ('Sarah', 'Bell', 4261, '2017-02-04', @shck, 4000),
 ('Britney', 'Everett', 4226, '2015-03-03', @shck, 3900),
 ('Samuel', 'McCain', 4218, '2016-07-01', @shck, 3200),
 ('Vance', 'Jones', 4275, '2017-03-17', @shck, 2800),
 ('Alana', 'Walsh', 4211, '2019-04-24', @shck, 3100),
 ('Kevin', 'Feeney', 4222, '2019-05-23', @shck, 3000),
 ('Donald', 'OConnell', 4231, '2020-06-21', @shck, 2600),
 ('Douglas', 'Grant', 4240, '2021-01-13', @shck, 2600),
 ('Jennifer', 'Whalen', 4241, '2016-09-17', @asst, 4400),
 ('Michael', 'Hartstein', 4255, '2017-02-17', @mkmg, 13000),
 ('Pat', 'Fay', 4259, '2018-08-17', @mkrp, 6000),
 ('Susan', 'Mavris', 4215, '2015-06-07', @hrrp, 6500),
 ('Hermann', 'Baer', 4288, '2015-06-07', @prrp, 10000),
 ('Shelley', 'Higgins', 4280, '2015-06-07', @acmg, 12008),
 ('Willy', 'Gietz', 4281, '2015-06-07', @puac, 8300);

-- sales have commission
insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
 ('John', 'Russell', 9200, '2017-10-01', @samg, 14000, 0.35),
 ('Karen', 'Partners', 9261, '2018-01-05', @samg, 13500, 0.25),
 ('Alberto', 'Errazuriz', 9218, '2018-03-10', @samg, 12000, 0.25),
 ('Gerald', 'Cambrault', 9211, '2020-10-15', @samg, 11000, 0.25),
 ('Eleni', 'Zlotkey', 9018, '2018-01-29', @samg, 10500, 0.15),
 ('Peter', 'Tucker', 9299, '2021-01-30', @sarp, 10000, 0.25),
 ('David', 'Bernstein', 5268, '2018-03-24', @sarp, 9500, 0.20),
 ('Peter', 'Hall', 8968, '2018-08-20', @sarp, 9000, 0.20),
 ('Christopher', 'Olsen', 9718, '2019-03-30', @sarp, 8000, 0.15),
 ('Nanette', 'Cambrault', 9768, '2019-12-09', @sarp, 7500, 0.15),
 ('Oliver', 'Tuvault', 9508, '2020-11-23', @sarp, 7000, 0.10),
 ('Jane', 'King', 9228, '2017-01-30', @sarp, 10000, 0.30),
 ('Patrick', 'Sully', 9252, '2017-03-04', @sarp, 9500, 0.30),
 ('Allan', 'McEwen', 9222, '2017-08-01', @sarp, 9000, 0.30),
 ('Lindsey', 'Smith', 9221, '2018-03-10', @sarp, 8000, 0.25),
 ('Louise', 'Doran', 9225, '2018-12-15', @sarp, 7500, 0.25),
 ('Sarath', 'Sewall', 9212, '2019-11-03', @sarp, 7000, 0.20),
 ('Clara', 'Vishney', 9288, '2018-11-11', @sarp, 10500, 0.20),
 ('Danielle', 'Greene', 9213, '2020-03-19', @sarp, 9500, 0.10),
 ('Mattea', 'Marvins', 9256, '2021-01-24', @sarp, 7200, 0.05),
 ('David', 'Lee', 9219, '2021-02-23', @sarp, 6800, 0.05),
 ('Sundar', 'Ande', 9201, '2021-03-24', @sarp, 6400, 0.05),
 ('Amit', 'Banda', 9208, '2021-04-21', @sarp, 6200, 0.05),
 ('Lisa', 'Ozer', 9229, '2018-03-11', @sarp, 11500, 0.20),
 ('Harrison', 'Bloom', 9286, '2019-03-23', @sarp, 10000, 0.15),
 ('Tayler', 'Fox', 9298, '2019-01-24', @sarp, 9600, 0.15),
 ('William', 'Smith', 9255, '2020-02-23', @sarp, 7400, 0.10),
 ('Elizabeth', 'Bates', 9233, '2020-03-24', @sarp, 7300, 0.10),
 ('Sundita', 'Kumar', 9268, '2021-04-21', @sarp, 6100, 0.05),
 ('Ellen', 'Abel', 9267, '2017-05-11', @sarp, 11000, 0.25),
 ('Alyssa', 'Hutton', 9266, '2018-03-19', @sarp, 8800, 0.20),
 ('Jonathon', 'Taylor', 9265, '2019-03-24', @sarp, 8600, 0.15),
 ('Jack', 'Livingston', 2926, '2019-04-23', @sarp, 8400, 0.15),
 ('Kimberely', 'Grant', 9263, '2020-05-24', @sarp, 7000, 0.10),
 ('Charles', 'Johnson', 9262, '2021-01-04', @sarp, 6200, 0.05);
commit;

-- this FK has an explicit name so it is simpler and safer to remove
alter table department add constraint department_manager_fk foreign key (manager_id) references employee (employee_id);
alter table employee add foreign key (manager_id) references employee (employee_id);

-- FK from department table
select department_id into @ac from department where name = 'Accounting';
update employee set department_id = @ac where job_id in (@acmg, @puac);

select department_id into @ad from department where name = 'Administration';
update employee set department_id = @ad where job_id = @asst;

select department_id into @ex from department where name = 'Executive';
update employee set department_id = @ex where job_id in (@pres, @vprs);

select department_id into @fi from department where name = 'Finance';
update employee set department_id = @fi where job_id in (@fimg, @acct);

select department_id into @hr from department where name = 'Human Resources';
update employee set department_id = @hr where job_id = @hrrp;

select department_id into @it from department where name = 'IT';
update employee set department_id = @it where job_id = @prog;

select department_id into @mk from department where name = 'Marketing';
update employee set department_id = @mk where job_id in (@mkmg, @mkrp);

select department_id into @pr from department where name = 'Public Relations';
update employee set department_id = @pr where job_id = @prrp;

select department_id into @pu from department where name = 'Purchasing';
update employee set department_id = @pu where job_id in (@pumg, @puck);

select department_id into @sa from department where name = 'Sales';
update employee set department_id = @sa where job_id in (@samg, @sarp) and first_name != 'Kimberely';

select department_id into @sh from department where name = 'Shipping';
update employee set department_id = @sh where job_id in (@shck, @stck, @stmg);

-- manager id
select employee_id into @mng_fi from employee where first_name = 'Nancy' and last_name = 'Greenberg';
select employee_id into @mng_ac from employee where first_name = 'Shelley' and last_name = 'Higgins';
select employee_id into @mng_ad from employee where first_name = 'Jennifer' and last_name = 'Whalen';
select employee_id into @mng_mk from employee where first_name = 'Michael' and last_name = 'Hartstein';
select employee_id into @mng_pu from employee where first_name = 'Den' and last_name = 'Raphaely';
select employee_id into @mng_sa from employee where first_name = 'John' and last_name = 'Russell';
select employee_id into @mng_ex from employee where first_name = 'Steven' and last_name = 'King';
select employee_id into @mng_hr from employee where first_name = 'Susan' and last_name = 'Mavris';
select employee_id into @mng_sh from employee where first_name = 'Adam' and last_name = 'Fripp';
select employee_id into @vp_it  from employee where first_name = 'Lex' and last_name = 'De Haan';
select employee_id into @vp     from employee where first_name = 'Neena' and last_name = 'Kochhar';
select employee_id into @mng_pr from employee where first_name = 'Hermann' and last_name = 'Baer';
select employee_id into @mng_it from employee where first_name = 'Alexander' and last_name = 'Hunold';

update employee set manager_id = @vp_it where employee_id = @mng_it;
update employee set manager_id = @vp where employee_id in (@mng_fi, @mng_ac, @mng_ad, @mng_hr, @mng_pr);
update employee set manager_id = @mng_it where job_id = @prog and employee_id != @mng_it;
update employee set manager_id = @mng_ex where job_id in (@vprs, @pumg, @stmg, @samg, @mkmg);
update employee set manager_id = @mng_fi where job_id = @acct;
update employee set manager_id = @mng_ac where job_id = @puac;
update employee set manager_id = @mng_mk where job_id = @mkrp;
update employee set manager_id = @mng_pu where job_id = @puck;

-- weiss team
select employee_id into @weiss from employee where first_name = 'Matthew' and last_name = 'Weiss';
select employee_id into @wt_1 from employee where first_name = 'Julia' and last_name = 'Nayer';
select employee_id into @wt_2 from employee where first_name = 'Irene' and last_name = 'Mikkilineni';
select employee_id into @wt_3 from employee where first_name = 'James' and last_name = 'Landry';
select employee_id into @wt_4 from employee where first_name = 'Steven' and last_name = 'Markle';
select employee_id into @wt_5 from employee where first_name = 'Winston' and last_name = 'Taylor';
select employee_id into @wt_6 from employee where first_name = 'Jean' and last_name = 'Fleaur';
select employee_id into @wt_7 from employee where first_name = 'Martha' and last_name = 'Sullivan';
select employee_id into @wt_8 from employee where first_name = 'Girard' and last_name = 'Geoni';	
update employee set manager_id = @weiss where employee_id in (@wt_1, @wt_2, @wt_3, @wt_4, @wt_5, @wt_6, @wt_7, @wt_8);

-- fripp team
select employee_id into @fripp from employee where first_name = 'Adam' and last_name = 'Fripp';
select employee_id into @ft_1 from employee where first_name = 'Laura' and last_name = 'Bissot';
select employee_id into @ft_2 from employee where first_name = 'Mozhe' and last_name = 'Atkinson';
select employee_id into @ft_3 from employee where first_name = 'James' and last_name = 'Marlow';
select employee_id into @ft_4 from employee where first_name = 'TJ' and last_name = 'Olson';
select employee_id into @ft_5 from employee where first_name = 'Nandita' and last_name = 'Sarchand';
select employee_id into @ft_6 from employee where first_name = 'Alexis' and last_name = 'Bull';
select employee_id into @ft_7 from employee where first_name = 'Juliet' and last_name = 'Dullinger';
select employee_id into @ft_8 from employee where first_name = 'Anthony' and last_name = 'Cabrio';	
update employee set manager_id = @fripp where employee_id in (@ft_1, @ft_2, @ft_3, @ft_4, @ft_5, @ft_6, @ft_7, @ft_8);

-- kaufling team
select employee_id into @kaufling from employee where first_name = 'Payam' and last_name = 'Kaufling';
select employee_id into @kt_1 from employee where first_name = 'Jason' and last_name = 'Mallin';
select employee_id into @kt_2 from employee where first_name = 'Michael' and last_name = 'Rogers';
select employee_id into @kt_3 from employee where first_name = 'Ki' and last_name = 'Gee';
select employee_id into @kt_4 from employee where first_name = 'Hazel' and last_name = 'Philtanker';
select employee_id into @kt_5 from employee where first_name = 'Kelly' and last_name = 'Chung';
select employee_id into @kt_6 from employee where first_name = 'Jennifer' and last_name = 'Dilly';
select employee_id into @kt_7 from employee where first_name = 'Tim' and last_name = 'Gates';
select employee_id into @kt_8 from employee where first_name = 'Randall' and last_name = 'Perkins';	
update employee set manager_id = @kaufling where employee_id in (@kt_1, @kt_2, @kt_3, @kt_4, @kt_5, @kt_6, @kt_7, @kt_8);

-- vollman team
select employee_id into @vollman from employee where first_name = 'Shanta' and last_name = 'Vollman';
select employee_id into @vt_1 from employee where first_name = 'Renske' and last_name = 'Ladwig';
select employee_id into @vt_2 from employee where first_name = 'Stephen' and last_name = 'Stiles';
select employee_id into @vt_3 from employee where first_name = 'John' and last_name = 'Scantamburlo';
select employee_id into @vt_4 from employee where first_name = 'Joshua' and last_name = 'Patel';
select employee_id into @vt_5 from employee where first_name = 'Sarah' and last_name = 'Bell';
select employee_id into @vt_6 from employee where first_name = 'Britney' and last_name = 'Everett';
select employee_id into @vt_7 from employee where first_name = 'Samuel' and last_name = 'McCain';
select employee_id into @vt_8 from employee where first_name = 'Vance' and last_name = 'Jones';	
update employee set manager_id = @vollman where employee_id in (@vt_1, @vt_2, @vt_3, @vt_4, @vt_5, @vt_6, @vt_7, @vt_8);

-- mourgos team
select employee_id into @mourgos from employee where first_name = 'Kevin' and last_name = 'Mourgos';
select employee_id into @mt_1 from employee where first_name = 'Trenna' and last_name = 'Rajs';
select employee_id into @mt_2 from employee where first_name = 'Curtis' and last_name = 'Davies';
select employee_id into @mt_3 from employee where first_name = 'Randall' and last_name = 'Matos';
select employee_id into @mt_4 from employee where first_name = 'Peter' and last_name = 'Vargas';
select employee_id into @mt_5 from employee where first_name = 'Alana' and last_name = 'Walsh';
select employee_id into @mt_6 from employee where first_name = 'Kevin' and last_name = 'Feeney';
select employee_id into @mt_7 from employee where first_name = 'Donald' and last_name = 'OConnell';
select employee_id into @mt_8 from employee where first_name = 'Douglas' and last_name = 'Grant';	
update employee set manager_id = @mourgos where employee_id in (@mt_1, @mt_2, @mt_3, @mt_4, @mt_5, @mt_6, @mt_7, @mt_8);

-- russel team
select employee_id into @russel from employee where first_name = 'John' and last_name = 'Russell';
select employee_id into @rt_1 from employee where first_name = 'Peter' and last_name = 'Tucker';
select employee_id into @rt_2 from employee where first_name = 'David' and last_name = 'Bernstein';
select employee_id into @rt_3 from employee where first_name = 'Peter' and last_name = 'Hall';
select employee_id into @rt_4 from employee where first_name = 'Christopher' and last_name = 'Olsen';
select employee_id into @rt_5 from employee where first_name = 'Nanette' and last_name = 'Cambrault';
select employee_id into @rt_6 from employee where first_name = 'Oliver' and last_name = 'Tuvault';
update employee set manager_id = @russel where employee_id in (@rt_1, @rt_2, @rt_3, @rt_4, @rt_5, @rt_6);

-- partners team
select employee_id into @partners from employee where first_name = 'Karen' and last_name = 'Partners';
select employee_id into @pt_1 from employee where first_name = 'Jane' and last_name = 'King';
select employee_id into @pt_2 from employee where first_name = 'Patrick' and last_name = 'Sully';
select employee_id into @pt_3 from employee where first_name = 'Allan' and last_name = 'McEwen';
select employee_id into @pt_4 from employee where first_name = 'Lindsey' and last_name = 'Smith';
select employee_id into @pt_5 from employee where first_name = 'Louise' and last_name = 'Doran';
select employee_id into @pt_6 from employee where first_name = 'Sarath' and last_name = 'Sewall';
update employee set manager_id = @partners where employee_id in (@pt_1, @pt_2, @pt_3, @pt_4, @pt_5, @pt_6);

-- errazuriz team
select employee_id into @errazuriz from employee where first_name = 'Alberto' and last_name = 'Errazuriz';
select employee_id into @et_1 from employee where first_name = 'Clara' and last_name = 'Vishney';
select employee_id into @et_2 from employee where first_name = 'Danielle' and last_name = 'Greene';
select employee_id into @et_3 from employee where first_name = 'Mattea' and last_name = 'Marvins';
select employee_id into @et_4 from employee where first_name = 'David' and last_name = 'Lee';
select employee_id into @et_5 from employee where first_name = 'Sundar' and last_name = 'Ande';
select employee_id into @et_6 from employee where first_name = 'Amit' and last_name = 'Banda';
update employee set manager_id = @Errazuriz where employee_id in (@et_1, @et_2, @et_3, @et_4, @et_5, @et_6);

-- cambrault team
select employee_id into @cambrault from employee where first_name = 'Gerald' and last_name = 'Cambrault';
select employee_id into @ct_1 from employee where first_name = 'Lisa' and last_name = 'Ozer';
select employee_id into @ct_2 from employee where first_name = 'Harrison' and last_name = 'Bloom';
select employee_id into @ct_3 from employee where first_name = 'Tayler' and last_name = 'Fox';
select employee_id into @ct_4 from employee where first_name = 'William' and last_name = 'Smith';
select employee_id into @ct_5 from employee where first_name = 'Elizabeth' and last_name = 'Bates';
select employee_id into @ct_6 from employee where first_name = 'Sundita' and last_name = 'Kumar';
update employee set manager_id = @cambrault where employee_id in (@ct_1, @ct_2, @ct_3, @ct_4, @ct_5, @ct_6);

-- zlotkey team
select employee_id into @zlotkey from employee where first_name = 'Eleni' and last_name = 'Zlotkey';
select employee_id into @zt_1 from employee where first_name = 'Ellen' and last_name = 'Abel';
select employee_id into @zt_2 from employee where first_name = 'Alyssa' and last_name = 'Hutton';
select employee_id into @zt_3 from employee where first_name = 'Jonathon' and last_name = 'Taylor';
select employee_id into @zt_4 from employee where first_name = 'Jack' and last_name = 'Livingston';
select employee_id into @zt_5 from employee where first_name = 'Kimberely' and last_name = 'Grant';
select employee_id into @zt_6 from employee where first_name = 'Charles' and last_name = 'Johnson';
update employee set manager_id = @zlotkey where employee_id in (@zt_1, @zt_2, @zt_3, @zt_4, @zt_5, @zt_6);

commit;

--
-- set managers on department table
--
update department set manager_id = @mng_ad where name = 'Administration';
update department set manager_id = @mng_mk where name = 'Marketing';
update department set manager_id = @mng_pu where name = 'Purchasing';
update department set manager_id = @mng_hr where name = 'Human Resources';
update department set manager_id = @mng_sh where name = 'Shipping';
update department set manager_id = @mng_it where name = 'IT';
update department set manager_id = @mng_pr where name = 'Public Relations';
update department set manager_id = @mng_sa where name = 'Sales';
update department set manager_id = @mng_ex where name = 'Executive';
update department set manager_id = @mng_fi where name = 'Finance';
update department set manager_id = @mng_ac where name = 'Accounting';

-- "one" car for one employee, "many" cars seviced by many services
create table car(
	car_id integer primary key auto_increment,
	name varchar(40) unique,
	employee_id integer unique,

    foreign key (employee_id) references employee (employee_id)
);

insert into car (name, employee_id) values
 ('Silver Hornet', @mng_ad),
 ('White Phantom', @mng_mk),
 ('Batmobile', @mng_pu),
 ('Starsky', @mng_hr),
 ('Smurf', @mng_sh),
 ('Fireball', @vp_it),
 ('Poison', @vp),
 ('Katana', @mng_it),
 ('Titanic', @mng_pr),
 ('Dracula', @mng_sa),
 ('Zeppelin', @mng_ex),
 ('Ruby', @mng_fi),
 ('Tortoise', @mng_ac);
commit;

DELIMITER //

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

//
DELIMITER ;

DELIMITER //

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

//
DELIMITER ;

-- simple table in many-to-many releation with employee
create table team(
    team_id integer primary key auto_increment,
    name varchar(20) unique not null
);

begin;
    insert into team (name) values ('Red');
    insert into team (name) values ('Green');
    insert into team (name) values ('Blue');
commit;

-- simple many to many relation between team and employee
create table team_employee(
    team_id integer,
    employee_id integer,

    primary key (team_id, employee_id),
    foreign key (team_id) references team (team_id),
    foreign key (employee_id) references employee (employee_id)
);

begin;
    insert into team_employee (team_id, employee_id) values
        (1, 103), (1, 107), (1, 111), (1, 118), (1, 123), (1, 125), (1, 133), (1, 153),
        (2, 105), (2, 107), (2, 121), (2, 122), (2, 123), (2, 128), (2, 135), (2, 156),
        (3, 104), (3, 109), (3, 111), (3, 120), (3, 123), (3, 127), (3, 139), (3, 156);
commit;

-- "many" services taking cares of many cars, many services could share one location
create table service(
	service_id integer primary key auto_increment,
	name varchar(40),
	location_id integer,

	foreign key (location_id) references location (location_id)
);

select location_id into @loc1 from location where city = 'Roma';
select location_id into @loc2 from location where city = 'Singapore';

insert into service (name, location_id) values
	('Inspired Glass', @loc1),
	('Faith Auto Repair', @loc1),
	('Happy Brake', @loc2);

-- many to many with details
create table car_service(
	car_id integer,
	service_id integer,
	checkin datetime,
	checkout datetime,

	check (checkin < checkout),
	primary key (car_id, service_id, checkin),
	foreign key (car_id) references car (car_id),
	foreign key (service_id) references service (service_id)
);

insert into car_service (car_id, service_id, checkin, checkout) values
	(1, 1, '2021-08-01 15:00:00', '2021-08-01 16:00:00'),
	(5, 2, '2021-08-03 14:00:00', '2021-08-03 19:00:00'),
	(1, 2, '2021-08-04 08:00:00', '2021-08-04 20:00:00'),
	(1, 3, '2021-10-12 15:00:00', '2021-10-12 18:00:00');
commit;
