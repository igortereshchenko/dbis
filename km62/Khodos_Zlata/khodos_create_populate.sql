/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     07.05.2018 7:21:49                           */
/*==============================================================*/


alter table device
   drop constraint FK_DEVICE_PERSON_DE_PERSON;

alter table exercise
   drop constraint FK_EXERCISE_MATERIAL__MATERIAL;

alter table help_step
   drop constraint FK_HELP_STE_EXCERSISE_EXERCISE;

alter table help_step
   drop constraint FK_HELP_STE_METARIAL__MATERIAL;

alter table lecture
   drop constraint FK_LECTURE_MATERIAL__MATERIAL;

alter table marker
   drop constraint FK_MARKER_METERIAL__MATERIAL;

alter table marker
   drop constraint FK_MARKER_PERSON_HA_PERSON;

alter table material
   drop constraint FK_MATERIAL_PERSON_MA_PERSON;

alter table note_marker
   drop constraint FK_NOTE_MAR_MARKER_NO_MARKER;

alter table student
   drop constraint FK_STUDENT_PERSON_ST_PERSON;

alter table teacher
   drop constraint FK_TEACHER_PERSON_TE_PERSON;

alter table teacher_faculty
   drop constraint FK_TEACHER__FACULTY_T_FACULTY;

alter table teacher_faculty
   drop constraint FK_TEACHER__TEACHER_F_TEACHER;

alter table understanding
   drop constraint FK_UNDERSTA_MATERIAL__MATERIAL;

alter table understanding
   drop constraint FK_UNDERSTA_STUDENT_U_STUDENT;

drop index person_device_FK;

drop table device cascade constraints;

drop index material_excecise_FK;

drop table exercise cascade constraints;

drop table faculty cascade constraints;

drop index metarial_help_step_FK;

drop index excersise_help_FK;

drop table help_step cascade constraints;

drop index material_lecture_FK;

drop table lecture cascade constraints;

drop index meterial_marker_FK;

drop index person_markers_FK;

drop table marker cascade constraints;

drop index person_material_FK;

drop table material cascade constraints;

drop index marker_note_FK;

drop table note_marker cascade constraints;

drop table person cascade constraints;

drop index person_student_FK;

drop table student cascade constraints;

drop index person_teacher_FK;

drop table teacher cascade constraints;

drop index faculty_teacher_FK;

drop index teacher_faculty_FK;

drop table teacher_faculty cascade constraints;

drop index student_understanding_FK;

drop index material_understanding_FK;

drop table understanding cascade constraints;

/*==============================================================*/
/* Table: device                                                */
/*==============================================================*/
create table device 
(
   person_id            INTEGER              not null,
   device_id            INTEGER              not null,
   constraint PK_DEVICE primary key (person_id, device_id)
);

Alter table device 
add constraint check_device_person_id check(REGEXP_LIKE(person_id, '(\d+)'));

Alter table device 
add constraint check_device_id check(REGEXP_LIKE(device_id, '(\d+)'));

/*==============================================================*/
/* Index: person_device_FK                                      */
/*==============================================================*/
create index person_device_FK on device (
   person_id ASC
);

/*==============================================================*/
/* Table: exercise                                              */
/*==============================================================*/
create table exercise 
(
   material_id          INTEGER              not null,
   exercise_number      INTEGER              not null,
   exercise_solution    CLOB                 not null,
   exercise_mark        NUMBER               not null,
   exercise_time        DATE,
   exercise_complexity  INTEGER              not null,
   constraint PK_EXERCISE primary key (material_id, exercise_number)
);

Alter table exercise
add constraint check_ex_mat_id check(REGEXP_LIKE(material_id, '(\d+)'));
Alter table exercise
add constraint check_ex_number check(REGEXP_LIKE(exercise_number, '(\d+)'));
Alter table exercise
add constraint check_ex_solution check(REGEXP_LIKE(exercise_solution, '(\n|.)+'));
Alter table exercise
add constraint check_ex_mark check(REGEXP_LIKE(exercise_mark, '(\d+)'));
Alter table exercise
add constraint check_ex_time check(REGEXP_LIKE(exercise_time, '([0-3]\d\.[0-1][0-2]\.[0-2]\d{3})'));
Alter table exercise
add constraint check_ex_compl check(REGEXP_LIKE(exercise_complexity, '(\d+)'));


