/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1068. Product Sales Analysis I - https://leetcode.com/problems/product-sales-analysis-i/description/
 */

-- set up for testing on the leet schema
create table product (
	product_id int primary key,
	product_name varchar(10)
);

insert into product (product_id, product_name) values (100, 'Nokia'), (200, 'Apple'), (300, 'Samsung');

create table sales (
	sale_id int,
	product_id int,
	year int,
	quantity int,
	price int,
	
	primary key(sale_id, year),
	foreign key(product_id) references product(product_id)
);

insert into sales (sale_id, product_id, year, quantity, price) values
	(1, 100, 2008, 10, 5000), (2, 100, 2009, 12, 5000), (7, 200, 2011, 15, 9000);

-- Find the product_name, year, and price for each sale_id in the Sales table
select p.product_name, s.year, s.price
from sales s join product p using(product_id);

-- cleanup of the leet schema
drop table sales;
drop table product;
