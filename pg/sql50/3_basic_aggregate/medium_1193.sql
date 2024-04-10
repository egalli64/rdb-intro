/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1193. Monthly Transactions I - https://leetcode.com/problems/monthly-transactions-i/description/
 */

-- set up for testing on the leet schema
create type status as enum('approved', 'declined');

create table transactions (
	id int primary key,
	country varchar(4),
	state status,
	amount int,
	trans_date date
);

insert into transactions (id, country, state, amount, trans_date) values
	(121, 'US', 'approved', 1000, '2018-12-18'), (122, 'US', 'declined', 2000, '2018-12-19'),
	(123, 'US', 'approved', 2000, '2019-01-01'), (124, 'DE', 'approved', 2000, '2019-01-07');

-- find, for each "month" (ex: "2018-12") and "country": 
-- the number of transactions, as "trans_count"
-- the number of approved transactions, as "approved_count" 
-- their total amount, as "trans_total_amount"  
-- and their total amount, as "approved_total_amount"
-- Write your PostgreSQL query statement below
select to_char(trans_date, 'YYYY-MM') as month, country, count(id) as trans_count,
	sum(case when state = 'approved' then 1 else 0 end) as approved_count,
	sum(amount) as trans_total_amount, 
	sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from transactions
group by month, country;

-- cleanup of the leet schema
drop table transactions;
drop type status;
