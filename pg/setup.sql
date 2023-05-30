-- this script should run on hron
-- pre requisite: once.sql
--
-- psql -U hron -d postgres
-- hron=> \i setup.sql

-- cleanup
drop table if exists team_employee;
drop table if exists team;
drop table if exists car_service;
drop table if exists service cascade;
drop table if exists car;
drop sequence if exists car_seq;

alter table if exists department drop constraint if exists department_manager_fk;
drop table if exists employee cascade;
drop table if exists department;
drop table if exists location;
drop table if exists country;
drop table if exists region;
drop table if exists job;

-- simple: "one" region, many countries
create table region (
    region_id serial primary key,
    name varchar(25)
);

begin;
    insert into region (name) values ('Europe');
    insert into region (name) values ('Americas');
    insert into region (name) values ('Asia');
    insert into region (name) values ('Middle East and Africa');
commit;

-- a "many" table with a natural PK, to one region
create table country(
    country_id char(2) primary key,
    name varchar(40),
    region_id integer,

    constraint country_region_fk foreign key (region_id) references region (region_id)
);

do $$ declare
    v_europe region.region_id%type;
    v_americas region.region_id%type;
    v_asia region.region_id%type;
    v_mea region.region_id%type;
begin 
    select region_id into v_europe from region where name = 'Europe';
    select region_id into v_americas from region where name = 'Americas';
    select region_id into v_asia from region where name = 'Asia';
    select region_id into v_mea from region where name = 'Middle East and Africa';

    insert into country (country_id, name, region_id) values ('AR', 'Argentina', v_americas);
    insert into country (country_id, name, region_id) values ('AU', 'Australia', v_asia);
    insert into country (country_id, name, region_id) values ('BE', 'Belgium', v_europe);
    insert into country (country_id, name, region_id) values ('BR', 'Brazil', v_americas);
    insert into country (country_id, name, region_id) values ('CA', 'Canada', v_americas);
    insert into country (country_id, name, region_id) values ('CH', 'Switzerland', v_europe);
    insert into country (country_id, name, region_id) values ('CN', 'China', v_asia);
    insert into country (country_id, name, region_id) values ('DE', 'Germany', v_europe);
    insert into country (country_id, name, region_id) values ('DK', 'Denmark', v_europe);
    insert into country (country_id, name, region_id) values ('EG', 'Egypt', v_mea);
    insert into country (country_id, name, region_id) values ('FR', 'France', v_europe);
    insert into country (country_id, name, region_id) values ('IL', 'Israel', v_mea);
    insert into country (country_id, name, region_id) values ('IN', 'India', v_asia);
    insert into country (country_id, name, region_id) values ('IT', 'Italy', v_europe);
    insert into country (country_id, name, region_id) values ('JP', 'Japan', v_asia);
    insert into country (country_id, name, region_id) values ('KW', 'Kuwait', v_mea);
    insert into country (country_id, name, region_id) values ('ML', 'Malaysia', v_asia);
    insert into country (country_id, name, region_id) values ('MX', 'Mexico', v_americas);
    insert into country (country_id, name, region_id) values ('NG', 'Nigeria', v_mea);
    insert into country (country_id, name, region_id) values ('NL', 'Netherlands', v_europe);
    insert into country (country_id, name, region_id) values ('SG', 'Singapore', v_asia);
    insert into country (country_id, name, region_id) values ('UK', 'United Kingdom', v_europe);
    insert into country (country_id, name, region_id) values ('US', 'United States of America', v_americas);
    insert into country (country_id, name, region_id) values ('ZM', 'Zambia', v_mea);
    insert into country (country_id, name, region_id) values ('ZW', 'Zimbabwe', v_mea);
    commit;
end $$;

-- "many" location in one country
create table location(
    location_id serial primary key,
    street_address varchar(40),
    postal_code varchar(12),
    city varchar(30) not null,
    state_province varchar(25),
    country_id char(2),

    constraint location_country_fk foreign key (country_id) references country (country_id)
);

alter sequence location_location_id_seq restart with 1000 increment by 100;

do $$ declare
    v_it country.country_id%type;
    v_jp country.country_id%type;
    v_us country.country_id%type;
    v_ca country.country_id%type;
    v_cn country.country_id%type;
    v_in country.country_id%type;
    v_au country.country_id%type;
    v_sg country.country_id%type;
    v_uk country.country_id%type;
    v_de country.country_id%type;
    v_br country.country_id%type;
    v_ch country.country_id%type;
    v_nl country.country_id%type;
    v_mx country.country_id%type;
