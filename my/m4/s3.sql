/*
    Introduction to SQL (on MySQL)
    
    https://github.com/egalli64/hron

    Examples on group by
 */
use hron;

-- group the employees by department id, count them
select department_id, count(*) as 'nr'
from employee
group by department_id
order by nr desc;

-- group the employees by department id and job id, count them
select department_id, job_id, count(*) as 'nr'
from employee
group by department_id, job_id;

-- ...
select round(avg(salary)) as avg_sal, round(max(salary)) as max_sal, department_id 
from employee
group by department_id
order by avg_sal desc;

-- ...
select first_name, round(avg(salary)) as sal, max(salary), department_id 
from employee
group by department_id
order by sal desc;

-- grouping by department and then by job
select round(avg(salary)) sal, department_id, job_id
from employee
group by department_id, job_id
order by sal desc;

select round(avg(salary)) sal, department_id
from employee
group by department_id
order by sal desc;

-- with a join the result set becomes more interesting
select round(avg(salary)) sal, d.name as Department, j.title as 'Job Title'
from department d right outer join employee e using (department_id)
	join job j using (job_id)
group by department_id, job_id;

-- average salary for all the employees
select round(avg(salary), 2) as 'avg salary'
from employee;

-- average salary for each department
select department_id, round(avg(salary)) as 'avg salary'
from employee
group by department_id
order by 'avg salary' desc;

-- average salary for each department, only for most junior employees
select d.location_id, d.name, round(avg(e.salary)) as avg  
from employee e left outer join department d using (department_id)
where e.hired > '2019-12-31'
group by e.department_id -- d.name
order by avg desc;
