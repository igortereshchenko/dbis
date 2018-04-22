/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     21.04.2018 13:28:34                          */
/*==============================================================*/
/*drop table Lecture cascade constraints;
drop table Note cascade constraints;
drop table Paragraph cascade constraints;
drop table paragraph_has_one_or_more_note cascade constraints;
drop table userss cascade constraints;
drop table lecture_paragraphs_and_notes cascade constraints;
drop table Info_system_users cascade constraints;*/

alter table "Note"
   drop constraint "FK_NOTE_LECTURE I_LECTURE";

alter table "Note"
   drop constraint FK_USER_CREATES_NOTE;

alter table "Paragraph"
   drop constraint FK_LECTURE_CONSISTS_OF_PAR;

alter table "lecture_paragraphs_and_notes"
   drop constraint FK_LECTURE_TO_PARAG;

alter table "lecture_paragraphs_and_notes"
   drop constraint FK_LECTURE_TO_NOTES;

drop table "Info_system_users" cascade constraints;

drop table "Lecture" cascade constraints;

drop index "outlining_FK";

drop index "user _note_FK";

drop table "Note" cascade constraints;

drop index "lecture_paragr_FK";

drop table "Paragraph" cascade constraints;

drop index "lec_paragr_notes2_FK";

drop index "lec_paragr_notes_FK";

drop table "lecture_paragraphs_and_notes" cascade constraints;

/*==============================================================*/
/* Table: "Info_system_users"                                   */
/*==============================================================*/
create table "Info_system_users" 
(
   "login"              CHAR(15)             not null,
   "pass"               CHAR(36)             not null,
   constraint PK_INFO_SYSTEM_USERS primary key ("login")
);
alter table "Info_system_users"
  add constraint check_login 
  check (REGEXP_LIKE("login",'([A-Za-z\d]{3,15})')); 
  
alter table "Info_system_users"
  add constraint check_pass 
  check (REGEXP_LIKE("pass",'([A-Za-z\d]{6,36})')); 
/*==============================================================*/
/* Table: "Lecture"                                             */
/*==============================================================*/
create table "Lecture" 
(
   "lecture_title"      CHAR(70)             not null,
   "lecture_author"     CHAR(60)             not null,
   "lecture_date"       DATE                 not null,
   "lecture_text"       CLOB                 not null,
   constraint PK_LECTURE primary key ("lecture_title", "lecture_author", "lecture_date")
);

alter table "Lecture"
  add constraint check_lecture_title 
  check (REGEXP_LIKE("lecture_title",'([\w\s\d\.])'));
alter table "Lecture"
  add constraint check_lecture_author 
  check (REGEXP_LIKE("lecture_author",'([\w\s])'));
alter table "Lecture"
  add constraint check_lecture_date 
  check (REGEXP_LIKE("lecture_date",'((?:\d{2}\.){2}\d{4})'));
alter table "Lecture"
  add constraint check_lecture_date 
  check (REGEXP_LIKE("lecture_text",'([\w+\s\d])'));
/*==============================================================*/
/* Table: "Note"                                                */
/*==============================================================*/
create table "Note" 
(
   "lecture_title"      CHAR(70)             not null,
   "lecture_author"     CHAR(60)             not null,
   "lecture_date"       DATE                 not null,
   "login"              CHAR(15)             not null,
   "note_number"        INTEGER              not null,
   "note_datetime"      DATE                 not null,
   constraint PK_NOTE primary key ("lecture_title", "lecture_author", "lecture_date", "login", "note_number", "note_datetime")
);

alter table Note
  add constraint check_title 
  check (REGEXP_LIKE(lecture_title,'([\w\s\d\.])'));
alter table Note
  add constraint check_author 
  check (REGEXP_LIKE(lecture_author,'([\w\s])'));
