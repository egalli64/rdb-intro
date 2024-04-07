/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1661. Average Time of Process per Machine - https://leetcode.com/problems/average-time-of-process-per-machine/description/
 */

-- set up for testing on the leet schema
create type status as enum('start', 'end');

create table activity (
	machine_id int,
	process_id int,
	activity_type status,
	timestamp float
);

insert into activity (machine_id, process_id, activity_type, timestamp) values
	(0, 0, 'start', 0.712), (0, 0, 'end', 1.52), (0, 1, 'start', 3.14), (0, 1, 'end', 4.12),
	(1, 0, 'start', 0.55), (1, 0, 'end', 1.55), (1, 1, 'start', 0.43), (1, 1, 'end', 1.42),
	(2, 0, 'start', 4.1), (2, 0, 'end', 4.512), (2, 1, 'start', 2.5), (2, 1, 'end', 5);

-- find the average time each machine takes to complete a process
select s.machine_id, round(avg(e.timestamp - s.timestamp)::numeric, 3) as processing_time
from activity s cross join activity e
where s.machine_id = e.machine_id and s.activity_type = 'start' and e.activity_type = 'end'
group by s.machine_id;

-- cleanup of the leet schema
drop table activity;
drop type status;