begin
    select country_id into v_it from country where name = 'Italy';
    select country_id into v_jp from country where name = 'Japan';
    select country_id into v_us from country where name = 'United States of America';
    select country_id into v_ca from country where name = 'Canada';
    select country_id into v_cn from country where name = 'China';
    select country_id into v_in from country where name = 'India';
    select country_id into v_au from country where name = 'Australia';
    select country_id into v_sg from country where name = 'Singapore';
    select country_id into v_uk from country where name = 'United Kingdom';
    select country_id into v_de from country where name = 'Germany';
    select country_id into v_br from country where name = 'Brazil';
    select country_id into v_ch from country where name = 'Switzerland';
    select country_id into v_nl from country where name = 'Netherlands';
    select country_id into v_mx from country where name = 'Mexico';

    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('Via Cola di Rienzo, 1297', '00989', 'Roma', 'RM', v_it);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('Calle della Testa, 93091', '10934', 'Venice', 'VE', v_it);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', v_jp);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('9450 Kamiya-cho', '6823', 'Hiroshima', null, v_jp);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', v_us);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('2011 Interiors Blvd', '99236', 'South San Francisco', 'California', v_us);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', v_us);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('2004 Charade Rd', '98199', 'Seattle', 'Washington', v_us);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', v_ca);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', v_ca);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('40-5-12 Laogianggen', '190518', 'Beijing', null, v_cn);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', v_in);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', v_au);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('198 Clementi North', '540198', 'Singapore', null, v_sg);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('8204 Arthur St', null, 'London', null, v_uk);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', v_uk);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('9702 Chester Road', '09629850293', 'Stretford', 'Manchester', v_uk);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', v_de);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', v_br);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', v_ch);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('Murtenstrasse 921', '3095', 'Bern', 'BE', v_ch);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', v_nl);
    insert into location (street_address, postal_code, city, state_province, country_id) values
        ('Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal', v_mx);
    commit;
end $$;

-- "one" job to many employees
create table job (
    job_id serial primary key,
    title varchar(35) not null,
    min_salary integer,
    max_salary integer,

    constraint job_salary_ck check (min_salary < max_salary)
);

begin;
    insert into job (title, min_salary, max_salary) values ('President', 20080, 40000);
    insert into job (title, min_salary, max_salary) values ('Vice President', 15000, 30000);
    insert into job (title, min_salary, max_salary) values ('Assistant', 3000, 6000);
    insert into job (title, min_salary, max_salary) values ('Finance Manager', 8200, 16000);
    insert into job (title, min_salary, max_salary) values ('Accountant', 4200, 9000);
    insert into job (title, min_salary, max_salary) values ('Accounting Manager', 8200, 16000);
    insert into job (title, min_salary, max_salary) values ('Public Accountant', 4200, 9000);
    insert into job (title, min_salary, max_salary) values ('Sales Manager', 10000, 20080);
    insert into job (title, min_salary, max_salary) values ('Sales Representative', 6000, 12008);
    insert into job (title, min_salary, max_salary) values ('Purchasing Manager', 8000, 15000);
    insert into job (title, min_salary, max_salary) values ('Purchasing Clerk', 2500, 5500);
    insert into job (title, min_salary, max_salary) values ('Stock Manager', 5500, 8500);
    insert into job (title, min_salary, max_salary) values ('Stock Clerk', 2008, 5000);
    insert into job (title, min_salary, max_salary) values ('Shipping Clerk', 2500, 5500);
    insert into job (title, min_salary, max_salary) values ('Programmer', 4000, 10000);
    insert into job (title, min_salary, max_salary) values ('Marketing Manager', 9000, 15000);
    insert into job (title, min_salary, max_salary) values ('Marketing Representative', 4000, 9000);
    insert into job (title, min_salary, max_salary) values ('Human Resources Representative', 4000, 9000);
    insert into job (title, min_salary, max_salary) values ('Public Relations Representative', 4500, 10500);
commit;

-- a table with a complicated relation with employee, and in the role "many" to one location
create table department (
    department_id serial primary key,
    name varchar(30) not null,
    manager_id integer,
    location_id integer,

    constraint department_location_fk foreign key (location_id) references location(location_id)
);

do $$ declare
    v_sewa location.location_id%type;
    v_sltx location.location_id%type;
    v_toon location.location_id%type;
    v_lond location.location_id%type;
    v_sfca location.location_id%type;
    v_muba location.location_id%type;
    v_oxfr location.location_id%type;
begin
    select location_id into v_sewa from location where city = 'Seattle';
    select location_id into v_sltx from location where city = 'Southlake';
    select location_id into v_toon from location where city = 'Toronto';
    select location_id into v_lond from location where city = 'London';
    select location_id into v_sfca from location where city = 'South San Francisco';
    select location_id into v_muba from location where city = 'Munich';
    select location_id into v_oxfr from location where city = 'Oxford';

    insert into department (name, location_id) values ('Administration', v_sewa);
    insert into department (name, location_id) values ('Marketing', v_toon);
    insert into department (name, location_id) values ('Purchasing', v_sewa);
    insert into department (name, location_id) values ('Human Resources', v_lond);
    insert into department (name, location_id) values ('Shipping', v_sfca);
    insert into department (name, location_id) values ('IT', v_sltx);
    insert into department (name, location_id) values ('Public Relations', v_muba);
    insert into department (name, location_id) values ('Sales', v_oxfr);
    insert into department (name, location_id) values ('Executive', v_sewa);
    insert into department (name, location_id) values ('Finance', v_sewa);
    insert into department (name, location_id) values ('Accounting', v_sewa);

    -- other departements, not used
    insert into department (name) values ('Treasury');
    insert into department (name) values ('Benefits');
    insert into department (name) values ('Manufacturing');
    insert into department (name) values ('Contracting');
    insert into department (name) values ('Operations');
    insert into department (name) values ('IT Support');
    insert into department (name) values ('IT Helpdesk');
    insert into department (name) values ('Recruiting');
    commit;