/*==============================================================*/
/* Index: material_excecise_FK                                  */
/*==============================================================*/
create index material_excecise_FK on exercise (
   material_id ASC
);

/*==============================================================*/
/* Table: faculty                                               */
/*==============================================================*/
create table faculty 
(
   faculty_name         VARCHAR2(100)        not null,
   constraint PK_FACULTY primary key (faculty_name)
);
Alter table faculty
add constraint check_faculty_name check(REGEXP_LIKE(faculty_name, '(\w){1,100}'));

/*==============================================================*/
/* Table: help_step                                             */
/*==============================================================*/
create table help_step 
(
   help_material_id     INTEGER              not null,
   material_id          INTEGER              not null,
   exercise_number      INTEGER              not null,
   help_order           INTEGER              not null,
   help_price           INTEGER              not null,
   constraint PK_HELP_STEP primary key (help_material_id, material_id, exercise_number, help_order)
);

Alter table help_step
add constraint check_help_mat_id check(REGEXP_LIKE(help_material_id, '(\d+)'));
Alter table help_step
add constraint check_help_step_mat_id check(REGEXP_LIKE(material_id, '(\d+)'));
Alter table help_step
add constraint check_help_step_ex_num check(REGEXP_LIKE(exercise_number, '(\d+)'));
Alter table help_step
add constraint check_help_order check(REGEXP_LIKE(help_order, '(\d+)'));
Alter table help_step
add constraint check_help_price check(REGEXP_LIKE(help_price, '(\d+)'));

/*==============================================================*/
/* Index: excersise_help_FK                                     */
/*==============================================================*/
create index excersise_help_FK on help_step (
   material_id ASC,
   exercise_number ASC
);

/*==============================================================*/
/* Index: metarial_help_step_FK                                 */
/*==============================================================*/
create index metarial_help_step_FK on help_step (
   help_material_id ASC
);

/*==============================================================*/
/* Table: lecture                                               */
/*==============================================================*/
create table lecture 
(
   material_id          INTEGER              not null,
   lecture_name         VARCHAR2(100)        not null,
   material_order       INTEGER              not null,
   constraint PK_LECTURE_ID primary key (material_id, lecture_name)
);
Alter table lecture
add constraint check_lecture_material_id check(REGEXP_LIKE(material_id, '(\d+)'));
Alter table lecture
add constraint check_lect_lect_name check(REGEXP_LIKE(lecture_name, '^(\w*|\s*|\d*|\.|\)|\(|\,|\:){1,100}$'));
Alter table lecture
add constraint check_lect_mat_order check(REGEXP_LIKE(material_order, '(\d+)'));

/*==============================================================*/
/* Index: material_lecture_FK                                   */
/*==============================================================*/
create index material_lecture_FK on lecture (
   material_id ASC
);

/*==============================================================*/
/* Table: marker                                                */
/*==============================================================*/
create table marker 
(
   marker_id            INTEGER              not null,
   material_id          INTEGER              not null,
   person_id            INTEGER              not null,
   marker_start_point   INTEGER              not null,
   marker_finish_point  INTEGER              not null,
   marker_date          DATE                 not null,
   constraint PK_MARKER primary key (marker_id, material_id, person_id)
);
Alter table marker 
add constraint unique_marker unique(marker_id, material_id, person_id, marker_start_point, marker_finish_point);
Alter table marker
add constraint check_marker_marker_id check(REGEXP_LIKE(marker_id, '(\d+)'));
Alter table marker
add constraint check_marker_mat_id check(REGEXP_LIKE(material_id, '(\d+)'));
Alter table marker
add constraint check_marker_per_id check(REGEXP_LIKE(person_id, '(\d+)'));
Alter table marker
add constraint check_start_point check(REGEXP_LIKE(marker_start_point, '(\d+)'));
Alter table marker
add constraint check_finish_point check(REGEXP_LIKE(marker_finish_point, '(\d+)'));

