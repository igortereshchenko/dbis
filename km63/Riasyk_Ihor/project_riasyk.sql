/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     12.05.2018 15:14:49                          */
/*==============================================================*/


alter table "comment"
   drop constraint FK_COMMENT_COMMENT_A_COMMENT;

alter table "comment"
   drop constraint "FK_COMMENT_ONE OR MO_MARKER";

alter table "course_discipline"
   drop constraint FK_COURSE_D_SPECIALTY_FACULTY_;

alter table "faculty_specialization"
   drop constraint FK_FACULTY__COURSE_SP_COURSE;

alter table "faculty_specialization"
   drop constraint FK_FACULTY__SPECIALTY_SPECIALT;

alter table "marker"
   drop constraint FK_MARKER_METERIAL__MATERIAL;

alter table "marker"
   drop constraint "FK_MARKER_PERSON HA_PERSON";

alter table "material"
   drop constraint FK_MATERIAL_PERSON_MA_PERSON;

alter table "note_marker"
   drop constraint FK_NOTE_MAR_MARKER_NO_MARKER;

drop index "comment_answer_FK";

drop index "one or more comments have mark";

drop table "comment" cascade constraints;

drop table "course" cascade constraints;

drop index "specialty_course_discipline_FK";

drop table "course_discipline" cascade constraints;

drop index "specialty_faculty_FK";

drop index "course_specialty_FK";

drop table "faculty_specialization" cascade constraints;

drop index "meterial_marker_FK";

drop index "person has one or more markers";

drop table "marker" cascade constraints;

drop index "person_material_FK";

drop table "material" cascade constraints;

drop index "marker_note_FK";

drop table "note_marker" cascade constraints;

drop table "person" cascade constraints;

drop table "specialty" cascade constraints;

/*==============================================================*/
/* Table: "comment"                                             */
/*==============================================================*/
create table "comment" 
(
   "marker_id"          INTEGER              not null,
   "comment_date"       TIMESTAMP            not null,
   "com_marker_id"      INTEGER,
   "com_comment_date"   TIMESTAMP,
   "comment_text"       CLOB                 not null,
   constraint PK_COMMENT primary key ("marker_id", "comment_date")
);

/*==============================================================*/
/* Index: "one or more comments have mark"                      */
/*==============================================================*/
create index "one or more comments have mark" on "comment" (
   "marker_id" ASC
);

/*==============================================================*/
/* Index: "comment_answer_FK"                                   */
/*==============================================================*/
create index "comment_answer_FK" on "comment" (
   "com_marker_id" ASC,
   "com_comment_date" ASC
);

/*==============================================================*/
/* Table: "course"                                              */
/*==============================================================*/
create table "course" 
(
   "course_name"        VARCHAR2(100)        not null,
   constraint PK_COURSE primary key ("course_name")
);

/*==============================================================*/
/* Table: "course_discipline"                                   */
/*==============================================================*/
create table "course_discipline" 
(
   "faculty_id"         VARCHAR2(10)         not null,
   "course_discipline_date" DATE                 not null,
   constraint PK_COURSE_DISCIPLINE primary key ("faculty_id", "course_discipline_date")
);

/*==============================================================*/
/* Index: "specialty_course_discipline_FK"                      */
/*==============================================================*/
create index "specialty_course_discipline_FK" on "course_discipline" (
   "faculty_id" ASC
);

/*==============================================================*/
/* Table: "faculty_specialization"                              */
/*==============================================================*/
create table "faculty_specialization" 
(
   "faculty_id"         VARCHAR2(10)         not null,
   "specialty_code"     VARCHAR2(100)        not null,
   "course_name"        VARCHAR2(100)        not null,
   "facultyspecialization_date" TIMESTAMP            not null,
   constraint PK_FACULTY_SPECIALIZATION primary key ("faculty_id")
);
ALTER TABLE Faculty_Specialization
ADD CONSTRAINT UC_F_S UNIQUE (Specialty_Code,Course_Name,Facultyspecialization_Date);

/*==============================================================*/
/* Index: "course_specialty_FK"                                 */
/*==============================================================*/
create index "course_specialty_FK" on "faculty_specialization" (
   "course_name" ASC
);

/*==============================================================*/
/* Index: "specialty_faculty_FK"                                */
/*==============================================================*/
create index "specialty_faculty_FK" on "faculty_specialization" (
   "specialty_code" ASC
);

/*==============================================================*/
/* Table: "marker"                                              */
/*==============================================================*/
create table "marker" 
(
   "marker_id"          INTEGER              not null,
   "mat_person_id"      INTEGER              not null,
   "material_id"        INTEGER              not null,
   "person_id"          INTEGER              not null,
   "marker_date"        TIMESTAMP            not null,
   "marker_start_point" INTEGER              not null,
   "marker_finish_point" INTEGER              not null,
   constraint PK_MARKER primary key ("marker_id")
);
ALTER TABLE Marker
ADD CONSTRAINT UC_Marker UNIQUE (Mat_Person_Id, Material_Id, Person_Id, Marker_Start_Point, Marker_Finish_Point);

/*==============================================================*/
/* Index: "person has one or more markers"                      */
/*==============================================================*/
create index "person has one or more markers" on "marker" (
   "person_id" ASC
);

/*==============================================================*/
/* Index: "meterial_marker_FK"                                  */
/*==============================================================*/
create index "meterial_marker_FK" on "marker" (
   "mat_person_id" ASC,
   "material_id" ASC
);