end $$;

-- the core table, with many relations (also a self - manager)
create table employee (
    employee_id serial primary key,
    first_name varchar(20),
    last_name varchar(25) not null,
    phone integer unique not null,
    hired date not null,
    job_id integer not null,
    salary numeric(8,2),
    commission numeric(2,2),
    manager_id integer,
    department_id integer,

    constraint employee_salary_ck check (salary > 0),
    constraint employee_job_fk foreign key (job_id) references job (job_id),
    constraint employee_department_fk foreign key (department_id) references department (department_id)
    );

alter sequence employee_employee_id_seq restart with 100;

do $$ declare
    v_pres job.job_id%type;
    v_vprs job.job_id%type;
    v_asst job.job_id%type;
    v_fimg job.job_id%type;
    v_prog job.job_id%type;
    v_acct job.job_id%type;
    v_pumg job.job_id%type;
    v_puck job.job_id%type;
    v_stmg job.job_id%type;
    v_stck job.job_id%type;
    v_samg job.job_id%type;
    v_sarp job.job_id%type;
    v_shck job.job_id%type;
    v_mkmg job.job_id%type;
    v_mkrp job.job_id%type;
    v_hrrp job.job_id%type;
    v_prrp job.job_id%type;
    v_acmg job.job_id%type;
    v_puac job.job_id%type;