/*==============================================================*/
/* Index: person_markers_FK                                     */
/*==============================================================*/
create index person_markers_FK on marker (
   person_id ASC
);

/*==============================================================*/
/* Index: meterial_marker_FK                                    */
/*==============================================================*/
create index meterial_marker_FK on marker (
   material_id ASC
);

/*==============================================================*/
/* Table: material                                              */
/*==============================================================*/
create table material 
(
   material_id          INTEGER              not null,
   person_id            INTEGER              not null,
   material_name        VARCHAR2(100)        not null,
   material_text        CLOB                 not null,
   constraint PK_MATERIAL primary key (material_id)
);
Alter table material
add constraint check_mat_mat_id check(REGEXP_LIKE(material_id, '(\d+)'));
Alter table material
add constraint check_mat_person_id check(REGEXP_LIKE(person_id, '(\d+)'));
Alter table material
add constraint check_mat_mat_name check(REGEXP_LIKE(material_name, '^(\w*|\s*|\d*|\.|\)|\(|\,|\:){1,100}$'));
Alter table material
add constraint check_material_text check(REGEXP_LIKE(material_text, '(\n|.)+'));

Alter table material
add constraint unique_material_person unique(material_id,person_id);
/*==============================================================*/
/* Index: person_material_FK                                    */
/*==============================================================*/
create index person_material_FK on material (
   person_id ASC
);

/*==============================================================*/
/* Table: note_marker                                           */
/*==============================================================*/
create table note_marker 
(
   marker_id            INTEGER              not null,
   material_id          INTEGER              not null,
   person_id            INTEGER              not null,
   note_name            VARCHAR2(100)        not null,
   marker_order         INTEGER              not null,
   constraint PK_NOTE_MARKER primary key (marker_id, material_id, person_id, note_name)
);
Alter table note_marker
add constraint check_note_mar_id check(REGEXP_LIKE(marker_id, '(\d+)'));
Alter table note_marker
add constraint check_note_mat_id check(REGEXP_LIKE(material_id, '(\d+)'));
Alter table note_marker
add constraint check_note_mar_per_id check(REGEXP_LIKE(person_id, '(\d+)'));
Alter table note_marker
add constraint check_note_name check(REGEXP_LIKE(note_name, '^(\w*|\s*|\d*|\.|\)|\(|\,|\:){1,100}$'));
Alter table note_marker
add constraint check_note_marker_order check(REGEXP_LIKE(marker_order, '(\d+)'));
/*==============================================================*/
/* Index: marker_note_FK                                        */
/*==============================================================*/
create index marker_note_FK on note_marker (
   marker_id ASC,
   material_id ASC,
   person_id ASC
);

/*==============================================================*/
/* Table: person                                                */
/*==============================================================*/

create table person 
(
   person_id            INTEGER              not null,
   person_email         VARCHAR2(50)         not null,
   person_last_name     VARCHAR2(50)         not null,
   pesron_first_name    VARCHAR2(50)         not null,
   person_middle_name   VARCHAR2(50),
   person_photo         CLOB                  null,
   person_sex           VARCHAR2(10)         not null,
   person_birthday      DATE                 not null,
   constraint PK_PERSON_ID primary key (person_id)
);
Alter table person
add constraint check_person_id check(REGEXP_LIKE(person_id, '(\d+)'));
Alter table person
add constraint check_person_email check(REGEXP_LIKE(person_email, '(\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,6})'));
Alter table person
add constraint check_person_last_name check(REGEXP_LIKE(person_last_name, '(\w+)'));
Alter table person
add constraint check_person_first_name check(REGEXP_LIKE(pesron_first_name, '(\w+)'));
Alter table person
add constraint check_person_middle_name check(REGEXP_LIKE(person_middle_name, '(\w+)'));
Alter table person
add constraint check_person_photo check(REGEXP_LIKE(person_photo, 'image/person/person_id/photo.jpeg'));
Alter table person
add constraint check_person_sex check(REGEXP_LIKE(person_sex, '(M|F)'));


