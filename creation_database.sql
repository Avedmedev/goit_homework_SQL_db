drop table if exists grades;
create table grades (
id integer primary key autoincrement,
discipline_id integer,
student_id integer,
date_of DATE not null,
grade integer not null,
FOREIGN KEY (discipline_id) REFERENCES disciplines (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
FOREIGN KEY (student_id) REFERENCES students (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

drop table if exists discipline;
drop table if exists disciplines;
create table disciplines (
id integer primary key autoincrement,
teacher_id integer,
name varchar(100) unique not null,
FOREIGN KEY (teacher_id) REFERENCES teachers (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

drop table if exists teachers;
create table teachers (
id integer primary key autoincrement,
fullname varchar(100) not null
);

drop table if exists students;
create table students (
id integer primary key autoincrement,
fullname varchar(100) not null,
group_id integer,
FOREIGN KEY (group_id) REFERENCES [groups] (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

drop table if exists [groups];
create table [groups] (
id integer primary key autoincrement,
name varchar(100) unique not null
);
