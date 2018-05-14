/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     14.05.2018 13:37:33                          */
/*==============================================================*/


alter table "comment"
   drop constraint FK_COMMENT_COMMENT_A_COMMENT;

alter table "comment"
   drop constraint "FK_COMMENT_ONE OR MO_MARKER";

alter table "marker"
   drop constraint "FK_MARKER_PERSON HA_PERSON";

alter table "student"
   drop constraint FK_STUDENT_PERSON_ST_PERSON;

alter table "teacher"
   drop constraint FK_TEACHER_PERSON_TE_PERSON;

drop index "comment_answer_FK";

drop index "one or more comments have mark";

drop table "comment" cascade constraints;

drop table "lecture" cascade constraints;

drop index "person has one or more markers";

drop table "marker" cascade constraints;

drop table "person" cascade constraints;

drop index "person_student_FK";

drop table "student" cascade constraints;

drop index "person_teacher_FK";

drop table "teacher" cascade constraints;

/*==============================================================*/
/* Table: "comment"                                             */
/*==============================================================*/
create table "comment" 
(
   "person_id"          INTEGER              not null,
   "marker_id"          INTEGER              not null,
   "comment_date"       DATE                 not null,
   "com_person_id"      INTEGER,
   "com_marker_id"      INTEGER,
   "com_comment_date"   DATE,
   "comment_text"       CLOB                 not null,
   "comment_id"         INTEGER              not null,
   constraint PK_COMMENT primary key ("person_id", "marker_id", "comment_date", "comment_id")
);

/*==============================================================*/
/* Index: "one or more comments have mark"                      */
/*==============================================================*/
create index "one or more comments have mark" on "comment" (
   "person_id" ASC,
   "marker_id" ASC
);

/*==============================================================*/
/* Index: "comment_answer_FK"                                   */
/*==============================================================*/
create index "comment_answer_FK" on "comment" (
   "com_person_id" ASC,
   "com_marker_id" ASC,
   "com_comment_date" ASC
);

/*==============================================================*/
/* Table: "lecture"                                             */
/*==============================================================*/
create table "lecture" 
(
   "lecture_name"       VARCHAR2(100)        not null,
   "material_order"     INTEGER              not null,
   constraint PK_LECTURE primary key ("lecture_name")
);

/*==============================================================*/
/* Table: "marker"                                              */
/*==============================================================*/
create table "marker" 
(
   "person_id"          INTEGER              not null,
   "marker_date"        DATE                 not null,
   "marker_start_point" INTEGER              not null,
   "marker_finish_point" INTEGER              not null,
   "marker_id"          INTEGER              not null,
   constraint PK_MARKER primary key ("person_id", "marker_id")
);

/*==============================================================*/
/* Index: "person has one or more markers"                      */
/*==============================================================*/
create index "person has one or more markers" on "marker" (
   "person_id" ASC
);

/*==============================================================*/
/* Table: "person"                                              */
/*==============================================================*/
create table "person" 
(
   "person_id"          INTEGER              not null,
   "person_email"       VARCHAR2(50)         not null,
   "person_last_name"   VARCHAR2(50)         not null,
   "pesron_first_name"  VARCHAR2(50)         not null,
   "person_middle_name" VARCHAR2(50)                 ,
   "person_sex"         VARCHAR2(10)         not null,
   constraint PK_PERSON primary key ("person_id")
);

/*==============================================================*/
/* Table: "student"                                             */
/*==============================================================*/
create table "student" 
(
   "person_id"          INTEGER              not null,
   "student_id"         INTEGER              not null,
   "record_book"        VARCHAR2(100)        not null,
   "student_year"       DATE                 not null,
   constraint PK_STUDENT primary key ("person_id", "student_id"),
   constraint AK_IDENTIFIER_1_STUDENT unique ("student_year")
);

/*==============================================================*/
/* Index: "person_student_FK"                                   */
/*==============================================================*/
create index "person_student_FK" on "student" (
   "person_id" ASC
);

/*==============================================================*/
/* Table: "teacher"                                             */
/*==============================================================*/
create table "teacher" 
(
   "person_id"          INTEGER              not null,
   "teacher_id"         INTEGER              not null,
   constraint PK_TEACHER primary key ("person_id", "teacher_id"),
   constraint AK_IDENTIFIER_1_TEACHER unique ("teacher_id")
);

/*==============================================================*/
/* Index: "person_teacher_FK"                                   */
/*==============================================================*/
create index "person_teacher_FK" on "teacher" (
   "person_id" ASC
);

alter table "comment"
   add constraint FK_COMMENT_COMMENT_A_COMMENT foreign key ("com_person_id", "com_marker_id", "com_comment_date")
      references "comment" ("person_id", "marker_id", "comment_date");

alter table "comment"
   add constraint "FK_COMMENT_ONE OR MO_MARKER" foreign key ("person_id", "marker_id")
      references "marker" ("person_id", "marker_id");