/*==============================================================*/
/* Table: student                                               */
/*==============================================================*/
create table student 
(
   person_id            INTEGER              not null,
   student_id           INTEGER              not null,
   record_book          VARCHAR2(100)        not null,
   record_book_scan     BLOB                 not null,
   student_year         DATE                 not null,
   constraint PK_STUDENT primary key (student_id)
);
Alter table student
add constraint unique_student unique(person_id, student_id);
Alter table student
add constraint check_student_person_id check(REGEXP_LIKE(person_id, '(\d+)'));
Alter table student
add constraint check_student_student_id check(REGEXP_LIKE(student_id, '(\d+)'));
--
/*Alter table student
add constraint check_student_record_book check(REGEXP_LIKE(record_book, '(\d+)'));*/
--
/*Alter table student
add constraint check_student_record_book_scan check(REGEXP_LIKE(person_id, '(\d+)'));*/
Alter table student
add constraint check_student_year check(REGEXP_LIKE(student_year, '([0-3]\d\.[0-1][0-2]\.[0-2]\d{3})'));

/*==============================================================*/
/* Index: person_student_FK                                     */
/*==============================================================*/
create index person_student_FK on student (
   person_id ASC
);

/*==============================================================*/
/* Table: teacher                                               */
/*==============================================================*/
create table teacher 
(
   person_id            INTEGER              not null,
   teacher_id           INTEGER              not null,
   constraint PK_TEACHER primary key (teacher_id)
);
Alter table teacher
add constraint unique_teacher unique(person_id, teacher_id);
Alter table teacher
add constraint check_teacher_person_id check(REGEXP_LIKE(person_id, '(\d+)'));
Alter table teacher
add constraint check_teacher_teacher_id check(REGEXP_LIKE(teacher_id, '(\d+)'));

/*==============================================================*/
/* Index: person_teacher_FK                                     */
/*==============================================================*/
create index person_teacher_FK on teacher (
   person_id ASC
);

/*==============================================================*/
/* Table: teacher_faculty                                       */
/*==============================================================*/
create table teacher_faculty 
(
   faculty_name         VARCHAR2(100)        not null,
   person_id            INTEGER              not null,
   teacher_id           INTEGER              not null,
   contract_number    VARCHAR2(100)        not null,
   date_start           DATE                 not null,
   date_end             DATE,
   constraint PK_TEACHER_FACULTY primary key (faculty_name, teacher_id, contract_number)
);
Alter table teacher_faculty
add constraint check_t_fac_fac_name check(REGEXP_LIKE(faculty_name, '(\w){1,100}'));
Alter table teacher_faculty
add constraint check_t_fac_teacher_id check(REGEXP_LIKE(teacher_id, '(\d+)'));
---
--contract??
---
Alter table teacher_faculty
add constraint check_t_fac_datestart check(REGEXP_LIKE(date_start, '([0-3]\d\.[0-1][0-2]\.[0-2]\d{3})'));
Alter table teacher_faculty
add constraint check_t_fac_dateend check(REGEXP_LIKE(date_end, '([0-3]\d\.[0-1][0-2]\.[0-2]\d{3}) '));
/*==============================================================*/
/* Index: teacher_faculty_FK                                    */
/*==============================================================*/
create index teacher_faculty_FK on teacher_faculty (
   teacher_id ASC
);

/*==============================================================*/
/* Index: faculty_teacher_FK                                    */
/*==============================================================*/
create index faculty_teacher_FK on teacher_faculty (
   faculty_name ASC
);

/*==============================================================*/
/* Table: understanding                                         */
/*==============================================================*/
create table understanding 
(
   person_id            INTEGER              not null,
   student_id           INTEGER              not null,
   material_id          INTEGER              not null,
   understanding_date   DATE                 not null,
   understanding_level  INTEGER              not null,
   constraint PK_UNDERSTANDING primary key (student_id, material_id, understanding_date)
);