begin
    select job_id into v_pres from job where title = 'President';
    select job_id into v_vprs from job where title = 'Vice President';
    select job_id into v_asst from job where title = 'Assistant';
    select job_id into v_fimg from job where title = 'Finance Manager';
    select job_id into v_prog from job where title = 'Programmer';
    select job_id into v_acct from job where title = 'Accountant';
    select job_id into v_pumg from job where title = 'Purchasing Manager';
    select job_id into v_puck from job where title = 'Purchasing Clerk';
    select job_id into v_stmg from job where title = 'Stock Manager';
    select job_id into v_stck from job where title = 'Stock Clerk';
    select job_id into v_samg from job where title = 'Sales Manager';
    select job_id into v_sarp from job where title = 'Sales Representative';
    select job_id into v_shck from job where title = 'Shipping Clerk';
    select job_id into v_mkmg from job where title = 'Marketing Manager';
    select job_id into v_mkrp from job where title = 'Marketing Representative';
    select job_id into v_hrrp from job where title = 'Human Resources Representative';
    select job_id into v_prrp from job where title = 'Public Relations Representative';
    select job_id into v_acmg from job where title = 'Accounting Manager';
    select job_id into v_puac from job where title = 'Public Accountant';

    -- employees with no commission
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Steven', 'King', 4511, '2016-06-17', v_pres, 24000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Neena', 'Kochhar', 4568, '2014-09-21', v_vprs, 17000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Lex', 'De Haan', 4518, '2014-01-13', v_vprs, 17000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Alexander', 'Hunold', 4567, '2019-01-06', v_prog, 9000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Bruce', 'Ernst', 4268, '2021-05-21', v_prog, 6000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('David', 'Austin', 4571, '2018-06-25', v_prog, 4800);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Valli', 'Pataballa', 4560, '2019-02-05', v_prog, 4800);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Diana', 'Lorentz', 5567, '2020-02-07', v_prog, 4200);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Nancy', 'Greenberg', 4569, '2015-08-17', v_fimg, 12008);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Daniel', 'Faviet', 4169, '2015-08-16', v_acct, 9000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('John', 'Chen', 4269, '2018-09-28', v_acct, 8200);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Ismael', 'Sciarra', 4369, '2018-09-05', v_acct, 7700);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Jose Manuel', 'Urman', 4469, '2019-03-07', v_acct, 7800);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Luis', 'Popp', 4597, '2020-12-07', v_acct, 6900);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Den', 'Raphaely', 4561, '2020-12-02', v_pumg, 11000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Alexander', 'Khoo', 4562, '2021-05-03', v_puck, 3100);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Shelli', 'Baida', 4563, '2018-12-24', v_puck, 2900);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Sigal', 'Tobias', 4564, '2018-07-24', v_puck, 2800);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Guy', 'Himuro', 4565, '2019-11-15', v_puck, 2600);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Karen', 'Colmenares', 4566, '2021-08-07', v_puck, 2500);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Matthew', 'Weiss', 4330, '2017-07-18', v_stmg, 8000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Adam', 'Fripp', 2234, '2018-04-10', v_stmg, 8200);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Payam', 'Kaufling', 3234, '2016-05-01', v_stmg, 7900);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Shanta', 'Vollman', 4234, '2018-10-10', v_stmg, 6500);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Kevin', 'Mourgos', 4244, '2020-11-16', v_stmg, 5800);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Julia', 'Nayer', 4214, '2018-07-16', v_stck, 3200);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Irene', 'Mikkilineni', 4224, '2019-09-06', v_stck, 2700);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('James', 'Landry', 4334, '2020-01-14', v_stck, 2400);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Steven', 'Markle', 4434, '2021-03-08', v_stck, 2200);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Laura', 'Bissot', 5234, '2018-08-20', v_stck, 3300);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Mozhe', 'Atkinson', 6234, '2018-10-30',v_stck, 2800);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('James', 'Marlow', 7234, '2018-02-16', v_stck, 2500);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('TJ', 'Olson', 8234, '2020-04-10', v_stck, 2100);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Jason', 'Mallin', 1934, '2017-06-14', v_stck, 3300);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Michael', 'Rogers', 4834, '2019-08-26', v_stck, 2900);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Ki', 'Gee', 4734, '2020-12-12', v_stck, 2400);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Hazel', 'Philtanker', 4634, '2021-02-06', v_stck, 2200);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Renske', 'Ladwig', 4233, '2016-07-14', v_stck, 3600);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Stephen', 'Stiles', 4034, '2018-10-26', v_stck, 3200);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('John', 'Scantamburlo', 4019, '2019-02-12', v_stck, 2700);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Joshua', 'Patel', 4824, '2019-04-06', v_stck, 2500);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Trenna', 'Rajs', 4009, '2016-10-17', v_stck, 3500);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Curtis', 'Davies', 4994, '2018-01-29', v_stck, 3100);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Randall', 'Matos', 4874, '2019-03-15', v_stck, 2600);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Peter', 'Vargas', 4004, '2019-07-09', v_stck, 2500);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Winston', 'Taylor', 4276, '2019-01-24', v_shck, 3200);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Jean', 'Fleaur', 4277, '2019-02-23', v_shck, 3100);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Martha', 'Sullivan', 4878, '2020-06-21', v_shck, 2500);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Girard', 'Geoni', 4879, '2021-02-03', v_shck, 2800);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Nandita', 'Sarchand', 4816, '2017-01-27', v_shck, 4200);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Alexis', 'Bull', 4846, '2018-02-20', v_shck, 4100);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Juliet', 'Dullinger', 4256, '2019-06-24', v_shck, 3400);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Anthony', 'Cabrio', 4271, '2020-02-07', v_shck, 3000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Kelly', 'Chung', 4376, '2018-06-14', v_shck, 3800);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Jennifer', 'Dilly', 4872, '2018-08-13', v_shck, 3600);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Tim', 'Gates', 4871, '2019-07-11', v_shck, 2900);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Randall', 'Perkins', 4576, '2020-12-19', v_shck, 2500);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Sarah', 'Bell', 4261, '2017-02-04', v_shck, 4000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Britney', 'Everett', 4226, '2015-03-03', v_shck, 3900);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Samuel', 'McCain', 4218, '2016-07-01', v_shck, 3200);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Vance', 'Jones', 4275, '2017-03-17', v_shck, 2800);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Alana', 'Walsh', 4211, '2019-04-24', v_shck, 3100);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Kevin', 'Feeney', 4222, '2019-05-23', v_shck, 3000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Donald', 'OConnell', 4231, '2020-06-21', v_shck, 2600);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Douglas', 'Grant', 4240, '2021-01-13', v_shck, 2600);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Jennifer', 'Whalen', 4241, '2016-09-17', v_asst, 4400);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Michael', 'Hartstein', 4255, '2017-02-17', v_mkmg, 13000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Pat', 'Fay', 4259, '2018-08-17', v_mkrp, 6000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Susan', 'Mavris', 4215, '2015-06-07', v_hrrp, 6500);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Hermann', 'Baer', 4288, '2015-06-07', v_prrp, 10000);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Shelley', 'Higgins', 4280, '2015-06-07', v_acmg, 12008);
    insert into employee (first_name, last_name, phone, hired, job_id, salary) values
        ('Willy', 'Gietz', 4281, '2015-06-07', v_puac, 8300);
    
    -- sales have commission
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('John', 'Russell', 9200, '2017-10-01', v_samg, 14000, 0.35);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Karen', 'Partners', 9261, '2018-01-05', v_samg, 13500, 0.25);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Alberto', 'Errazuriz', 9218, '2018-03-10', v_samg, 12000, 0.25);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Gerald', 'Cambrault', 9211, '2020-10-15', v_samg, 11000, 0.25);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Eleni', 'Zlotkey', 9018, '2018-01-29', v_samg, 10500, 0.15);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Peter', 'Tucker', 9299, '2021-01-30', v_sarp, 10000, 0.25);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('David', 'Bernstein', 5268, '2018-03-24', v_sarp, 9500, 0.20);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Peter', 'Hall', 8968, '2018-08-20', v_sarp, 9000, 0.20);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Christopher', 'Olsen', 9718, '2019-03-30', v_sarp, 8000, 0.15);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Nanette', 'Cambrault', 9768, '2019-12-09', v_sarp, 7500, 0.15);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Oliver', 'Tuvault', 9508, '2020-11-23', v_sarp, 7000, 0.10);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Jane', 'King', 9228, '2017-01-30', v_sarp, 10000, 0.30);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Patrick', 'Sully', 9252, '2017-03-04', v_sarp, 9500, 0.30);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Allan', 'McEwen', 9222, '2017-08-01', v_sarp, 9000, 0.30);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Lindsey', 'Smith', 9221, '2018-03-10', v_sarp, 8000, 0.25);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Louise', 'Doran', 9225, '2018-12-15', v_sarp, 7500, 0.25);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Sarath', 'Sewall', 9212, '2019-11-03', v_sarp, 7000, 0.20);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Clara', 'Vishney', 9288, '2018-11-11', v_sarp, 10500, 0.20);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Danielle', 'Greene', 9213, '2020-03-19', v_sarp, 9500, 0.10);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Mattea', 'Marvins', 9256, '2021-01-24', v_sarp, 7200, 0.05);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('David', 'Lee', 9219, '2021-02-23', v_sarp, 6800, 0.05);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Sundar', 'Ande', 9201, '2021-03-24', v_sarp, 6400, 0.05);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Amit', 'Banda', 9208, '2021-04-21', v_sarp, 6200, 0.05);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Lisa', 'Ozer', 9229, '2018-03-11', v_sarp, 11500, 0.20);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Harrison', 'Bloom', 9286, '2019-03-23', v_sarp, 10000, 0.15);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Tayler', 'Fox', 9298, '2019-01-24', v_sarp, 9600, 0.15);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('William', 'Smith', 9255, '2020-02-23', v_sarp, 7400, 0.10);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Elizabeth', 'Bates', 9233, '2020-03-24', v_sarp, 7300, 0.10);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Sundita', 'Kumar', 9268, '2021-04-21', v_sarp, 6100, 0.05);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Ellen', 'Abel', 9267, '2017-05-11', v_sarp, 11000, 0.25);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Alyssa', 'Hutton', 9266, '2018-03-19', v_sarp, 8800, 0.20);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Jonathon', 'Taylor', 9265, '2019-03-24', v_sarp, 8600, 0.15);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Jack', 'Livingston', 2926, '2019-04-23', v_sarp, 8400, 0.15);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Kimberely', 'Grant', 9263, '2020-05-24', v_sarp, 7000, 0.10);
    insert into employee (first_name, last_name, phone, hired, job_id, salary, commission) values
        ('Charles', 'Johnson', 9262, '2021-01-04', v_sarp, 6200, 0.05);    
    commit;
