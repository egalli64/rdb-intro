/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1174. Immediate Food Delivery II - https://leetcode.com/problems/immediate-food-delivery-ii/description/
 */

-- set up for testing on the leet schema
create table delivery (
	delivery_id serial primary key, 
	customer_id int, 
	order_date date, 
	customer_pref_delivery_date date
);

insert into delivery (customer_id, order_date, customer_pref_delivery_date) values
	(1, '2019-08-01', '2019-08-02'), (2, '2019-08-02', '2019-08-02'),
	(1, '2019-08-11', '2019-08-12'), (3, '2019-08-24', '2019-08-24'),
	(3, '2019-08-21', '2019-08-22'), (2, '2019-08-11', '2019-08-13'),
	(4, '2019-08-09', '2019-08-09');

-- find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places
-- an order is immediate if the preferred delivery date is the same as the order date
-- it is guaranteed that a customer has precisely one first order

select round(avg(case when order_date = customer_pref_delivery_date THEN 100 ELSE 0 END), 2) AS immediate_percentage
from delivery
where (customer_id, order_date) in (
  select customer_id, min(order_date) 
  from delivery
  group by customer_id
);

-- cleanup of the leet schema
drop table delivery;
