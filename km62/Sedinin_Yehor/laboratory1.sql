-- LABORATORY WORK 1
-- BY Sedinin_Yehor
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
модифікувати таблиці та вставляти дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Sedinin
IDENTIFIED BY Pass
DEFAULT TABLESPACE "USER"
TEMPORARY TABLESPACE "TEMP";

ALTER USER Sedinin QUOTA 100M ON USERS;

GRANT "CONNECT" TO Sedinin;

GRANT ALTER ANY TABLE TO Sedinin;
GRANT INSERT ANY TABLE TO Sedinin;
/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент купляє квиток на потяг.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     17.04.2018 19:37:27                          */
/*==============================================================*/


alter table "Ticket"
   drop constraint FK_STUDENT_HAS_TICKET;

alter table "Ticket"
   drop constraint FK_TICKET_BOUGHT_HERE;

alter table "Ticket"
   drop constraint FK_TICKET_ON_TRAIN;

drop table STUDENT cascade constraints;

drop table "Salepoint" cascade constraints;

drop index "ticket on train_FK";

drop index "ticket bought here_FK";

drop index "student have a ticket_FK";

drop table "Ticket" cascade constraints;

drop table "Train" cascade constraints;

/*==============================================================*/
/* Table: STUDENT                                               */
/*==============================================================*/
create table STUDENT 
(
   "student_id"         INTEGER              not null,
   "student_name"       VARCHAR2(20)         not null,
   "birthday"           DATE                 not null,
   constraint PK_STUDENT primary key ("student_id")
);

/*==============================================================*/
/* Table: "Salepoint"                                           */
/*==============================================================*/
create table "Salepoint" 
(
   "salepoint_id"       INTEGER              not null,
   constraint PK_SALEPOINT primary key ("salepoint_id")
);

/*==============================================================*/
/* Table: "Ticket"                                              */
/*==============================================================*/
create table "Ticket" 
(
   "ticket_id"          INTEGER              not null,
   "student_id"         INTEGER,
   "train_id"           INTEGER,
   "salepoint_id"       INTEGER,
   constraint PK_TICKET primary key ("ticket_id")
);

/*==============================================================*/
/* Index: "student have a ticket_FK"                            */
/*==============================================================*/
create index "student have a ticket_FK" on "Ticket" (
   "student_id" ASC
);

/*==============================================================*/
/* Index: "ticket bought here_FK"                               */
/*==============================================================*/
create index "ticket bought here_FK" on "Ticket" (
   "salepoint_id" ASC
);

/*==============================================================*/
/* Index: "ticket on train_FK"                                  */
/*==============================================================*/
create index "ticket on train_FK" on "Ticket" (
   "train_id" ASC
);

/*==============================================================*/
/* Table: "Train"                                               */
/*==============================================================*/
create table "Train" 
(
   "train_id"           INTEGER              not null,
   "departue_time"      DATE                 not null,
   constraint PK_TRAIN primary key ("train_id")
);

alter table "Ticket"
   add constraint FK_STUDENT_HAS_TICKET foreign key ("student_id")
      references STUDENT ("student_id");

alter table "Ticket"
   add constraint FK_TICKET_BOUGHT_HERE foreign key ("salepoint_id")
      references "Salepoint" ("salepoint_id");

alter table "Ticket"
   add constraint FK_TICKET_ON_TRAIN foreign key ("train_id")
      references "Train" ("train_id");

INSERT INTO Student (student_id, student_name, birthday) 
VALUES (000001, Alex, 19890219) 

INSERT INTO Student (student_id, student_name, birthday) 
VALUES (000002, Tom, 19921006) 

INSERT INTO Student (student_id, student_name, birthday) 
VALUES (000002, Jack, 19900725) 


/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     18.04.2018 19:37:27                          */
/*==============================================================*/


alter table "Ticket"
   drop constraint FK_STUDENT_HAS_TICKET;

alter table "Ticket"
   drop constraint FK_TICKET_BOUGHT_HERE;

alter table "Ticket"
   drop constraint FK_TICKET_ON_TRAIN;

drop table STUDENT cascade constraints;

drop table "Salepoint" cascade constraints;

drop index "ticket on train_FK";

drop index "ticket bought here_FK";

drop index "student have a ticket_FK";

drop table "Ticket" cascade constraints;

drop table "Train" cascade constraints;

/*==============================================================*/
/* Table: STUDENT                                               */
/*==============================================================*/
create table STUDENT 
(
   "student_id"         INTEGER              not null,
   "student_name"       VARCHAR2(20)         not null,
   "birthday"           DATE                 not null,
   constraint PK_STUDENT primary key ("student_id")
);

