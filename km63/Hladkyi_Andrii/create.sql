create table "Assessments" 
(
   "student_id"         INTEGER              not null,
   "student_name"       VARCHAR2(20)         not null,
   "student_group"      VARCHAR2(6)          not null,
   "Discipline_name"    VARCHAR2(20)
);

ALTER TABLE Assessments ADD CONSTRAINT Assessments_key PRIMARY KEY (student_id);

create table "Discipline" 
(
   "Discipline_name"    VARCHAR2(20)         not null
);

ALTER TABLE Discipline ADD CONSTRAINT discipline_key PRIMARY KEY (Discipline_name);

create table "student_group" 
(
   "group_code"         VARCHAR2(6)          not null
);

ALTER TABLE student_group ADD CONSTRAINT Group_key PRIMARY KEY (groupe_code);

create table "Homework" 
(
   "homework_number"    NUMBER(3)            not null,
   "student_id"         INTEGER              not null,
   "student_name"       VARCHAR2(20)         not null,
   "student_group"      VARCHAR2(6)          not null,
   "Discipline_name"    VARCHAR2(20)
);

ALTER TABLE Homework ADD CONSTRAINT Homework_key PRIMARY KEY (homework_number);

create table "Lection" 
(
   "lection_number"     INTEGER              not null,
   "student_id"         INTEGER,
   "student_name"       VARCHAR2(20),
   "student_group"      VARCHAR2(6),
   "start_reading"      DATE                 not null,
   "the_end_of_the_reading" DATE                 not null
);

ALTER TABLE Lection ADD CONSTRAINT lection_key PRIMARY KEY (lection_number);

create table "Students" 
(
   "student_id"         INTEGER              not null,
   "student_name"       VARCHAR2(20)         not null,
   "student_year"       DATE                 not null,
   "student_birthday"   DATE,
   "student_group"      VARCHAR2(6)          not null,
   "group_code"         VARCHAR2(6)          not null,
   "lection_number"     INTEGER,
   "student_email"      VARCHAR2(30)         not null
);

ALTER TABLE Students ADD CONSTRAINT student_key PRIMARY KEY (student_id);

alter table "Assessments"
   add constraint FK_ASSESSME_ASSESSMEN_DISCIPLI foreign key ("Discipline_name")
      references "Discipline" ("Discipline_name");

alter table "Assessments"
   add constraint FK_ASSESSME_STUDENT_W_STUDENTS foreign key ("student_id", "student_name", "student_group")
      references "Students" ("student_id", "student_name", "student_group");

alter table "Homework"
   add constraint FK_HOMEWORK_HOMEWORK__DISCIPLI foreign key ("Discipline_name")
      references "Discipline" ("Discipline_name");

alter table "Homework"
   add constraint FK_HOMEWORK_HOMEWORK__STUDENTS foreign key ("student_id", "student_name", "student_group")
      references "Students" ("student_id", "student_name", "student_group");

alter table "Lection"
   add constraint FK_LECTION_RELATIONS_STUDENTS foreign key ("student_id", "student_name", "student_group")
      references "Students" ("student_id", "student_name", "student_group");

alter table "Students"
   add constraint FK_STUDENTS_STUDENT_H_GROUP foreign key ("group_code")
      references "Group" ("group_code");

alter table "Students"
   add constraint FK_STUDENTS_LECTION foreign key ("lection_number")
      references "Lection" ("lection_number");