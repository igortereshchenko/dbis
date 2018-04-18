/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
create user ASIMER
identified by 123456
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
ALTER USER ASIMER QUOTA 100M ON USERS;
GRANT "CONNECT" TO ASIMER;
grant select any table to ASIMER;








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Комп’ютер складається з апаратного (деталі: процесор, блок живлення) та програмного забезпечення.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     18/04/2018 23:32:47                          */
/*==============================================================*/


alter table HARDWARE_HAS_PROPERTY
   drop constraint FK_HARDWARE_HARDWARE__HARDWARE;

alter table HARDWARE_HAS_PROPERTY
   drop constraint FK_HARDWARE_HARDWARE__PROPERTI;

alter table HAS_HARDWARE
   drop constraint FK_HAS_HARD_COMPUTER__COMPUTER;

alter table HAS_HARDWARE
   drop constraint FK_HAS_HARD_HAS_HARDW_HARDWARE;

alter table INSTALLED_PROGRAM
   drop constraint FK_INSTALLE_COMPUTER__COMPUTER;

alter table INSTALLED_PROGRAM
   drop constraint FK_INSTALLE_INSTALLED_PROGRAMS;

alter table PROGRAM_HAS_PROPERTY
   drop constraint FK_PROGRAM__PROGRAM_H_PROGRAMS;

alter table PROGRAM_HAS_PROPERTY
   drop constraint FK_PROGRAM__PROGRAM_H_PROPERTI;

drop table COMPUTER cascade constraints;

drop table HARDWARE cascade constraints;

drop index HARDWARE_HAS_PROPERTY_TO_PROPE;

drop index HARDWARE_HAS_PROPERTY2_FK;

drop table HARDWARE_HAS_PROPERTY cascade constraints;

drop index COMPUTER_TO_HAS_HARDWARE_FK;

drop index HAS_HARDWARE_TO_HARDWARE_FK;

drop table HAS_HARDWARE cascade constraints;

drop index INSTALLED_PROGARM_TO_PROGRAMS_;

drop index COMPUTER_TO_INSTALLED_PROGRAMS;

drop table INSTALLED_PROGRAM cascade constraints;

drop table PROGRAMS cascade constraints;

drop index PROGRAM_HAS_PROPERTY_TO_PROTER;

drop index PROGRAM_HAS_PROPERTY2_FK;

drop table PROGRAM_HAS_PROPERTY cascade constraints;

drop table PROPERTIES cascade constraints;

/*==============================================================*/
/* Table: COMPUTER                                              */
/*==============================================================*/
create table COMPUTER 
(
   COMPUTER_ID          INTEGER              not null,
   constraint PK_COMPUTER primary key (COMPUTER_ID)
);

/*==============================================================*/
/* Table: HARDWARE                                              */
/*==============================================================*/
create table HARDWARE 
(
   HARDWARE_ID          INTEGER              not null,
   MODEL                VARCHAR2(20),
   TYPE                 VARCHAR2(20),
   VENDOR               VARCHAR2(20),
   constraint PK_HARDWARE primary key (HARDWARE_ID)
);

/*==============================================================*/
/* Table: HARDWARE_HAS_PROPERTY                                 */
/*==============================================================*/
create table HARDWARE_HAS_PROPERTY 
(
   NAME                 VARCHAR2(20)         not null,
   HARDWARE_ID          INTEGER              not null,
   VALUE                VARCHAR2(20),
   constraint PK_HARDWARE_HAS_PROPERTY primary key (NAME, HARDWARE_ID)
);

/*==============================================================*/
/* Index: HARDWARE_HAS_PROPERTY2_FK                             */
/*==============================================================*/
create index HARDWARE_HAS_PROPERTY2_FK on HARDWARE_HAS_PROPERTY (
   HARDWARE_ID ASC
);

/*==============================================================*/
/* Index: HARDWARE_HAS_PROPERTY_TO_PROPE                        */
/*==============================================================*/
create index HARDWARE_HAS_PROPERTY_TO_PROPE on HARDWARE_HAS_PROPERTY (
   NAME ASC
);

/*==============================================================*/
/* Table: HAS_HARDWARE                                          */
/*==============================================================*/
create table HAS_HARDWARE 
(
   COMPUTER_ID          INTEGER              not null,
   HARDWARE_ID          INTEGER              not null,
   constraint PK_HAS_HARDWARE primary key (COMPUTER_ID, HARDWARE_ID)
);

/*==============================================================*/
/* Index: HAS_HARDWARE_TO_HARDWARE_FK                           */
/*==============================================================*/
create index HAS_HARDWARE_TO_HARDWARE_FK on HAS_HARDWARE (
   HARDWARE_ID ASC
);

/*==============================================================*/
/* Index: COMPUTER_TO_HAS_HARDWARE_FK                           */
/*==============================================================*/
create index COMPUTER_TO_HAS_HARDWARE_FK on HAS_HARDWARE (
   COMPUTER_ID ASC
);

/*==============================================================*/
/* Table: INSTALLED_PROGRAM                                     */
/*==============================================================*/
create table INSTALLED_PROGRAM 
(
   PROGRAM_ID           INTEGER              not null,
   COMPUTER_ID          INTEGER              not null,
   constraint PK_INSTALLED_PROGRAM primary key (PROGRAM_ID, COMPUTER_ID)
);

/*==============================================================*/
/* Index: COMPUTER_TO_INSTALLED_PROGRAMS                        */
/*==============================================================*/
create index COMPUTER_TO_INSTALLED_PROGRAMS on INSTALLED_PROGRAM (
   COMPUTER_ID ASC
);