/*==============================================================*/
/* Table: "Salepoint"                                           */
/*==============================================================*/
create table "Salepoint" 
(
   "salepoint_id"       INTEGER              not null,
   constraint PK_SALEPOINT primary key ("salepoint_id")
);

/*==============================================================*/
/* Table: "Ticket"                                              */
/*==============================================================*/
create table "Ticket" 
(
   "ticket_id"          INTEGER              not null,
   "student_id"         INTEGER,
   "train_id"           INTEGER,
   "salepoint_id"       INTEGER,
   constraint PK_TICKET primary key ("ticket_id")
);

/*==============================================================*/
/* Index: "student have a ticket_FK"                            */
/*==============================================================*/
create index "student have a ticket_FK" on "Ticket" (
   "student_id" ASC
);

/*==============================================================*/
/* Index: "ticket bought here_FK"                               */
/*==============================================================*/
create index "ticket bought here_FK" on "Ticket" (
   "salepoint_id" ASC
);

/*==============================================================*/
/* Index: "ticket on train_FK"                                  */
/*==============================================================*/
create index "ticket on train_FK" on "Ticket" (
   "train_id" ASC
);

/*==============================================================*/
/* Table: "Train"                                               */
/*==============================================================*/
create table "Train" 
(
   "train_id"           INTEGER              not null,
   "departue_time"      DATE                 not null,
   constraint PK_TRAIN primary key ("train_id")
);

alter table "Ticket"
   add constraint FK_STUDENT_HAS_TICKET foreign key ("student_id")
      references STUDENT ("student_id");

alter table "Ticket"
   add constraint FK_TICKET_BOUGHT_HERE foreign key ("salepoint_id")
      references "Salepoint" ("salepoint_id");

alter table "Ticket"
   add constraint FK_TICKET_ON_TRAIN foreign key ("train_id")
      references "Train" ("train_id");

INSERT INTO Student (student_id, student_name, birthday) 
VALUES (000001, Alex, 19890219) 

INSERT INTO Student (student_id, student_name, birthday) 
VALUES (000002, Tom, 19921006) 

INSERT INTO Salepoint (student_id, student_name, birthday) 
VALUES (000002, Jack, 19900725) 


INSERT INTO Salepoint (salepoint_id) 
VALUES (387610) 

INSERT INTO Salepoint (salepoint_id) 
VALUES (870061) 

INSERT INTO Salepoint (salepoint_id) 
VALUES (000987) 


INSERT INTO Train (train_id, departure_time) 
VALUES (000012, 20180420 10:30:00 AM) 

INSERT INTO Train (train_id, departure_time) 
VALUES (00003, 20180422 09:00:00 AM) 

INSERT INTO Train (train_id, departure_time) 
VALUES (000998, 20180501 07:30:00 PM) 


INSERT INTO Ticket (ticket_id) 
VALUES (341404)

INSERT INTO Ticket (ticket_id) 
VALUES (124007)

INSERT INTO Ticket (ticket_id) 
VALUES (103211)
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO Sedinin;
GRANT SELECT ANY TABLE TO Sedinin;
/*---------------------------------------------------------------------------
3.a. 
Якого товару найменше продано?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
    SELECT distinct prod_id
    FROM orderitems
    WHERE quantity in (SELECT MIN(quantity) FROM orderitems)
/*---------------------------------------------------------------------------
3.b. 
Скільки одиниць товару продано покупцям, що живуть в Америці?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
    SELECT SUM(QUANTITY)  --НЕ УВЕРЕН ЧТО ВЫВЕДЕТ ЧИСЛО (ЧИСЛА?)
    FROM ORDERS, ORDERITEMS
    WHERE CUST_COUNTRY =  'USA'
    AND CUSTOMERS.CUST_ID = OREDERS.CUST_ID
    AND ORDERS.ORDER_NUM =  ORDERITEMS.ORDER_NUM);
/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників, що не продали жодного зі своїх продуктів.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
PROJECT ((PROJECT (VENDORS){VEND_NAME, VEND_ID}){VEND_NAME}
            MINUS
PROJECT DISTINCT (PROJECT DISTINCT(PRODUCTS TIMES VENDORS TIMES ORDERITEMS)
                  {VENDORS.VEND_NAME, PRODUCTS.VEND_ID, ORDERITEMS.PROD_ID}
WHERE ( PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID 
and PRODUCTS.VEND_ID = VENDORS.VEND_ID)){VEND_NAME, VEND_ID});