Alter table understanding
add constraint check_unds_student_id check(REGEXP_LIKE(student_id, '(\d+)'));
Alter table understanding
add constraint check_unds_material_id check(REGEXP_LIKE(material_id, '(\d+)'));
Alter table understanding
add constraint check_unds_date check(REGEXP_LIKE(understanding_date, '([0-3]\d\.[0-1][0-2]\.[0-2]\d{3})'));
Alter table understanding
add constraint check_unds_level check(REGEXP_LIKE(understanding_level, '(\d+)'));

/*==============================================================*/
/* Index: material_understanding_FK                             */
/*==============================================================*/
create index material_understanding_FK on understanding (
   material_id ASC
);

/*==============================================================*/
/* Index: student_understanding_FK                              */
/*==============================================================*/
create index student_understanding_FK on understanding (
   student_id ASC
);

alter table device
   add constraint FK_DEVICE_PERSON_DE_PERSON foreign key (person_id)
      references person (person_id);

alter table exercise
   add constraint FK_EXERCISE_MATERIAL__MATERIAL foreign key (material_id)
      references material (material_id);

alter table help_step
   add constraint FK_HELP_STE_EXCERSISE_EXERCISE foreign key (material_id, exercise_number)
      references exercise (material_id, exercise_number);

alter table help_step
   add constraint FK_HELP_STE_METARIAL__MATERIAL foreign key (help_material_id)
      references material (material_id);

alter table lecture
   add constraint FK_LECTURE_MATERIAL__MATERIAL foreign key (material_id)
      references material (material_id);

alter table marker
   add constraint FK_MARKER_METERIAL__MATERIAL foreign key (material_id)
      references material (material_id);

alter table marker
   add constraint FK_MARKER_PERSON_HA_PERSON foreign key (person_id)
      references person (person_id);

alter table material
   add constraint FK_MATERIAL_PERSON_MA_PERSON foreign key (person_id)
      references person (person_id);

alter table note_marker
   add constraint FK_NOTE_MAR_MARKER_NO_MARKER foreign key (marker_id, material_id, person_id)
      references marker (marker_id, material_id, person_id);

alter table student
   add constraint FK_STUDENT_PERSON_ST_PERSON foreign key (person_id)
      references person (person_id);

alter table teacher
   add constraint FK_TEACHER_PERSON_TE_PERSON foreign key (person_id)
      references person (person_id);

alter table teacher_faculty
   add constraint FK_TEACHER__FACULTY_T_FACULTY foreign key (faculty_name)
      references faculty (faculty_name);

alter table teacher_faculty
   add constraint FK_TEACHER__TEACHER_F_TEACHER foreign key (teacher_id)
      references teacher (teacher_id);

alter table understanding
   add constraint FK_UNDERSTA_MATERIAL__MATERIAL foreign key (material_id)
      references material (material_id);

alter table understanding
   add constraint FK_UNDERSTA_STUDENT_U_STUDENT foreign key (student_id)
      references student (student_id);

insert into person (person_id, person_email, person_last_name, pesron_first_name, person_middle_name, person_photo, person_sex, person_birthday) 
values (1, 'abc@i.ua', 'b', 'a', 'c', NULL, 'M', TO_DATE('22111998','DD/MM/YYYY'));

insert into person (person_id, person_email, person_last_name, pesron_first_name, person_middle_name, person_photo, person_sex, person_birthday) 
values (2, 'puvasok@do.ua', 'pupkin', 'vasil', 'oleksiyovich', NULL, 'M', TO_DATE('25111996','DD/MM/YYYY'));

insert into person (person_id, person_email, person_last_name, pesron_first_name, person_middle_name, person_photo, person_sex, person_birthday) 
values (3, 'ivanova@ukr.net', 'ivanova', 'ivanna', 'ivanovna', NULL, 'F', TO_DATE('01042000','DD/MM/YYYY'));

