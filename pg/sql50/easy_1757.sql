/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1757. Recyclable and Low Fat Products - https://leetcode.com/problems/recyclable-and-low-fat-products/description/
 * 
 * product_id is the primary key for this table
 * low_fats is an ENUM where 'Y' means this product is low fat and 'N' means it is not
 * recyclable is an ENUM where 'Y' means this product is recyclable and 'N' means it is not
 * 
 * find the ids of products that are both low fat and recyclable
 */
select product_id
from products
where low_fats = 'Y' and recyclable = 'Y';