/*==============================================================*/
/* Index: INSTALLED_PROGARM_TO_PROGRAMS_                        */
/*==============================================================*/
create index INSTALLED_PROGARM_TO_PROGRAMS_ on INSTALLED_PROGRAM (
   PROGRAM_ID ASC
);

/*==============================================================*/
/* Table: PROGRAMS                                              */
/*==============================================================*/
create table PROGRAMS 
(
   PROGRAM_ID           INTEGER              not null,
   PROGRAM_NAME         VARCHAR2(20),
   constraint PK_PROGRAMS primary key (PROGRAM_ID)
);

/*==============================================================*/
/* Table: PROGRAM_HAS_PROPERTY                                  */
/*==============================================================*/
create table PROGRAM_HAS_PROPERTY 
(
   NAME                 VARCHAR2(20)         not null,
   PROGRAM_ID           INTEGER              not null,
   VALUE                VARCHAR2(20),
   constraint PK_PROGRAM_HAS_PROPERTY primary key (NAME, PROGRAM_ID)
);

/*==============================================================*/
/* Index: PROGRAM_HAS_PROPERTY2_FK                              */
/*==============================================================*/
create index PROGRAM_HAS_PROPERTY2_FK on PROGRAM_HAS_PROPERTY (
   PROGRAM_ID ASC
);

/*==============================================================*/
/* Index: PROGRAM_HAS_PROPERTY_TO_PROTER                        */
/*==============================================================*/
create index PROGRAM_HAS_PROPERTY_TO_PROTER on PROGRAM_HAS_PROPERTY (
   NAME ASC
);

/*==============================================================*/
/* Table: PROPERTIES                                            */
/*==============================================================*/
create table PROPERTIES 
(
   NAME                 VARCHAR2(20)         not null,
   DESCRIPTION          VARCHAR2(20),
   constraint PK_PROPERTIES primary key (NAME)
);

alter table HARDWARE_HAS_PROPERTY
   add constraint FK_HARDWARE_HARDWARE__HARDWARE foreign key (HARDWARE_ID)
      references HARDWARE (HARDWARE_ID);

alter table HARDWARE_HAS_PROPERTY
   add constraint FK_HARDWARE_HARDWARE__PROPERTI foreign key (NAME)
      references PROPERTIES (NAME);

alter table HAS_HARDWARE
   add constraint FK_HAS_HARD_COMPUTER__COMPUTER foreign key (COMPUTER_ID)
      references COMPUTER (COMPUTER_ID);

alter table HAS_HARDWARE
   add constraint FK_HAS_HARD_HAS_HARDW_HARDWARE foreign key (HARDWARE_ID)
      references HARDWARE (HARDWARE_ID);

alter table INSTALLED_PROGRAM
   add constraint FK_INSTALLE_COMPUTER__COMPUTER foreign key (COMPUTER_ID)
      references COMPUTER (COMPUTER_ID);

alter table INSTALLED_PROGRAM
   add constraint FK_INSTALLE_INSTALLED_PROGRAMS foreign key (PROGRAM_ID)
      references PROGRAMS (PROGRAM_ID);

alter table PROGRAM_HAS_PROPERTY
   add constraint FK_PROGRAM__PROGRAM_H_PROGRAMS foreign key (PROGRAM_ID)
      references PROGRAMS (PROGRAM_ID);

alter table PROGRAM_HAS_PROPERTY
   add constraint FK_PROGRAM__PROGRAM_H_PROPERTI foreign key (NAME)
      references PROPERTIES (NAME);

INSERT ALL
	INTO COMPUTER (COMPUTER_ID) VALUES (54647)
	INTO COMPUTER (COMPUTER_ID) VALUES (21222)
	INTO COMPUTER (COMPUTER_ID) VALUES (12412)

	INTO HARDWARE (HARDWARE_ID, MODEL, TYPE, VENDOR) VALUES (12412, 'KSMSA', 'CPU', 'INTEL')
	INTO HARDWARE (HARDWARE_ID, MODEL, TYPE, VENDOR) VALUES (14882, 'KSMSA3', 'CPU', 'INTEL')
	INTO HARDWARE (HARDWARE_ID, MODEL, TYPE, VENDOR) VALUES (19932, 'KSMSA2', 'CPU', 'INTEL')

	INTO PROGRAMS (PROGRAM_ID, PROGRAM_NAME) VALUES (87897, 'CALISTRA')	
	INTO PROGRAMS (PROGRAM_ID, PROGRAM_NAME) VALUES (82137, 'ORACLE')
	INTO PROGRAMS (PROGRAM_ID, PROGRAM_NAME) VALUES (843217, 'NAN1')


	INTO PROPERTIES (NAME, DESCRIPTION) VALUES ('Clock', 'this is clock')
	INTO PROPERTIES (NAME, DESCRIPTION) VALUES ('Price', 'this is price')
	INTO PROPERTIES (NAME, DESCRIPTION) VALUES ('Size', 'this is size')

	
SELECT * FROM dual;


















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

grant create any table to ASIMER;
grant insert any table to ASIMER;





/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
Select disctinct Order_item
from Orderitems
where item_price in (
  select max(item_price)
  from orderitems)








/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних імен покупців - назвавши це поле count_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT count(disctinct cust_name) as count_name
from customers








/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
PROJECT
Vendors TIMES ORDERITEMS TIMES PRODUCTS
WHERE VENDORS.vend_id=PRODUCTS.vend_id
{RENAME LOWER(vend_name) AS "vendor_name"}

MINUS

PROJECT
Vendors TIMES ORDERITEMS TIMES PRODUCTS
WHERE ORDERITEMS.prod_id=PRODUCTS.prod_id and
VENDORS.vend_id=PRODUCTS.vend_id;
{RENAME LOWER( vend_name) AS "vendor_name"}
