/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1757. Recyclable and Low Fat Products - https://leetcode.com/problems/recyclable-and-low-fat-products/description/
 */

-- set up for testing on the leet schema
create type yn as enum('Y', 'N');

create table products (
	product_id int primary key,
	low_fats yn,
	recyclable yn
);

insert into products (product_id, low_fats, recyclable) values
	(0, 'Y', 'N'), (1, 'Y', 'Y'), (2, 'N', 'Y'), (3, 'Y', 'Y'), (4, 'N', 'N');

-- Find the ids of products that are both low fat and recyclable
select product_id
from products
where low_fats = 'Y' and recyclable = 'Y';

-- cleanup of the leet schema
drop table products;
drop type yn;
