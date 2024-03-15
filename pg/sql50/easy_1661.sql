/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1661. Average Time of Process per Machine - https://leetcode.com/problems/average-time-of-process-per-machine/description/
 *
 * Table: Activity
 * +----------------+---------+
 * | Column Name    | Type    |
 * +----------------+---------+
 * | machine_id     | int     |
 * | process_id     | int     |
 * | activity_type  | enum    |
 * | timestamp      | float   |
 * +----------------+---------+
 *
 * Find the average time each machine takes to complete a process
 */
select s.machine_id, round(avg(e.timestamp - s.timestamp)::numeric, 3) as processing_time
from activity s cross join activity e
where s.machine_id = e.machine_id and s.activity_type = 'start' and e.activity_type = 'end'
group by s.machine_id;
