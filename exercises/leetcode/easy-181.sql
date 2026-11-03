-- 181. Employees Earning More Than Their Managers https://leetcode.com/problems/employees-earning-more-than-their-managers/

select e.name as "Employee"
from Employee e join Employee m
on e.managerId = m.id
where e.salary > m.salary;