end $$;

alter table department add constraint department_manager_fk foreign key (manager_id) references employee (employee_id);
alter table employee add constraint employee_manager_fk foreign key (manager_id) references employee (employee_id);

-- set the department FK
create or replace procedure set_department_fk_by_job(
    p_dep_name in department.name%type,
    p_job_title in job.title%type)
language plpgsql as $$ begin
    update employee
    set department_id = ( select department_id from department where name =  p_dep_name )
    where job_id = ( select job_id from job where title = p_job_title );
end $$;

begin;
    call set_department_fk_by_job('Accounting', 'Public Accountant');
    call set_department_fk_by_job('Accounting', 'Accounting Manager');

    call set_department_fk_by_job('Administration', 'Assistant');

    call set_department_fk_by_job('Executive', 'President');
    call set_department_fk_by_job('Executive', 'Vice President');

    call set_department_fk_by_job('Finance', 'Finance Manager');
    call set_department_fk_by_job('Finance', 'Accountant');

    call set_department_fk_by_job('Human Resources', 'Human Resources Representative');

    call set_department_fk_by_job('IT', 'Programmer');

    call set_department_fk_by_job('Marketing', 'Marketing Manager');
    call set_department_fk_by_job('Marketing', 'Marketing Representative');

    call set_department_fk_by_job('Public Relations', 'Public Relations Representative');

    call set_department_fk_by_job('Purchasing', 'Purchasing Manager');
    call set_department_fk_by_job('Purchasing', 'Purchasing Clerk');

    call set_department_fk_by_job('Sales', 'Sales Manager');
    call set_department_fk_by_job('Sales', 'Sales Representative');
    -- force Kim out of department
    update employee set department_id = null where first_name = 'Kimberely';
    
    call set_department_fk_by_job('Shipping', 'Shipping Clerk');
    call set_department_fk_by_job('Shipping', 'Stock Clerk');
    call set_department_fk_by_job('Shipping', 'Stock Manager');
