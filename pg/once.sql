/*
    Introduction to SQL (on PostgreSQL)
    
    https://github.com/egalli64/hron

    User and Schema HRON (re)creation

    DBA rights are required to run this script
        psql -U postgres \i once.sql
 */

drop user if exists hron;

create user hron with password 'password';
create database hron owner hron;
