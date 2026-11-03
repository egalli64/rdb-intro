-- 175. Combine Two Tables https://leetcode.com/problems/combine-two-tables/

select p.firstName, p.lastName, a.city, a.state
from Person p left join Address a
using (personId);