alter table Note
  add constraint check_date 
  check (REGEXP_LIKE(lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table Note
  add constraint check_login_note 
  check (REGEXP_LIKE(login,'([A-Za-z\d]{3,15})'));
alter table Note
  add constraint check_note_number 
  check (REGEXP_LIKE(note_number,'(\d+)'));
alter table Note
  add constraint check_note_date 
  check (REGEXP_LIKE(note_datetime,'((?:\d{2}\.){2}\d{4})'));

/*==============================================================*/
/* Index: "user _note_FK"                                       */
/*==============================================================*/
create index "user _note_FK" on "Note" (
   "login" ASC
);

/*==============================================================*/
/* Index: "outlining_FK"                                        */
/*==============================================================*/
create index "outlining_FK" on "Note" (
   "lecture_title" ASC,
   "lecture_author" ASC,
   "lecture_date" ASC
);

/*==============================================================*/
/* Table: "Paragraph"                                           */
/*==============================================================*/
create table "Paragraph" 
(
   "lecture_title"      CHAR(70)             not null,
   "lecture_author"     CHAR(60)             not null,
   "lecture_date"       DATE                 not null,
   "copy_start_point"   INTEGER              not null,
   "copy_finish_point"  INTEGER              not null,
   constraint PK_PARAGRAPH primary key ("lecture_title", "lecture_author", "lecture_date", "copy_start_point", "copy_finish_point")
);

alter table Paragraph
  add constraint check_lecture_title_par 
  check (REGEXP_LIKE(lecture_title,'([\w\s\d\.])'));
alter table Paragraph
  add constraint check_lecture_author_par
  check (REGEXP_LIKE(lecture_author,'([\w\s])'));
alter table Paragraph
  add constraint check_lecture_date_par
  check (REGEXP_LIKE(lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table Paragraph
  add constraint check_par_num
  check (REGEXP_LIKE(paragr_num_f,'(\d+)'));
alter table Paragraph
  add constraint check_start
  check (REGEXP_LIKE(copy_start_point,'(\d+)'));
alter table Paragraph
  add constraint check_finish
  check (REGEXP_LIKE(copy_finish_point,'(\d+)'));
/*==============================================================*/
/* Index: "lecture_paragr_FK"                                   */
/*==============================================================*/
create index "lecture_paragr_FK" on "Paragraph" (
   "lecture_title" ASC,
   "lecture_author" ASC,
   "lecture_date" ASC
);

/*==============================================================*/
/* Table: "lecture_paragraphs_and_notes"                        */
/*==============================================================*/
create table "lecture_paragraphs_and_notes" 
(
   "Par_lecture_title"  CHAR(70)             not null,
   "Par_lecture_author" CHAR(60)             not null,
   "Par_lecture_date"   DATE                 not null,
   "copy_start_point"   INTEGER              not null,
   "copy_finish_point"  INTEGER              not null,
   "lecture_title"      CHAR(70)             not null,
   "lecture_author"     CHAR(60)             not null,
   "lecture_date"       DATE                 not null,
   "login"              CHAR(15)             not null,
   "note_number"        INTEGER              not null,
   "note_date"          DATE                 not null,
   "paragraph_position" INT                  not null,
   constraint PK_LECTURE_PARAGRAPHS_AND_NOTE primary key ("Par_lecture_title", "Par_lecture_author", "Par_lecture_date", "copy_start_point", "copy_finish_point", "lecture_title", "lecture_author", "lecture_date", "login", "note_number", "note_date")
);

alter table lecture_paragraphs_and_notes
  add constraint check_par_lecture_title_par 
  check (REGEXP_LIKE(Par_lecture_title,'([\w\s\d\.])'));
alter table lecture_paragraphs_and_notes
  add constraint check_par_lecture_author_par
  check (REGEXP_LIKE(Par_lecture_author,'([\w\s])'));
alter table lecture_paragraphs_and_notes
  add constraint check_par_lecture_date_par
  check (REGEXP_LIKE(Par_lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table lecture_paragraphs_and_notes
  add constraint check_start_par
  check (REGEXP_LIKE(copy_start_point,'(\d+)'));
alter table lecture_paragraphs_and_notes
  add constraint check_finish_par
  check (REGEXP_LIKE(copy_finish_point,'(\d+)'));
alter table lecture_paragraphs_and_notes
  add constraint check_lecture_title_parag
  check (REGEXP_LIKE(lecture_title,'([\w\s\d\.])'));
alter table lecture_paragraphs_and_notes
  add constraint check_lecture_author_parag
  check (REGEXP_LIKE(lecture_author,'([\w\s])'));
alter table lecture_paragraphs_and_notes
  add constraint check_lecture_date_parag
  check (REGEXP_LIKE(lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table lecture_paragraphs_and_notes
  add constraint check_login_parag 
  check (REGEXP_LIKE(login,'([A-Za-z\d]{3,15})'));
alter table lecture_paragraphs_and_notes
  add constraint check_note_number_parag 
  check (REGEXP_LIKE(note_number,'(\d+)'));
alter table lecture_paragraphs_and_notes
  add constraint check_note_date_parag
  check (REGEXP_LIKE(note_date,'((?:\d{2}\.){2}\d{4})'));
alter table lecture_paragraphs_and_notes
  add constraint check_note_date_parag
  check (REGEXP_LIKE(paragraph_position,'(\d+)'));
/*==============================================================*/
/* Index: "lec_paragr_notes_FK"                                 */
/*==============================================================*/
create index "lec_paragr_notes_FK" on "lecture_paragraphs_and_notes" (
   "lecture_title" ASC,
   "lecture_author" ASC,
   "lecture_date" ASC,
   "login" ASC,
   "note_number" ASC,
   "note_date" ASC
);

/*==============================================================*/
/* Index: "lec_paragr_notes2_FK"                                */
/*==============================================================*/
create index "lec_paragr_notes2_FK" on "lecture_paragraphs_and_notes" (
   "Par_lecture_title" ASC,
   "Par_lecture_author" ASC,
   "Par_lecture_date" ASC,
   "copy_start_point" ASC,
   "copy_finish_point" ASC
);

alter table "Note"
   add constraint "FK_NOTE_LECTURE I_LECTURE" foreign key ("lecture_title", "lecture_author", "lecture_date")
      references "Lecture" ("lecture_title", "lecture_author", "lecture_date");

alter table "Note"
   add constraint FK_USER_CREATES_NOTE foreign key ("login")
      references "Info_system_users" ("login");

alter table "Paragraph"
   add constraint FK_LECTURE_CONSISTS_OF_PAR foreign key ("lecture_title", "lecture_author", "lecture_date")
      references "Lecture" ("lecture_title", "lecture_author", "lecture_date");

alter table "lecture_paragraphs_and_notes"
   add constraint FK_LECTURE_TO_PARAG foreign key ("Par_lecture_title", "Par_lecture_author", "Par_lecture_date", "copy_start_point", "copy_finish_point")
      references "Paragraph" ("lecture_title", "lecture_author", "lecture_date", "copy_start_point", "copy_finish_point");

alter table "lecture_paragraphs_and_notes"
   add constraint FK_LECTURE_TO_NOTES foreign key ("lecture_title", "lecture_author", "lecture_date", "login", "note_number", "note_date")
      references "Note" ("lecture_title", "lecture_author", "lecture_date", "login", "note_number", "note_datetime");/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     21.04.2018 13:28:34                          */
/*==============================================================*/
/*drop table Lecture cascade constraints;
drop table Note cascade constraints;
drop table Paragraph cascade constraints;
drop table paragraph_has_one_or_more_note cascade constraints;
drop table userss cascade constraints;
drop table lecture_paragraphs_and_notes cascade constraints;
drop table Info_system_users cascade constraints;*/

alter table "Note"
   drop constraint "FK_NOTE_LECTURE I_LECTURE";

alter table "Note"
   drop constraint FK_USER_CREATES_NOTE;

alter table "Paragraph"
   drop constraint FK_LECTURE_CONSISTS_OF_PAR;

alter table "lecture_paragraphs_and_notes"
   drop constraint FK_LECTURE_TO_PARAG;

alter table "lecture_paragraphs_and_notes"
   drop constraint FK_LECTURE_TO_NOTES;

drop table "Info_system_users" cascade constraints;

drop table "Lecture" cascade constraints;

drop index "outlining_FK";

drop index "user _note_FK";

drop table "Note" cascade constraints;

drop index "lecture_paragr_FK";

drop table "Paragraph" cascade constraints;

drop index "lec_paragr_notes2_FK";

drop index "lec_paragr_notes_FK";

drop table "lecture_paragraphs_and_notes" cascade constraints;

/*==============================================================*/
/* Table: "Info_system_users"                                   */
/*==============================================================*/
create table "Info_system_users" 
(
   "login"              CHAR(15)             not null,
   "pass"               CHAR(36)             not null,
   constraint PK_INFO_SYSTEM_USERS primary key ("login")
);
alter table "Info_system_users"
  add constraint check_login 
  check (REGEXP_LIKE("login",'([A-Za-z\d]{3,15})')); 
  
alter table "Info_system_users"
  add constraint check_pass 
  check (REGEXP_LIKE("pass",'([A-Za-z\d]{6,36})')); 
/*==============================================================*/
/* Table: "Lecture"                                             */
/*==============================================================*/
create table "Lecture" 
(
   "lecture_title"      CHAR(70)             not null,
   "lecture_author"     CHAR(60)             not null,
   "lecture_date"       DATE                 not null,
   "lecture_text"       CLOB                 not null,
   constraint PK_LECTURE primary key ("lecture_title", "lecture_author", "lecture_date")
);

alter table "Lecture"
  add constraint check_lecture_title 
  check (REGEXP_LIKE("lecture_title",'([\w\s\d\.])'));
alter table "Lecture"
  add constraint check_lecture_author 
  check (REGEXP_LIKE("lecture_author",'([\w\s])'));
alter table "Lecture"
  add constraint check_lecture_date 
  check (REGEXP_LIKE("lecture_date",'((?:\d{2}\.){2}\d{4})'));
alter table "Lecture"
  add constraint check_lecture_date 
  check (REGEXP_LIKE("lecture_text",'([\w+\s\d])'));
/*==============================================================*/
/* Table: "Note"                                                */
/*==============================================================*/
create table "Note" 
(
   "lecture_title"      CHAR(70)             not null,
   "lecture_author"     CHAR(60)             not null,
   "lecture_date"       DATE                 not null,
   "login"              CHAR(15)             not null,
   "note_number"        INTEGER              not null,
   "note_datetime"      DATE                 not null,
   constraint PK_NOTE primary key ("lecture_title", "lecture_author", "lecture_date", "login", "note_number", "note_datetime")
);

alter table Note
  add constraint check_title 
  check (REGEXP_LIKE(lecture_title,'([\w\s\d\.])'));
alter table Note
  add constraint check_author 
  check (REGEXP_LIKE(lecture_author,'([\w\s])'));
alter table Note
  add constraint check_date 
  check (REGEXP_LIKE(lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table Note
  add constraint check_login_note 
  check (REGEXP_LIKE(login,'([A-Za-z\d]{3,15})'));
alter table Note
  add constraint check_note_number 
  check (REGEXP_LIKE(note_number,'(\d+)'));
alter table Note
  add constraint check_note_date 
  check (REGEXP_LIKE(note_datetime,'((?:\d{2}\.){2}\d{4})'));

/*==============================================================*/
/* Index: "user _note_FK"                                       */
/*==============================================================*/
create index "user _note_FK" on "Note" (
   "login" ASC
);

/*==============================================================*/
/* Index: "outlining_FK"                                        */
/*==============================================================*/
create index "outlining_FK" on "Note" (
   "lecture_title" ASC,
   "lecture_author" ASC,
   "lecture_date" ASC
);

/*==============================================================*/
/* Table: "Paragraph"                                           */
/*==============================================================*/
create table "Paragraph" 
(
   "lecture_title"      CHAR(70)             not null,
   "lecture_author"     CHAR(60)             not null,
   "lecture_date"       DATE                 not null,
   "copy_start_point"   INTEGER              not null,
   "copy_finish_point"  INTEGER              not null,
   constraint PK_PARAGRAPH primary key ("lecture_title", "lecture_author", "lecture_date", "copy_start_point", "copy_finish_point")
);

alter table Paragraph
  add constraint check_lecture_title_par 
  check (REGEXP_LIKE(lecture_title,'([\w\s\d\.])'));
alter table Paragraph
  add constraint check_lecture_author_par
  check (REGEXP_LIKE(lecture_author,'([\w\s])'));
alter table Paragraph
  add constraint check_lecture_date_par
  check (REGEXP_LIKE(lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table Paragraph
  add constraint check_par_num
  check (REGEXP_LIKE(paragr_num_f,'(\d+)'));
alter table Paragraph
  add constraint check_start
  check (REGEXP_LIKE(copy_start_point,'(\d+)'));
alter table Paragraph
  add constraint check_finish
  check (REGEXP_LIKE(copy_finish_point,'(\d+)'));
/*==============================================================*/
/* Index: "lecture_paragr_FK"                                   */
/*==============================================================*/
create index "lecture_paragr_FK" on "Paragraph" (
   "lecture_title" ASC,
   "lecture_author" ASC,
   "lecture_date" ASC
);

/*==============================================================*/
/* Table: "lecture_paragraphs_and_notes"                        */
/*==============================================================*/
create table "lecture_paragraphs_and_notes" 
(
   "Par_lecture_title"  CHAR(70)             not null,
   "Par_lecture_author" CHAR(60)             not null,
   "Par_lecture_date"   DATE                 not null,
   "copy_start_point"   INTEGER              not null,
   "copy_finish_point"  INTEGER              not null,
   "lecture_title"      CHAR(70)             not null,
   "lecture_author"     CHAR(60)             not null,
   "lecture_date"       DATE                 not null,
   "login"              CHAR(15)             not null,
   "note_number"        INTEGER              not null,
   "note_date"          DATE                 not null,
   "paragraph_position" INT                  not null,
   constraint PK_LECTURE_PARAGRAPHS_AND_NOTE primary key ("Par_lecture_title", "Par_lecture_author", "Par_lecture_date", "copy_start_point", "copy_finish_point", "lecture_title", "lecture_author", "lecture_date", "login", "note_number", "note_date")
);

alter table lecture_paragraphs_and_notes
  add constraint check_par_lecture_title_par 
  check (REGEXP_LIKE(Par_lecture_title,'([\w\s\d\.])'));
alter table lecture_paragraphs_and_notes
  add constraint check_par_lecture_author_par
  check (REGEXP_LIKE(Par_lecture_author,'([\w\s])'));
alter table lecture_paragraphs_and_notes
  add constraint check_par_lecture_date_par
  check (REGEXP_LIKE(Par_lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table lecture_paragraphs_and_notes
  add constraint check_start_par
  check (REGEXP_LIKE(copy_start_point,'(\d+)'));
alter table lecture_paragraphs_and_notes
  add constraint check_finish_par
  check (REGEXP_LIKE(copy_finish_point,'(\d+)'));
alter table lecture_paragraphs_and_notes
  add constraint check_lecture_title_parag
  check (REGEXP_LIKE(lecture_title,'([\w\s\d\.])'));
alter table lecture_paragraphs_and_notes
  add constraint check_lecture_author_parag
  check (REGEXP_LIKE(lecture_author,'([\w\s])'));
alter table lecture_paragraphs_and_notes
  add constraint check_lecture_date_parag
  check (REGEXP_LIKE(lecture_date,'((?:\d{2}\.){2}\d{4})'));
alter table lecture_paragraphs_and_notes
  add constraint check_login_parag 
  check (REGEXP_LIKE(login,'([A-Za-z\d]{3,15})'));
alter table lecture_paragraphs_and_notes
  add constraint check_note_number_parag 
  check (REGEXP_LIKE(note_number,'(\d+)'));
alter table lecture_paragraphs_and_notes
  add constraint check_note_date_parag
  check (REGEXP_LIKE(note_date,'((?:\d{2}\.){2}\d{4})'));
alter table lecture_paragraphs_and_notes
  add constraint check_note_date_parag
  check (REGEXP_LIKE(paragraph_position,'(\d+)'));
/*==============================================================*/
/* Index: "lec_paragr_notes_FK"                                 */
/*==============================================================*/
create index "lec_paragr_notes_FK" on "lecture_paragraphs_and_notes" (
   "lecture_title" ASC,
   "lecture_author" ASC,
   "lecture_date" ASC,
   "login" ASC,
   "note_number" ASC,
   "note_date" ASC
);

/*==============================================================*/
/* Index: "lec_paragr_notes2_FK"                                */
/*==============================================================*/
create index "lec_paragr_notes2_FK" on "lecture_paragraphs_and_notes" (
   "Par_lecture_title" ASC,
   "Par_lecture_author" ASC,
   "Par_lecture_date" ASC,
   "copy_start_point" ASC,
   "copy_finish_point" ASC
);

alter table "Note"
   add constraint "FK_NOTE_LECTURE I_LECTURE" foreign key ("lecture_title", "lecture_author", "lecture_date")
      references "Lecture" ("lecture_title", "lecture_author", "lecture_date");

alter table "Note"
   add constraint FK_USER_CREATES_NOTE foreign key ("login")
      references "Info_system_users" ("login");

alter table "Paragraph"
   add constraint FK_LECTURE_CONSISTS_OF_PAR foreign key ("lecture_title", "lecture_author", "lecture_date")
      references "Lecture" ("lecture_title", "lecture_author", "lecture_date");

alter table "lecture_paragraphs_and_notes"
   add constraint FK_LECTURE_TO_PARAG foreign key ("Par_lecture_title", "Par_lecture_author", "Par_lecture_date", "copy_start_point", "copy_finish_point")
      references "Paragraph" ("lecture_title", "lecture_author", "lecture_date", "copy_start_point", "copy_finish_point");

alter table "lecture_paragraphs_and_notes"
   add constraint FK_LECTURE_TO_NOTES foreign key ("lecture_title", "lecture_author", "lecture_date", "login", "note_number", "note_date")
      references "Note" ("lecture_title", "lecture_author", "lecture_date", "login", "note_number", "note_datetime");
