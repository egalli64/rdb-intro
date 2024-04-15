/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 550. Game Play Analysis IV - https://leetcode.com/problems/game-play-analysis-iv/description/
 */

-- set up for testing on the leet schema
create table activity (
	player_id int,
	device_id int,
	event_date date,
	games_played int,
	
	primary key(player_id, event_date)
);

insert into activity (player_id, device_id, event_date, games_played) values
	(1, 2, '2016-03-01', 5), (1, 2, '2016-03-02', 6), (2, 3, '2017-06-25', 1),
	(3, 1, '2016-03-02', 0), (3, 4, '2018-07-03', 5);

-- count the players that logged in for at least two consecutive days starting from their first login date
-- then divide that number by the total number of players
select round(count(a2.player_id)::numeric / count(a1.player_id), 2) AS fraction
from activity a1 left outer join activity a2
	on a2.player_id = a1.player_id and a2.event_date = a1.event_date + 1
where (a1.player_id, a1.event_date) IN (
	select player_id, min(event_date)
	from activity
	group by player_id
);

-- cleanup of the leet schema
drop table activity;