commit;

-- set the manager FK (self)
create or replace procedure set_manager_fk_by_job(
    p_mgr_fname in employee.first_name%type,
    p_mgr_lname in employee.last_name%type,
    p_job_title in job.title%type)
language plpgsql as $$ begin
    update employee
    set manager_id = (
        select employee_id
        from employee
        where first_name =  p_mgr_fname and last_name = p_mgr_lname )
    where job_id = ( select job_id from job where title = p_job_title );
end $$;

create or replace procedure set_manager_fk_by_name(
    p_mgr_fname in employee.first_name%type,
    p_mgr_lname in employee.last_name%type,
    p_fname in employee.first_name%type,
    p_lname in employee.last_name%type)
language plpgsql as $$ begin
    update employee
    set manager_id = (
        select employee_id
        from employee
        where first_name =  p_mgr_fname and last_name = p_mgr_lname )
    where first_name = p_fname and last_name = p_lname;
end $$;

begin;
    call set_manager_fk_by_job('Steven', 'King', 'Vice President');
    call set_manager_fk_by_job('Steven', 'King', 'Purchasing Manager');
    call set_manager_fk_by_job('Steven', 'King', 'Stock Manager');
    call set_manager_fk_by_job('Steven', 'King', 'Sales Manager');
    call set_manager_fk_by_job('Steven', 'King', 'Marketing Manager');

    call set_manager_fk_by_name('Neena', 'Kochhar', 'Nancy', 'Greenberg');
    call set_manager_fk_by_name('Neena', 'Kochhar', 'Shelley', 'Higgins');
    call set_manager_fk_by_name('Neena', 'Kochhar', 'Jennifer', 'Whalen');
    call set_manager_fk_by_name('Neena', 'Kochhar', 'Susan', 'Mavris');
    call set_manager_fk_by_name('Neena', 'Kochhar', 'Hermann', 'Baer');

    call set_manager_fk_by_job('Alexander', 'Hunold', 'Programmer');
    call set_manager_fk_by_name('Lex', 'De Haan', 'Alexander', 'Hunold');

    call set_manager_fk_by_job('Nancy', 'Greenberg', 'Accountant');
    call set_manager_fk_by_job('Shelley', 'Higgins', 'Public Accountant');
    call set_manager_fk_by_job('Michael', 'Hartstein', 'Marketing Representative');    
    call set_manager_fk_by_job('Den', 'Raphaely', 'Purchasing Clerk');

    call set_manager_fk_by_name('Matthew', 'Weiss', 'Julia', 'Nayer');
    call set_manager_fk_by_name('Matthew', 'Weiss', 'Irene', 'Mikkilineni');
    call set_manager_fk_by_name('Matthew', 'Weiss', 'James', 'Landry');
    call set_manager_fk_by_name('Matthew', 'Weiss', 'Steven', 'Markle');
    call set_manager_fk_by_name('Matthew', 'Weiss', 'Winston', 'Taylor');
    call set_manager_fk_by_name('Matthew', 'Weiss', 'Jean', 'Fleaur');
    call set_manager_fk_by_name('Matthew', 'Weiss', 'Martha', 'Sullivan');
    call set_manager_fk_by_name('Matthew', 'Weiss', 'Girard', 'Geoni');

    call set_manager_fk_by_name('Adam', 'Fripp', 'Laura', 'Bissot');
    call set_manager_fk_by_name('Adam', 'Fripp', 'Mozhe', 'Atkinson');
    call set_manager_fk_by_name('Adam', 'Fripp', 'James', 'Marlow');
    call set_manager_fk_by_name('Adam', 'Fripp', 'TJ', 'Olson');
    call set_manager_fk_by_name('Adam', 'Fripp', 'Nandita', 'Sarchand');
    call set_manager_fk_by_name('Adam', 'Fripp', 'Alexis', 'Bull');
    call set_manager_fk_by_name('Adam', 'Fripp', 'Juliet', 'Dullinger');
    call set_manager_fk_by_name('Adam', 'Fripp', 'Anthony', 'Cabrio');

    call set_manager_fk_by_name('Payam', 'Kaufling', 'Jason', 'Mallin');
    call set_manager_fk_by_name('Payam', 'Kaufling', 'Michael', 'Rogers');
    call set_manager_fk_by_name('Payam', 'Kaufling', 'Ki', 'Gee');
    call set_manager_fk_by_name('Payam', 'Kaufling', 'Hazel', 'Philtanker');
    call set_manager_fk_by_name('Payam', 'Kaufling', 'Kelly', 'Chung');
    call set_manager_fk_by_name('Payam', 'Kaufling', 'Jennifer', 'Dilly');
    call set_manager_fk_by_name('Payam', 'Kaufling', 'Tim', 'Gates');
    call set_manager_fk_by_name('Payam', 'Kaufling', 'Randall', 'Perkins');

    call set_manager_fk_by_name('Shanta', 'Vollman', 'Renske', 'Ladwig');
    call set_manager_fk_by_name('Shanta', 'Vollman', 'Stephen', 'Stiles');
    call set_manager_fk_by_name('Shanta', 'Vollman', 'John', 'Scantamburlo');
    call set_manager_fk_by_name('Shanta', 'Vollman', 'Joshua', 'Patel');
    call set_manager_fk_by_name('Shanta', 'Vollman', 'Sarah', 'Bell');
    call set_manager_fk_by_name('Shanta', 'Vollman', 'Britney', 'Everett');
    call set_manager_fk_by_name('Shanta', 'Vollman', 'Samuel', 'McCain');
    call set_manager_fk_by_name('Shanta', 'Vollman', 'Vance', 'Jones');

    call set_manager_fk_by_name('Kevin', 'Mourgos', 'Trenna', 'Rajs');
    call set_manager_fk_by_name('Kevin', 'Mourgos', 'Curtis', 'Davies');
    call set_manager_fk_by_name('Kevin', 'Mourgos', 'Randall', 'Matos');
    call set_manager_fk_by_name('Kevin', 'Mourgos', 'Peter', 'Vargas');
    call set_manager_fk_by_name('Kevin', 'Mourgos', 'Alana', 'Walsh');
    call set_manager_fk_by_name('Kevin', 'Mourgos', 'Kevin', 'Feeney');
    call set_manager_fk_by_name('Kevin', 'Mourgos', 'Donald', 'OConnell');
    call set_manager_fk_by_name('Kevin', 'Mourgos', 'Douglas', 'Grant');

    call set_manager_fk_by_name('John', 'Russell', 'Peter', 'Tucker');
    call set_manager_fk_by_name('John', 'Russell', 'David', 'Bernstein');
    call set_manager_fk_by_name('John', 'Russell', 'Peter', 'Hall');
    call set_manager_fk_by_name('John', 'Russell', 'Christopher', 'Olsen');
    call set_manager_fk_by_name('John', 'Russell', 'Nanette', 'Cambrault');
    call set_manager_fk_by_name('John', 'Russell', 'Oliver', 'Tuvault');

    call set_manager_fk_by_name('Karen', 'Partners', 'Jane', 'King');
    call set_manager_fk_by_name('Karen', 'Partners', 'Patrick', 'Sully');
    call set_manager_fk_by_name('Karen', 'Partners', 'Allan', 'McEwen');
    call set_manager_fk_by_name('Karen', 'Partners', 'Lindsey', 'Smith');
    call set_manager_fk_by_name('Karen', 'Partners', 'Louise', 'Doran');
    call set_manager_fk_by_name('Karen', 'Partners', 'Sarath', 'Sewall');

    call set_manager_fk_by_name('Alberto', 'Errazuriz', 'Clara', 'Vishney');
    call set_manager_fk_by_name('Alberto', 'Errazuriz', 'Danielle', 'Greene');
    call set_manager_fk_by_name('Alberto', 'Errazuriz', 'Mattea', 'Marvins');
    call set_manager_fk_by_name('Alberto', 'Errazuriz', 'David', 'Lee');
    call set_manager_fk_by_name('Alberto', 'Errazuriz', 'Sundar', 'Ande');
    call set_manager_fk_by_name('Alberto', 'Errazuriz', 'Amit', 'Banda');

    call set_manager_fk_by_name('Gerald', 'Cambrault', 'Lisa', 'Ozer');
    call set_manager_fk_by_name('Gerald', 'Cambrault', 'Harrison', 'Bloom');
    call set_manager_fk_by_name('Gerald', 'Cambrault', 'Tayler', 'Fox');
    call set_manager_fk_by_name('Gerald', 'Cambrault', 'William', 'Smith');
    call set_manager_fk_by_name('Gerald', 'Cambrault', 'Elizabeth', 'Bates');
    call set_manager_fk_by_name('Gerald', 'Cambrault', 'Sundita', 'Kumar');

    call set_manager_fk_by_name('Eleni', 'Zlotkey', 'Ellen', 'Abel');
    call set_manager_fk_by_name('Eleni', 'Zlotkey', 'Alyssa', 'Hutton');
    call set_manager_fk_by_name('Eleni', 'Zlotkey', 'Jonathon', 'Taylor');
    call set_manager_fk_by_name('Eleni', 'Zlotkey', 'Jack', 'Livingston');
    call set_manager_fk_by_name('Eleni', 'Zlotkey', 'Kimberely', 'Grant');
    call set_manager_fk_by_name('Eleni', 'Zlotkey', 'Charles', 'Johnson');
