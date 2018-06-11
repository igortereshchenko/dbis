create table Task 
(
   task_id              NUMBER(30)           not null,
   task_text            VARCHAR2(100)        not null
);
Alter Table Task
add constraint task_id_pk primary key (task_id);

Alter table Task
add constraint check_task_id
check (REGEXP_LIKE(task_id,'(\d{30})'));

Alter table Task
add constraint check_task_text
check (REGEXP_LIKE(task_text,'(.{100})'));

create table Task_Answer 
(
   task_id_fk           NUMBER(30)           not null,
   answer_version       NUMBER(30)           not null,
   answer_text          VARCHAR2(100)        not null
);
alter table Task_Answer
add constraint PK_TASK_ANSWER primary key (task_id_fk, answer_version);

alter table Task_Answer
   add constraint task_id_fk foreign key (task_id_fk)
      references Task (task_id);
      
Alter table Task_Answer
add constraint check_task_id_fk
check (REGEXP_LIKE(task_id_fk,'(\d{30})'));

Alter table Task_Answer
add constraint check_answer_version
check (REGEXP_LIKE(answer_version,'(\d{30})'));

Alter table Task_Answer
add constraint check_answer_text
check (REGEXP_LIKE(answer_text,'(.{100})'));

create table Notes 
(
   task_id_fk           NUMBER(30)           not null,
   note_id              NUMBER(30)           not null,
   note_text            VARCHAR2(100)        not null
);
alter table Notes
add constraint PK_NOTES primary key (task_id_fk, note_id);

alter table Notes
   add constraint task_id_fk1 foreign key (task_id_fk)
      references Task (task_id);
      
Alter table Notes
add constraint check_task_id_fk1
check (REGEXP_LIKE(task_id_fk,'(\d{30})'));

Alter table Notes
add constraint check_note_id
check (REGEXP_LIKE(note_id,'(\d{30})'));

Alter table Notes
add constraint check_note_text
check (REGEXP_LIKE(note_text,'(.{100})'));

create table Comments 
(
   task_id_fk           NUMBER(30)           not null,
   answer_version_fk    NUMBER(30)           not null,
   comment_id             NUMBER(30)          not null,
   comment_text         VARCHAR2(100)        not null
);

alter table Comments
add constraint PK_COMMENTS primary key (task_id_fk, answer_version_fk, comment_id);

alter table Comments
   add constraint fk_comments foreign key (task_id_fk, answer_version_fk)
      references Task_Answer (task_id_fk, answer_version);

Alter table Comments
add constraint check_task_id_fk2
check (REGEXP_LIKE(task_id_fk,'(\d{30})'));

Alter table Comments
add constraint check_answer_version_fk
check (REGEXP_LIKE(answer_version_fk,'(\d{30})'));

Alter table Comments
add constraint check_comment_id
check (REGEXP_LIKE(comment_id,'(\d{30})'));

Alter table Comments
add constraint check_comment_text
check (REGEXP_LIKE(comment_text,'(.{100})'));

      

