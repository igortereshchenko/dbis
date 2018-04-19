alter table "Parameter"
   drop constraint "FK_PARAMETE_EXERCISE _EXERCISE";

alter table "Parameter"
   drop constraint "FK_PARAMETE_TEST HAS _TEST";

drop table "Exercise" cascade constraints;

drop index "test has parameters_FK";

drop index "exercise has parameters_FK";

drop table "Parameter" cascade constraints;

drop table "Test" cascade constraints;

/*==============================================================*/
/* Table: "Exercise"                                            */
/*==============================================================*/
create table "Exercise" 
(
   "condition_id"       NUMBER(6)            not null,
   "condition_name"     VARCHAR2(30)         not null,
   "condition_text"     CLOB                 not null,
   "solution_id"        NUMBER(6)            not null,
   "solution_name"      VARCHAR2(20)         not null,
   "solution_text"      CLOB                 not null,
   constraint PK_EXERCISE primary key ("condition_id", "solution_id")
);

/*==============================================================*/
/* Table: "Parameter"                                           */
/*==============================================================*/
create table "Parameter" 
(
   "parameter_id"       NUMBER(6)            not null,
   "result_id"          NUMBER(6),
   "condition_id"       NUMBER(6),
   "solution_id"        NUMBER(6),
   "parameter_name"     VARCHAR2(20)         not null,
   "parameter_value"    NUMBER(6)            not null,
   constraint PK_PARAMETER primary key ("parameter_id")
);

/*==============================================================*/
/* Index: "exercise has parameters_FK"                          */
/*==============================================================*/
create index "exercise has parameters_FK" on "Parameter" (
   "condition_id" ASC,
   "solution_id" ASC
);

/*==============================================================*/
/* Index: "test has parameters_FK"                              */
/*==============================================================*/
create index "test has parameters_FK" on "Parameter" (
   "result_id" ASC
);

/*==============================================================*/
/* Table: "Test"                                                */
/*==============================================================*/
create table "Test" 
(
   "result_id"          NUMBER(6)            not null,
   "result"             NUMBER(6)            not null,
   "parameter_list"     CLOB                 not null,
   constraint PK_TEST primary key ("result_id")
);

alter table "Parameter"
   add constraint "FK_PARAMETE_EXERCISE _EXERCISE" foreign key ("condition_id", "solution_id")
      references "Exercise" ("condition_id", "solution_id");

alter table "Parameter"
   add constraint "FK_PARAMETE_TEST HAS _TEST" foreign key ("result_id")
      references "Test" ("result_id");

INSERT INTO Exercise (
    condition_id,     
   condition_name,     
   condition_text,
   solution_id,       
   solution_text,
   solution_constraint
) VALUES (
    '1',
    'add',
    'add two numbers "a and "b", where a>b ',
    '1',
    'a+b',
    'a>b'
);

INSERT INTO Exercise (
    condition_id,     
   condition_name,     
   condition_text,
   solution_id,       
   solution_text,
   solution_constraint
) VALUES (
    '2',
    'minus',
    'minus two numbers "a from "b", where a>b ',
    '2',
    'a-b',
    'a>b'
);

INSERT INTO Exercise (
    condition_id,     
   condition_name,     
   condition_text,
   solution_id,       
   solution_text,
   solution_constraint
) VALUES (
    '1',
    'union',
    'union two sets "A" and "B" ',
    '2',
    'A{\displaystyle \cup }B'
);

INSERT INTO Parameter(
   parameter_id,       
   condition_id,    
   solution_id,      
   parameter_name,   
   parameter_value
) VALUES (
    '1',
    '1',
    '1',
    'a', 
    '2'
);

INSERT INTO Parameter(
   parameter_id,       
   condition_id,    
   solution_id,      
   parameter_name,   
   parameter_value
) VALUES (
    '2',
    '1',
    '1',
    'b', 
    '3'
);
INSERT INTO Parameter(
   parameter_id,       
   condition_id,    
   solution_id,      
   parameter_name,   
   parameter_value
) VALUES (
    '3',
    '2',
    '2',
    'a', 
    '4'
);
INSERT INTO Test(
   result_id,       
   result,    
   parameter_list       
) VALUES (
    '1',
    '5',
    'a=2,b=3'
);
INSERT INTO Test(
   result_id,       
   result,    
   parameter_list       
) VALUES (
    '2',
    '-1',
    'a=2,b=3'
);
INSERT INTO Test(
   result_id,       
   result,    
   parameter_list       
) VALUES (
    '3',
    '{2,4,5,3}',
    'A={2,4},B={5,3}'
); 