alter table "marker"
   add constraint "FK_MARKER_PERSON HA_PERSON" foreign key ("person_id")
      references "person" ("person_id");

alter table "student"
   add constraint FK_STUDENT_PERSON_ST_PERSON foreign key ("person_id")
      references "person" ("person_id");

alter table "teacher"
   add constraint FK_TEACHER_PERSON_TE_PERSON foreign key ("person_id")
      references "person" ("person_id");


insert into comment (person_id, marker_id, comment_date, com_person_id, com_marker_id, com_comment_date, comment_text, comment_id) values (1, 1, TO_DATE('11112000', 'DD/MM/YYYY'), 1, 1, TO_DATE('11112000', 'DD/MM/YYYY'), 'text1', 1);
insert into comment (person_id, marker_id, comment_date, com_person_id, com_marker_id, com_comment_date, comment_text, comment_id) values (2, 2, TO_DATE('12112000', 'DD/MM/YYYY'), 2, 2, TO_DATE('12112000', 'DD/MM/YYYY'), 'text2', 2);
insert into comment (person_id, marker_id, comment_date, com_person_id, com_marker_id, com_comment_date, comment_text, comment_id) values (3, 3, TO_DATE('13112000', 'DD/MM/YYYY'), 3, 3, TO_DATE('13112000', 'DD/MM/YYYY'), 'text3', 3);

insert into lecture (lecture_name, material_order) values ('name1', 1);
insert into lecture (lecture_name, material_order) values ('name2', 2);
insert into lecture (lecture_name, material_order) values ('name3', 3);

insert into marker (person_id, marker_date, marker_start_point, marker_finish_point, marker_id) values (3, TO_DATE('13112000', 'DD/MM/YYYY'), 1, 2, 1);
insert into marker (person_id, marker_date, marker_start_point, marker_finish_point, marker_id) values (4, TO_DATE('14112000', 'DD/MM/YYYY'), 2, 3, 2);
insert into marker (person_id, marker_date, marker_start_point, marker_finish_point, marker_id) values (5, TO_DATE('15112000', 'DD/MM/YYYY'), 4, 5, 3);

insert into person (person_id, person_email, person_last_name, pesron_first_name, person_middle_name, person_sex, person_birthday) values (6, 'abc1@i.ua', 'last_name1', 'first_name1', 'middle_name1', 'sex1');
insert into person (person_id, person_email, person_last_name, pesron_first_name, person_middle_name, person_sex, person_birthday) values (7, 'abc2@i.ua', 'last_name2', 'first_name2', 'middle_name2', 'sex2');
insert into person (person_id, person_email, person_last_name, pesron_first_name, person_middle_name, person_sex, person_birthday) values (8, 'abc3@i.ua', 'last_name3', 'first_name3', 'middle_name3', 'sex3');

insert into student(person_id, student_id, record_book, student_year) values (9, 2, 'record1', TO_DATE('15112000', 'DD/MM/YYYY'));
insert into student(person_id, student_id, record_book, student_year) values (10, 3, 'record2', TO_DATE('16112000', 'DD/MM/YYYY'));
insert into student(person_id, student_id, record_book, student_year) values (11, 4, 'record3', TO_DATE('17112000', 'DD/MM/YYYY'));

insert into teacher(person_id, teacher_id) values (12, 1);
insert into teacher(person_id, teacher_id) values (13, 2);
insert into teacher(person_id, teacher_id) values (14, 3);

SELECT TRIM(Person)
FROM(
		SELECT                      
 		 TRIM(Teacher),
		FROM (
   		     SELECT Person.Person_id
    		    FROM Person
        
     		   MINUS               
        
      	 	 SELECT Student.Student_id
      	 	 FROM Student
     	 	);
	OR
		SELECT                      
 		 TRIM(Student),
		FROM (
   	  	   SELECT Person.Person_id
    	  	  FROM Person
        
    	 	   MINUS               
        
     	 	  SELECT Teacher.Teacher_id
     	 	  FROM Teacher
     	 	);
);

CREATE VIEW user_comment AS 
SELECT DISTINCT Person.Person_id, Comment.Comment_id
FROM Person 
              join Marker on Person.Person_id = Marker.Person_id
              join Comment on Marker.Marker_id = Comment.Marker_id
GROUP BY Person.Person_id, Comment.Comment_id
ORDER BY Person.Person_id;

select Lecture.Lecture_name , count(Comment.Comment_id)
from Lecture 
group by Lecture.Lecture_name;   

select Person.Person_id, count(Comment.Comment_id)
from Person
	    join Marker on Person.Person_id = Marker.Person_id
            join Comment on Marker.Marker_id = Comment.Comment_id
group by Person.Person_id;

select Person.Person_id, count(Comment.Comment_id), Lecture.Lecture_id
from Lecture 
              join Marker on Person.Person_id = Marker.Person_id
              join Comment on Marker.Marker_id = Comment.Comment_id
group by Person.Person_id, Lecture.Lecture_id;