/*
 * SQL Murder Mystery - https://mystery.knightlab.com/
 */

-- Helper 1: Get the table names
select name
from sqlite_master
where type = 'table'
order by name;
-- crime_scene_report, drivers_license, facebook_event_checkin, get_fit_now_check_in
-- get_fit_now_member, income, interview, person, solution

-- Helper 2: How to get a table structure
select sql
from sqlite_master
where name = 'crime_scene_report';
-- CREATE TABLE crime_scene_report ( date integer, type text, description text, city text )

-- Task 1:  the crime was a ​murder​, occurred on 2018 ​Jan 15, in SQL City
select description
from crime_scene_report
where crime = 'murder' and date = 20180115 and city = 'SQL City';
-- Security footage shows that there were 2 witnesses. 
-- The first witness lives at the last house on "Northwestern Dr".
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".

-- Task 2: info on witnesses
select sql
from sqlite_master
where name = 'person';
-- CREATE TABLE person (id integer PRIMARY KEY, name text, license_id integer,
-- address_number integer, address_street_name text,
-- ssn CHAR REFERENCES income (ssn),
-- FOREIGN KEY (license_id) REFERENCES drivers_license (id))

select sql
from sqlite_master
where name = 'interview';
-- CREATE TABLE interview ( person_id integer, transcript text, 
-- FOREIGN KEY (person_id) REFERENCES person(id) )

-- Task 2a: Witness 1 id
select id
from person
where address_street_name = 'Northwestern Dr'
order by address_number desc
limit 1;
-- 14887

-- Task 2b: Witness 2 id
select id
from person
where address_street_name = 'Franklin Ave' and name like 'Annabel %';
-- 16371

-- Task 3: Info from witnesses
select p.name, i.transcript
from person p join interview i
on p.id = i.person_id
where id in (14887, 16371);
-- Morty Schapiro
-- I heard a gunshot and then saw a man run out.
-- He had a "Get Fit Now Gym" bag.
-- The membership number on the bag started with "48Z".
-- Only gold members have those bags.
-- The man got into a car with a plate that included "H42W".
-- Annabel Miller
-- I saw the murder happen, and I recognized the killer from my gym
-- when I was working out last week on January the 9th.

-- Task 4: info on Get Fit Now members
select sql
from sqlite_master
where name = 'get_fit_now_member';
-- CREATE TABLE get_fit_now_member ( id text PRIMARY KEY, person_id integer, name text,
-- membership_start_date integer, membership_status text,
-- FOREIGN KEY (person_id) REFERENCES person(id) )

-- Task 4a: possible killers according to Shapiro
select name
from get_fit_now_member
where membership_status = 'gold' and id like '48Z%';
-- Joe Germuska
-- Jeremy Bowers

-- Task 4b: Annabel Miller id
select id
from get_fit_now_member
where name = 'Annabel Miller';
-- 90081

-- Task 5: info on check_in
select sql
from sqlite_master
where name = 'get_fit_now_check_in';
-- CREATE TABLE get_fit_now_check_in ( membership_id text, check_in_date integer,
-- check_in_time integer, check_out_time integer,
-- FOREIGN KEY (membership_id) REFERENCES get_fit_now_member(id) )

-- Task 5a: check in time for Annabel Miller in the stated day
select check_in_time, check_out_time
from get_fit_now_check_in ci join get_fit_now_member m 
on ci.membership_id = m.id
where ci.check_in_date = 20180109 and m.name = 'Annabel Miller'; 
-- 1600	1700

-- Task 5b: possible killers according to Miller
select m.name
from get_fit_now_check_in ci join get_fit_now_member m 
on ci.membership_id = m.id
where ci.check_in_date = 20180109
	and check_in_time <= 1700
	and check_out_time >= 1600
	and name != 'Annabel Miller';
-- Joe Germuska
-- Jeremy Bowers

-- Task 6: info on drivers_license
select sql
from sqlite_master
where name = 'drivers_license';
-- CREATE TABLE drivers_license ( id integer PRIMARY KEY, age integer, height integer,
-- eye_color text, hair_color text, gender text, plate_number text, car_make text, car_model text )

-- Task 6a: possible killers according to Shapiro
select p.name
from drivers_license dl join person p
on dl.id = p.license_id
where gender = 'male' and plate_number like '%H42W%';
-- Tushar Chandra
-- Jeremy Bowers

-- Task 7: combine the partial results
	select p.name
	from drivers_license dl join person p
	on dl.id = p.license_id
	where gender = 'male' and plate_number like '%H42W%'
intersect
	select m.name
	from get_fit_now_check_in ci join get_fit_now_member m 
	on ci.membership_id = m.id
	where ci.check_in_date = 20180109
		and check_in_time <= 1700
		and check_out_time >= 1600
		and name != 'Annabel Miller'
intersect
	select name
	from get_fit_now_member
	where membership_status = 'gold' and id like '48Z%';
-- Jeremy Bowers

INSERT INTO solution VALUES (1, 'Jeremy Bowers');


-- Task 8: extra - the brains behind the murder
select i.transcript
from interview i join person p
on on p.id = i.person_id
where name = 'Jeremy Bowers';
-- I was hired by a woman with a lot of money. 
-- I don't know her name but I know she's around 5'5" (65") or 5'7" (67").
-- She has red hair and she drives a Tesla Model S.
-- I know that she attended the SQL Symphony Concert 3 times in December 2017. 

	select p.name
	from facebook_event_checkin fb join person p
	on fb.person_id = p.id
	where fb.event_name like 'SQL Symphony Concert'
		and date like '201712%'
	group by fb.person_id
	having count(*) = 3
intersect
	select p.name
	from drivers_license dl join person p
	on p.license_id = dl.id
	where gender = 'female'
		and height between 65 and 67
		and hair_color = 'red'
		and car_make = 'Tesla' and car_model = 'Model S'
-- Miranda Priestly