/*==============================================================*/
/* Table: "material"                                            */
/*==============================================================*/
create table "material" 
(
   "person_id"          INTEGER              not null,
   "material_id"        INTEGER              not null,
   "material_name"      VARCHAR2(100)        not null,
   "material_text"      CLOB                 not null,
   constraint PK_MATERIAL primary key ("person_id", "material_id")
);

/*==============================================================*/
/* Index: "person_material_FK"                                  */
/*==============================================================*/
create index "person_material_FK" on "material" (
   "person_id" ASC
);

/*==============================================================*/
/* Table: "note_marker"                                         */
/*==============================================================*/
create table "note_marker" 
(
   "note_name"          VARCHAR2(100)        not null,
   "marker_id"          INTEGER              not null,
   "marker_order"       INTEGER              not null,
   constraint PK_NOTE_MARKER primary key ("note_name", "marker_id")
);

/*==============================================================*/
/* Index: "marker_note_FK"                                      */
/*==============================================================*/
create index "marker_note_FK" on "note_marker" (
   "marker_id" ASC
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
   "person_middle_name" VARCHAR2(50),
   "person_photo"       BLOB                 not null,
   "person_sex"         VARCHAR2(10)         not null,
   "person_birthday"    DATE                 not null,
   constraint PK_PERSON primary key ("person_id")
);

/*==============================================================*/
/* Table: "specialty"                                           */
/*==============================================================*/
create table "specialty" 
(
   "specialty_code"     VARCHAR2(100)        not null,
   "specialty_name"     VARCHAR2(100)        not null,
   constraint PK_SPECIALTY primary key ("specialty_code")
);

alter table "comment"
   add constraint FK_COMMENT_COMMENT_A_COMMENT foreign key ("com_marker_id", "com_comment_date")
      references "comment" ("marker_id", "comment_date");

alter table "comment"
   add constraint "FK_COMMENT_ONE OR MO_MARKER" foreign key ("marker_id")
      references "marker" ("marker_id");

alter table "course_discipline"
   add constraint FK_COURSE_D_SPECIALTY_FACULTY_ foreign key ("faculty_id")
      references "faculty_specialization" ("faculty_id");

alter table "faculty_specialization"
   add constraint FK_FACULTY__COURSE_SP_COURSE foreign key ("course_name")
      references "course" ("course_name");

alter table "faculty_specialization"
   add constraint FK_FACULTY__SPECIALTY_SPECIALT foreign key ("specialty_code")
      references "specialty" ("specialty_code");

alter table "marker"
   add constraint FK_MARKER_METERIAL__MATERIAL foreign key ("mat_person_id", "material_id")
      references "material" ("person_id", "material_id");

alter table "marker"
   add constraint "FK_MARKER_PERSON HA_PERSON" foreign key ("person_id")
      references "person" ("person_id");

alter table "material"
   add constraint FK_MATERIAL_PERSON_MA_PERSON foreign key ("person_id")
      references "person" ("person_id");

alter table "note_marker"
   add constraint FK_NOTE_MAR_MARKER_NO_MARKER foreign key ("marker_id")
      references "marker" ("marker_id");


insert into specialty (specialty_code, specialty_name) 
values (code_1, 'name1');

insert into specialty (specialty_code, specialty_name) 
values (code_2, 'name2');

insert into specialty (specialty_code, specialty_name) 
values (code_2, 'name2');



insert into faculty_specialization (faculty_id, specialty_code, course_name, facultyspecialization_date) 
values (1, 'code_1', 'name1', TO_DATE('01052018','DD/MM/YYYY'));

insert into faculty_specialization (faculty_id, specialty_code, course_name, facultyspecialization_date) 
values (2, 'code_2', 'name2', TO_DATE('02052018','DD/MM/YYYY'));

insert into faculty_specialization (faculty_id, specialty_code, course_name, facultyspecialization_date) 
values (3, 'code_3', 'name3', TO_DATE('03052018','DD/MM/YYYY'));



insert into marker (marker_id, mat_person_id, material_id, person_id, marker_date, marker_start_point, marker_finish_point) 
values (1, 1, 1, 1, TO_DATE('03052018','DD/MM/YYYY'), 1, 2);

insert into marker (marker_id, mat_person_id, material_id, person_id, marker_date, marker_start_point, marker_finish_point) 
values (2, 2, 2, 2, TO_DATE('04052018','DD/MM/YYYY'), 3, 4);

insert into marker (marker_id, mat_person_id, material_id, person_id, marker_date, marker_start_point, marker_finish_point) 
values (3, 3, 3, 3, TO_DATE('06052018','DD/MM/YYYY'), 5, 6);



insert into comment (marker_id, comment_date, com_marker_id, com_comment_date, comment_text) 
values (5, TO_DATE('07052018','DD/MM/YYYY'), 1, TO_DATE('07052018','DD/MM/YYYY'), 'First');

insert into comment (marker_id, comment_date, com_marker_id, com_comment_date, comment_text) 
values (6, TO_DATE('08052018','DD/MM/YYYY'), 2, TO_DATE('08052018','DD/MM/YYYY'), 'Second');

insert into comment (marker_id, comment_date, com_marker_id, com_comment_date, comment_text) 
values (7, TO_DATE('09052018','DD/MM/YYYY'), 3, TO_DATE('09052018','DD/MM/YYYY'), 'the third');