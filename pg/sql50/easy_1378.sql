/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1378. Replace Employee ID With The Unique Identifier - https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/
 * 
 * Table: Employees
 * +---------------+---------+
 * | Column Name   | Type    |
 * +---------------+---------+
 * | id            | int     |
 * | name          | varchar |
 * +---------------+---------+
 *
 * Table: EmployeeUNI
 * +---------------+---------+
 * | Column Name   | Type    |
 * +---------------+---------+
 * | id            | int     |
 * | unique_id     | int     |
 * +---------------+---------+
 *  
 * Find the unique ID of each user, if a user does not have a unique ID just show null
 */
select u.unique_id, e.name
from employees e left outer join employeeUNI u
    using(id)
