create table Testt 
(
   variant              NUMBER(5)            not null,
   topic                VARCHAR2(30)         not null,
   start_test           DATE                 not null,
   end_test             DATE                 not null
);


alter table Testt
   add constraint test_pk primary key (topic, variant);
   
alter table Testt
   add constraint check_variant check (REGEXP_LIKE(variant, '(\d{5})'));
alter table Testt
   add constraint check_topic check (REGEXP_LIKE(topic, '(.{30})'));
alter table Testt
   add constraint check_start check (REGEXP_LIKE(start_test, '(\d{2}-\d{2}-\d{4})'));
alter table Testt
   add constraint check_end check (REGEXP_LIKE(end_test, '(\d{2}-\d{2}-\d{4})'));
   

create table Task 
(
   topic                VARCHAR2(30)         not null,
   variant              NUMBER(5)            not null,
   task_id              NUMBER(20)           not null,
   condition            VARCHAR2(100)        not null,
   task_time            TIME,
   correct_answ         VARCHAR2(100)        not null,
   task_mark            NUMBER(5)            not null
);

alter table Task
   add constraint task_id_pk primary key (topic, variant, task_id);
   
   
alter table Task
   add constraint check_topic check (REGEXP_LIKE(topic, '(.{30})'));
alter table Task
   add constraint check_variant check (REGEXP_LIKE(variant, '(\d{5})'));
alter table Task
   add constraint check_task_id check (REGEXP_LIKE(task_id, '(\d{20})'));
alter table Task
   add constraint check_cond check (REGEXP_LIKE(condition, '(.{100})'));
alter table Task
   add constraint check_time check (REGEXP_LIKE(task_time, '(\d{2}:\d{2})'));
alter table Task
   add constraint check_corr_answ check (REGEXP_LIKE(correct_answ , '(.{100})'));
alter table Task
   add constraint check_mark check (REGEXP_LIKE(task_mark, '(\d{5})'));

create table Answer 
(
   topic                VARCHAR2(30)         not null,
   variant              NUMBER(5)            not null,
   task_id              NUMBER(20)           not null,
   answ_id              NUMBER(10)           not null,
   start_answ           DATE,
   end_answ             DATE,
   text_of_answ         VARCHAR2(100)        not null,
   mark                 NUMBER(5)            not null
);

alter table Answer
   add constraint answ_id_pk primary key (topic, variant, task_id, answ_id);


alter table Answer
   add constraint check_topic check (REGEXP_LIKE(topic, '(.{30})'));
alter table Answer
   add constraint check_variant check (REGEXP_LIKE(variant, '(\d{5})'));
alter table Answer
   add constraint check_task_id check (REGEXP_LIKE(task_id, '(\d{20})'));
alter table Answer
   add constraint check_answ_id check (REGEXP_LIKE(answ_id, '(\d{10})'));
alter table Answer
   add constraint check_start_answ check (REGEXP_LIKE(start_answ, '(\d{2}-\d{2}-\d{4})'));
alter table Answer
   add constraint check_end_answ check (REGEXP_LIKE(end_answ, '(\d{2}-\d{2}-\d{4})'));
alter table Answer
   add constraint check_text_answ check (REGEXP_LIKE(text_of_answ, '(.{100})'));
alter table Answer
   add constraint check_mark check (REGEXP_LIKE(mark, '(\d{5})'));
   
create table Help 
(
   topic                VARCHAR2(30)         not null,
   variant              NUMBER(5)            not null,
   task_id              NUMBER(20)           not null,
   help_id              NUMBER(20)           not null,
   price                NUMBER(5)            not null,
   stage                NUMBER(3)            not null,
   text_of_help         VARCHAR2(50)         not null
);

alter table Help
   add constraint help_id_pk primary key (topic, variant, task_id, help_id);
   
   
alter table Help
   add constraint check_topic check (REGEXP_LIKE(topic, '(.{30})'));
alter table Help
   add constraint check_variant check (REGEXP_LIKE(variant, '(\d{5})'));
alter table Help
   add constraint check_task_id check (REGEXP_LIKE(task_id, '(\d{20})'));
alter table Help
   add constraint check_help_id check (REGEXP_LIKE(help_id, '(\d{20})'));
alter table Help
   add constraint check_price check (REGEXP_LIKE(price, '(\d{5})'));
alter table Help
   add constraint check_stage check (REGEXP_LIKE(stage, '(\d{3})'));
alter table Help
   add constraint check_text_help check (REGEXP_LIKE(text_of_help, '(.{50})'));
   

   
alter table Testt
   add constraint test_task_fk foreign key (topic, variant)
      references Task(topic, variant);
      
alter table Task
   add constraint task_answ_fk foreign key (topic, variant, task_id)
      references Answer(topic, variant, task_id);
      
alter table Task
   add constraint task_help_fk foreign key (topic, variant, task_id)
      references Help(topic, variant, task_id);

