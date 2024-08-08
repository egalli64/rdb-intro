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

select *
from interview
where person_id = 14887

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
