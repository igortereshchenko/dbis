create table "Student" 
(
   "students_name"      VARCHAR2(30)         not null,
   "students_sex"       VARCHAR2(10)         not null,
   "students_email"     VARCHAR2(40)         not null,
);
ALERT TABLE "Student" ADD CONSRTAIN PK_STUDENT PRIMARY KEY("students_email");

create table "Comment" 
(
   "students_email_fk"     VARCHAR2(40)      not null,
   "Lection_them_fk2"       VARCHAR2(30)      not null,
   "name_discipline_fk2"    VARCHAR2(25)      not null,
   "marker_id_fk"          VARCHAR2(10)      not null,
   "comment_date"       DATE                 not null,
   "comment_text"       VARCHAR2(100)        not null,
);
ALERT TABLE "Comment" ADD CONSRTAIN PK_COMMENT PRIMARY KEY("comment_date", "marker_id_fk", "name_discipline_fk2", "Lection_them_fk2", "students_email_fk");

create table "Marker" 
(
   "Lection_them_fk"       VARCHAR2(30)      not null,
   "name_discipline_fk"    VARCHAR2(25)      not null,
   "marker_id"          VARCHAR2(10)         not null,
   "marker_date"        DATE                 not null,
);
ALERT TABLE "Marker" ADD CONSRTAIN PK_MARKER PRIMARY KEY("marker_id", "name_discipline_fk", "Lection_them_fk");

create table "Lection(text)" 
(
   "Lection_text"       VARCHAR2(100)        not null,
   "Lection_them"       VARCHAR2(30)         not null,
   "name_discipline"    VARCHAR2(25)         not null,

);
ALERT TABLE "Lection(text)" ADD CONSRTAIN PK_LECTION_THEM PRIMARY KEY("Lection_them");
ALERT TABLE "Lection(text)" ADD CONSRTAIN PK_NAME_DISCIPLINE PRIMARY KEY("name_discipline");

alter table "Comment"
   add constraint "FK_COMMENT_STUDENT" foreign key ("students_email_fk")
      references "Student" ("students_email");

alter table "Comment"
   add constraint "FK_COMMENT_ONE_OR_MORE_MARKER" foreign key ("Lection_them_fk2", "name_discipline_fk2", "marker_id_fk")
      references "Marker" ("Lection_them_fk", "name_discipline_fk", "marker_id");

alter table "Marker"
   add constraint "FK_MARKER_ONE_OR_MORE_LECTION foreign key ("Lection_them_fk", "name_discipline_fk")
      references "Lection(text)" ("Lection_them", "name_discipline");
