/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1251. Average Selling Price - https://leetcode.com/problems/average-selling-price/description/
 */

-- set up for testing on the leet schema
create table prices (
	product_id int,
	start_date date,
	end_date date,
	price numeric(10, 2),
	primary key(product_id, start_date, end_date)
);

insert into prices (product_id, start_date, end_date, price) values (1, '2019-02-17', '2019-02-28', 5),
	(1, '2019-03-01', '2019-03-22', 20), (2, '2019-02-01', '2019-02-20', 15), (2, '2019-02-21', '2019-03-31', 30),
	(3, '2019-02-21', '2019-03-31', 30); -- added for no-sold test

create table unitsSold (
	product_id int,
	purchase_date date,
	units int,
	primary key(product_id, purchase_date)
);

insert into unitsSold (product_id, purchase_date, units) values (1, '2019-02-25', 100),
	(1, '2019-03-01', 15), (2, '2019-02-10', 200), (2, '2019-03-22', 30);

--  find the average selling price for each product, rounded to 2 decimal places
select p.product_id, coalesce(round(sum(p.price * u.units::decimal)/ sum(u.units), 2), 0) as average_price
from prices p left outer join unitsSold u
	on p.product_id = u.product_id and u.purchase_date between p.start_date and p.end_date
group by p.product_id;

-- cleanup of the leet schema
drop table unitsSold;
drop table prices;
