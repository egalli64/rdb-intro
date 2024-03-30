/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1581. Customer Who Visited but Did Not Make Any Transactions - https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/
 */

-- set up for testing on the leet schema
create table visits (
	visit_id int primary key,
	customer_id int
);

insert into visits (visit_id, customer_id) values
	(1, 23), (2, 9), (4, 30), (5, 54), (6, 96), (7, 54), (8, 54);


create table transactions (
	transaction_id int primary key,
	visit_id int,
	amount int,
	
	foreign key (visit_id) references visits(visit_id)
);

insert into transactions (transaction_id, visit_id, amount) values
	(2, 5, 310), (3, 5, 300), (9, 5, 200), (12, 1, 910), (13, 2, 970);

-- IDs of users who visited without making any transactions and the number of times of these visits
select customer_id, count(visit_id) as count_no_trans
from visits
where visit_id not in (
    select visit_id from transactions)
group by customer_id;

-- cleanup of the leet schema
drop table transactions;
drop table visits;
