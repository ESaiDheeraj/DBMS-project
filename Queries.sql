use academic_insti;
-- using academic_insti database given in moodle ---
-- Most Popular Course in an year (2004) ---
-- 1st Query ---
SELECT courseId, count(courseId) as 'No of students registered'
FROM enrollment 
where year = '2004'
group by courseId 
order by count(courseId) desc
;
-- sum of total credits( according to data in this database ) taught by professors whose startYear is in between 1990 and 2000 ----
-- 2nd Query ---
select p.name, p.startYear, sum(c.credits) as 'Total credits taught'
from professor p
join teaching t
	on p.empId = t.empId
join course c
	on t.courseId = c.courseId
where p.startYear >= 1990 and p.startYear <= 2000 
group by p.empId
;
-- Number of U grades given by each of the professors according to data present in database --------
-- 3rd Query ---
select p.name, count(e.grade) as 'No of U grades given'
from professor p
join teaching t
	on p.empId = t.empId
join enrollment e
	on t.courseId = e.courseId and t.sem = e.sem and t.year = e.year and e.grade = 'U'
group by p.empId
order by count(e.grade) desc
;
-- ----------------------------------------------------- 
-- Number of courses taken by a student under his/her faculty advisor -----
-- 4th Query ---
select s.rollNo, count(e.courseId) as 'No of courses taken under Advisor'
from student s
join teaching t 
	on t.empId = s.advisor
join enrollment e
	on t.courseId = e.courseId and e.rollNo = s.rollNo
group by s.rollNo
order by count(e.courseId) desc
;
-- -----------------------------------------------------
-- 5th Query ---
-- All department HODs and phone Numbers ---------
select deptId , phone
from department
order by deptId
;
-- -----------
-- The list of courses having more than 1 prerequisite and Number of prerequisites for it ---------------
-- 6th Query ---
select c.courseId, c.cname, count(*) as 'No of PreReqCourses'
from prerequisite p
join course c on c.courseId = p.courseId
where c.courseId is not null and p.preReqCourse is not null
group by c.courseId
having count(*) > 1
order by count(*) desc
;
-- ---------------------------------------
-- No of courses offered by each department -----------
-- 7th Query ---
select d.name, count(*) as 'No of courses offered'
from course c
join department d
	on c.deptNo = d.deptId
group by c.deptNo
order by d.name
;
-- Name of the professor and No of students he advised -------
-- 8th Query ---
select p.name, d.name, count(*) as 'No of Students'
from student s
join professor p
	on s.advisor = p.empId
join department d
	on p.deptNo = d.deptId
group by s.advisor
order by d.name, count(*)
;