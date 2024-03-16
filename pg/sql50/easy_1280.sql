/*
 * LeetCode SQL 50 - https://leetcode.com/studyplan/top-sql-50/
 * 1280. Students and Examinations - https://leetcode.com/problems/students-and-examinations/description/
 * 
 * Find the number of times _each_ student attended _each_ exam
 */

-- set up for testing on the leet schema
create table students (
	student_id int primary key, 
	student_name varchar(20)
);

insert into students values ('1', 'Alice'), ('2', 'Bob'), ('13', 'John'), ('6', 'Alex');

create table subjects (
	subject_name varchar(20) primary key
);

insert into subjects values ('Math'), ('Physics'), ('Programming');

-- no PK on this table!
create table examinations (
	student_id int,
	subject_name varchar(20),
	
	foreign key (student_id) references students(student_id),
	foreign key (subject_name) references subjects(subject_name)
);

insert into examinations values ('1', 'Math'), ('1', 'Physics'), ('1', 'Programming'),
	('2', 'Programming'), ('1', 'Physics'), ('1', 'Math'), ('13', 'Math'),
	('13', 'Programming'), ('13', 'Physics'), ('2', 'Math'), ('1', 'Math');

-- the actual exercise
select s.student_id, s.student_name, u.subject_name, count(e.subject_name) as attended_exams
from students s cross join subjects u 
	left join examinations e ON s.student_id = s.student_id and u.subject_name = e.subject_name  
group by s.student_id, s.student_name, u.subject_name
order by s.student_id, u.subject_name;

-- cleanup of the leet schema
drop table examinations;
drop table subjects;
drop table students;
