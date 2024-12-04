/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on group by - having
 */
use hron;

-- group by department and job, but keep only the departments having name ending in 'ing'
select d.name as Department, j.title as 'Job Title'
from department d
join employee e using (department_id)
join job j using (job_id)
group by e.department_id, job_id
having d.name like '%ing';

-- without the join the select would be unreadable
select e.department_id as Department, e.job_id as 'Job Title'
from employee e
group by department_id, job_id;

-- get employees with a salary less than 8000
-- group them by manager id
-- keep the groups with an average salary above 6000
-- and order the result by the the second column, descending
select concat(m.first_name, ' ', m.last_name) as Manager, round(avg(e.salary), 2) as 'Average salary', count(*)
from employee e
join employee m on e.manager_id = m.employee_id
where e.salary < 8000
group by e.manager_id
having avg(e.salary) > 6000
order by 2 desc;

-- average salary for department, excluding "null" department and low average ones
select d.name, truncate(avg(e.salary), 0) as average
from employee e
left outer join department d using(department_id)
-- where department_id is not null
group by department_id
having average > 4000
-- having round(avg(salary)) > 6000
order by average desc;

-- self join + group by
select concat(m.first_name, ' ', m.last_name) as Manager, round(avg(e.salary)) as "Avg salary"
from employee e
join employee m on e.manager_id = m.employee_id 
where e.salary < 8000
group by e.manager_id
having avg(e.salary) > 6000
order by 2 desc;
