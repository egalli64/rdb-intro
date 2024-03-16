/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

    User and Schema LEET (re)creation

    DBA rights are required to run this script
        psql -U postgres \i once.sql
 */
drop schema if exists leet cascade;
drop user if exists leet;

create user leet with password 'password';
create schema leet authorization leet;
