--     5 студентов с наибольшим средним баллом по всем предметам.
select s.fullname as Student, AVG(grades.grade) as Average
from grades
left join students s on grades.student_id = s.id
group by grades.student_id
order by Average DESC
LIMIT 5

--    1 студент с наивысшим средним баллом по одному предмету.
select s.fullname as Student, AVG(grades.grade) as Average
from grades
left join students s on grades.student_id = s.id
group by grades.student_id, grades.discipline_id
order by Average DESC
LIMIT 1

--    средний балл в группе по одному предмету.
select g.name as [Group], d.name as Subject, AVG(grades.grade) as Average
from grades
left join students s on grades.student_id = s.id
left join groups g on s.group_id = g.id
left join disciplines d on d.id = grades.discipline_id
group by s.group_id, grades.discipline_id
order by g.name , d.name

--    Средний балл в потоке.
select g.name as [Group], AVG(grades.grade) as Average
from grades
left join students s on grades.student_id = s.id
left join groups g on s.group_id = g.id
group by s.group_id
order by g.name

--    Какие курсы читает преподаватель.
SELECT d.name as Subject , t.fullname as Teacher
from disciplines d
left join teachers t on t.id = d.teacher_id

--    Список студентов в группе.
SELECT g.name as [Group], s.fullname as Student
from students s
left join groups g on g.id = s.group_id
order by g.name

--    Оценки студентов в группе по предмету.
SELECT g.name as [Group], s.fullname as Student, d.name as Subject, g2.grade as Mark
from students s
left join groups g on g.id = s.group_id
LEFT join grades g2 on g2.student_id = s.id
LEFT JOIN disciplines d on d.id = g2.discipline_id
order by g.name, s.fullname

--    Оценки студентов в группе по предмету на последнем занятии.
SELECT g.name as [Group], s.fullname as Student, d.name as Subject, g2.grade as Last_mark
from students s
left join groups g on g.id = s.group_id
LEFT join grades g2 on g2.student_id = s.id
LEFT JOIN disciplines d on d.id = g2.discipline_id
group by s.fullname, d.name
HAVING max(g2.date_of)
order by g.name, s.fullname

--    Список курсов, которые посещает студент.
SELECT s.fullname as Student, d.name as Subject
from grades g
left join students s on s.id = g.student_id
left join disciplines d on g.discipline_id = d.id
GROUP by d.name, s.fullname
having count(*) > 0
ORDER by s.fullname

--    Список курсов, которые студенту читает преподаватель.
SELECT t.fullname as Teacher, s.fullname as Student, d.name as Subject
from grades g
left join disciplines d on d.id = g.discipline_id
left join teachers t on t.id = d.teacher_id
left join students s on s.id = g.student_id
GROUP by s.fullname, t.fullname, d.name
having count(*) > 0
ORDER by t.fullname

--    Средний балл, который преподаватель ставит студенту.
SELECT t.fullname as Teacher, s.fullname as Student, AVG(g.grade) as average
from grades g
left join disciplines d on d.id = g.discipline_id
left join teachers t on t.id = d.teacher_id
left join students s on s.id = g.student_id
GROUP by s.fullname, t.fullname
ORDER by t.fullname

--    Средний балл, который ставит преподаватель.
SELECT t.fullname as Teacher, AVG(g.grade) as average
from grades g
left join disciplines d on d.id = g.discipline_id
left join teachers t on t.id = d.teacher_id
left join students s on s.id = g.student_id
GROUP by t.fullname
ORDER by t.fullname