commit;    

-- set manager FK on department table
create or replace procedure set_department_manager(
    p_mgr_fname in employee.first_name%type,
    p_mgr_lname in employee.last_name%type,
    p_dep_name in department.name%type)
language plpgsql as $$ begin
    update department
    set manager_id = (
        select employee_id
        from employee
        where first_name =  p_mgr_fname and last_name = p_mgr_lname )
    where name = p_dep_name;
end $$;

begin;
    call set_department_manager('Jennifer', 'Whalen', 'Administration');
    call set_department_manager('Michael', 'Hartstein', 'Marketing');
    call set_department_manager('Den', 'Raphaely', 'Purchasing');
    call set_department_manager('Susan', 'Mavris', 'Human Resources');
    call set_department_manager('Adam', 'Fripp', 'Shipping');
    call set_department_manager('Alexander', 'Hunold', 'IT');
    call set_department_manager('Hermann', 'Baer', 'Public Relations');
    call set_department_manager('John', 'Russell', 'Sales');
    call set_department_manager('Steven', 'King', 'Executive');
    call set_department_manager('Nancy', 'Greenberg', 'Finance');
    call set_department_manager('Shelley', 'Higgins', 'Accounting');
commit;

-- simple table in many-to-many releation with employee
create table team(
    team_id serial primary key,
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
    constraint team_employee_team_fk foreign key (team_id) references team (team_id),
    constraint team_employee_employee_fk foreign key (employee_id) references employee (employee_id)
);