/*create table material 
(
   material_id          INTEGER              not null,
   person_id            INTEGER              not null,
   material_name        VARCHAR2(100)        not null,
   material_text        CLOB                 not null,
   constraint PK_MATERIAL primary key (material_id)
);
*/
insert into material(material_id, person_id, material_name, material_text)
values (1, 2, '1.Functions', 'This is some info about functions and so on');

insert into material(material_id, person_id, material_name, material_text)
values (2, 2, '2.Integral', 'This is some info about (:) integral and so on');

insert into material(material_id, person_id, material_name, material_text)
values (3, 1, '1.Equations', 'Well, what about linear equations?');

/*create table lecture 
(
   material_id          INTEGER              not null,
   lecture_name         VARCHAR2(100)        not null,
   material_order       INTEGER              not null,
   constraint PK_LECTURE_ID primary key (material_id, lecture_name)
);*/

insert into lecture(material_id, lecture_name, material_order)
values (2, '1. Indefinite integrals', 1);

insert into lecture(material_id, lecture_name, material_order)
values (2, '2. Indefinite integrals and Gauss formula', 2);

insert into lecture(material_id, lecture_name, material_order)
values (1, '1. Linear function', 1);

/*create table marker 
(
   marker_id            INTEGER              not null,
   material_id          INTEGER              not null,
   person_id            INTEGER              not null,
   marker_start_point   INTEGER              not null,
   marker_finish_point  INTEGER              not null,
   marker_date          DATE                 not null,
   constraint PK_MARKER primary key (marker_id, material_id, person_id)
);*/

insert into marker(marker_id, material_id, person_id, marker_start_point, marker_finish_point, marker_date)
values(1, 1, 1, 45, 60, TO_DATE('01052018','DD/MM/YYYY'));

insert into marker(marker_id, material_id, person_id, marker_start_point, marker_finish_point, marker_date)
values(2, 2, 1, 48, 106, TO_DATE('07052018','DD/MM/YYYY'));

insert into marker(marker_id, material_id, person_id, marker_start_point, marker_finish_point, marker_date)
values(3, 1, 3, 1, 34, TO_DATE('02042018','DD/MM/YYYY'));

insert into marker(marker_id, material_id, person_id, marker_start_point, marker_finish_point, marker_date)
values(4, 1, 3, 120, 168, TO_DATE('03042018','DD/MM/YYYY'));

insert into marker(marker_id, material_id, person_id, marker_start_point, marker_finish_point, marker_date)
values(5, 2, 3, 12, 68, TO_DATE('09042018','DD/MM/YYYY'));

insert into marker(marker_id, material_id, person_id, marker_start_point, marker_finish_point, marker_date)
values(6, 2, 1, 1, 106, TO_DATE('07052018','DD/MM/YYYY'));
/*create table note_marker 
(
   marker_id            INTEGER              not null,
   material_id          INTEGER              not null,
   person_id            INTEGER              not null,
   note_name            VARCHAR2(100)        not null,
   marker_order         INTEGER              not null,
   constraint PK_NOTE_MARKER primary key (marker_id, material_id, person_id, note_name)
);*/

insert into note_marker(marker_id, material_id, person_id, note_name, marker_order)
values(3, 1, 3, 'Functions', 1);

insert into note_marker(marker_id, material_id, person_id, note_name, marker_order)
values(1, 1, 1, 'Odd functions', 1);

insert into note_marker(marker_id, material_id, person_id, note_name, marker_order)
values(2, 2, 1, 'Integrals(the main)', 1);

insert into note_marker(marker_id, material_id, person_id, note_name, marker_order)
values(4, 1, 3, 'Functions', 2);

insert into note_marker(marker_id, material_id, person_id, note_name, marker_order)
values(5, 2, 3, 'Integrals', 1);

insert into note_marker(marker_id, material_id, person_id, note_name, marker_order)
values(6, 2, 1, 'Integrals v2', 1);