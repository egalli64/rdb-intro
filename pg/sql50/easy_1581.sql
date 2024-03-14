/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1581. Customer Who Visited but Did Not Make Any Transactions
 *  https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/
 *
 * Table: Visits
 * +-------------+---------+
 * | Column Name | Type    |
 * +-------------+---------+
 * | visit_id    | int     |
 * | customer_id | int     |
 * +-------------+---------+
 *
 * Table: Transactions
 * +----------------+---------+
 * | Column Name    | Type    |
 * +----------------+---------+
 * | transaction_id | int     |
 * | visit_id       | int     |
 * | amount         | int     |
 * +----------------+---------+
 * 
 * Find the IDs of the users who visited without making any transactions and the number of times of these visits
 */
select customer_id, count(visit_id) as count_no_trans
from visits
where visit_id not in (
    select visit_id from transactions)
group by customer_id;