begin;
    insert into team_employee (team_id, employee_id) values
        (1, 103), (1, 107), (1, 111), (1, 118), (1, 123), (1, 125), (1, 133), (1, 153),
        (2, 105), (2, 107), (2, 121), (2, 122), (2, 123), (2, 128), (2, 135), (2, 156),
        (3, 104), (3, 109), (3, 111), (3, 120), (3, 123), (3, 127), (3, 139), (3, 156);
commit;


-- "one" car for one employee, "many" cars seviced by many services
create table car(
    car_id integer primary key,
    name varchar(40) unique,
    employee_id integer unique,

    constraint car_employee_fk foreign key (employee_id) references employee (employee_id)
);

create sequence car_seq;

create or replace procedure insert_car(
    p_car_name in car.name%type,
    p_first_name in employee.first_name%type,
    p_last_name in employee.last_name%type)
language plpgsql as $$ declare 
    v_employee_id int;
begin
    select employee_id into v_employee_id
    from employee
    where first_name = p_first_name and last_name = p_last_name;

    insert into car (car_id, name, employee_id) values
        (nextval('car_seq'), p_car_name, v_employee_id);
end $$;

begin;
    call insert_car('Silver Hornet', 'Jennifer', 'Whalen');
    call insert_car('White Phantom', 'Michael', 'Hartstein');
    call insert_car('Batmobile', 'Den', 'Raphaely');
    call insert_car('Starsky', 'Susan', 'Mavris');
    call insert_car('Smurf', 'Adam', 'Fripp');
    call insert_car('Fireball', 'Alexander', 'Hunold');
    call insert_car('Poison', 'Neena', 'Kochhar');
    call insert_car('Katana', 'Lex', 'De Haan');
    call insert_car('Titanic', 'Hermann', 'Baer');
    call insert_car('Dracula', 'John', 'Russell');
    call insert_car('Zeppelin', 'Steven', 'King');
    call insert_car('Ruby', 'Nancy', 'Greenberg');
    call insert_car('Tortoise', 'Shelley', 'Higgins');
commit;

create or replace function get_salary(
    p_employee_id in employee.employee_id%type)
returns employee.salary%type
language plpgsql as $$ declare
    v_salary employee.salary%type;
begin
    select salary
    into v_salary
    from employee
    where employee_id = p_employee_id;

    return v_salary;
end $$;

-- "many" services taking cares of many cars, many services could share one location
create table service(
    service_id serial primary key,
    name varchar(40),
    location_id integer,

    constraint service_location_fk foreign key (location_id) references location (location_id)
);

begin;
    insert into service (name, location_id) values ('Inspired Glass', 1000);
    insert into service (name, location_id) values ('Faith Auto Repair', 1000);
    insert into service (name, location_id) values ('Happy Brake', 2300);
commit;

-- many to many with details
create table car_service(
    car_id integer,
    service_id integer,
    checkin timestamp,
    checkout timestamp,

    constraint car_service_time_ck check (checkin < checkout),
    primary key (car_id, service_id, checkin),
    constraint car_service_car_fk foreign key (car_id) references car (car_id),
    constraint car_service_service_fk foreign key (service_id) references service (service_id)
);

begin;
    insert into car_service (car_id, service_id, checkin, checkout) values
        (1, 1, '2021-08-01 15:00:00', '2021-08-01 16:00:00');
    insert into car_service (car_id, service_id, checkin, checkout) values
        (5, 2, '2021-08-03 14:00:00', '2021-08-03 19:00:00');
    insert into car_service (car_id, service_id, checkin, checkout) values
        (1, 2, '2021-08-04 08:00:00', '2021-08-04 20:00:00');
    insert into car_service (car_id, service_id, checkin, checkout) values
        (1, 3, '2021-10-12 15:00:00', '2021-10-12 18:00:00');
commit;
