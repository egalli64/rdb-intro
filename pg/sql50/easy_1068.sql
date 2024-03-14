/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1068. Product Sales Analysis I - https://leetcode.com/problems/product-sales-analysis-i/description/
 *
 * Table: Sales
 * +-------------+-------+
 * | Column Name | Type  |
 * +-------------+-------+
 * | sale_id     | int   |
 * | product_id  | int   |
 * | year        | int   |
 * | quantity    | int   |
 * | price       | int   |
 * +-------------+-------+
 * 
 * Table: Product
 * +--------------+---------+
 * | Column Name  | Type    |
 * +--------------+---------+
 * | product_id   | int     |
 * | product_name | varchar |
 * +--------------+---------+
 *
 * Find the product_name, year, and price for each sale_id in the Sales table
 */
select p.product_name, s.year, s.price
from sales s join product p using(product_id)
