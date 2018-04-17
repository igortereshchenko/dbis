-- LABORATORY WORK 1
-- BY Kizim_Yevhenii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти дані з таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER KIZIM 
    IDENTIFIED BY lab_pass
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA 100M ON USERS;

GRANT "CONNECT" TO KIZIM;
GRANT DELETE ANY TABLE TO KIZIM; --???--








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Університет має факультети, що складаються з кафедр.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

/*
Опис створеної БД:
-Таблиця Universities зберігає університети, має поля ідентифікатору, назви, адреси та рівня акредитації. 

-Таблиця FACULTIES зберігає факультети та має звязок із Університетами: багато-до-одного відповідно. Це зумовлено тим, що
факультет без університету існувати не може. Має поля ідентифікатора, посилання на університет, назву факультету та дату 
заснування факультету.

-Таблиця DEANERIES зберігає деканати, має звязок із Факультетами типу один-до-одного, оскільки у кожного факультету є свій
деканат і тільки один. Існувати один без одного вони не можуть. Мають поля ідентифікатора, імені декану, адреси деканату
та номер телефону.

-Таблиця FACULTY_DEAN здійснює звязок деканатів та факультетів. Усі поля є унікальними

-Таблиця DEPARTMENTS зберігає усі кафедри університету. Таблиця має звязок багато-до-одногу із факультетами, оскільки кафедра
не може існувати без факультету, а факультет може містити більше однієї кафедри. Має поля ідентифікатора, ключ факултету, 
назви кафедри, імені завідувача кафедри та максимальна кількість студентів, що можуть бути прийняті на кафедру за один рік.

Обмеження та 
приклади значень наведені в коді.

*/

/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     17-Apr-18 22:26:42                           */
/*==============================================================*/


alter table DEPARTMENTS
   drop constraint FK_DEPARTME_FACULTY_H_FACULTIE;

alter table FACULTIES
   drop constraint FK_FACULTIE_UNIVERSIT_UNIVERSI;

alter table FACULTY_DEAN
   drop constraint FK_FACULTY__DEANERY_B_DEANERIE;

alter table FACULTY_DEAN
   drop constraint FK_FACULTY__FACULTY_H_FACULTIE;

drop table DEANERIES cascade constraints;

drop index FACULTY_HAS_DEPARTMENTS_FK;

drop table DEPARTMENTS cascade constraints;

drop index UNIVERSITY_HAS_FACULTIES_FK;

drop table FACULTIES cascade constraints;

drop index DEANERY_BELONGS_TO_FACULTY_FK;

drop index FACULTY_HAS_DEANERY_FK;

drop table FACULTY_DEAN cascade constraints;

drop table UNIVERSITIES cascade constraints;

/*==============================================================*/
/* Table: DEANERIES                                             */
/*==============================================================*/
create table DEANERIES 
(
   DEANERY_ID           INTEGER              not null,
   DEAN                 VARCHAR2(150)        not null,
   DEANERY_PHONE        NUMBER(15)           not null,
   DEANERY_ADDR         VARCHAR2(255)        not null,
   constraint PK_DEANERIES primary key (DEANERY_ID),
   constraint AK_DEANERY_UNIQUES unique (DEAN, DEANERY_ADDR),
   constraint AK_DEANERY_PHONE_UNIQUE unique (DEANERY_PHONE)
);

/*==============================================================*/
/* Table: DEPARTMENTS                                           */
/*==============================================================*/
create table DEPARTMENTS 
(
   DEPARTMENT_ID        INTEGER              not null,
   FACULTY_ID_FK        INTEGER,
   DEPARTMENT_NAME      VARCHAR2(150)        not null,
   DEPARTMENT_STUDENTS_QUOTA NUMBER(4)            not null,
   DEPARTMENT_HEAD      VARCHAR2(250)        not null,
   constraint PK_DEPARTMENTS primary key (DEPARTMENT_ID),
   constraint AK_DEPARTMENT_UNIQUES unique (DEPARTMENT_NAME, DEPARTMENT_HEAD)
);

/*==============================================================*/
/* Index: FACULTY_HAS_DEPARTMENTS_FK                            */
/*==============================================================*/
create index FACULTY_HAS_DEPARTMENTS_FK on DEPARTMENTS (
   FACULTY_ID_FK ASC
);

/*==============================================================*/
/* Table: FACULTIES                                             */
/*==============================================================*/
create table FACULTIES 
(
   FACULTY_ID           INTEGER              not null,
   UNIVER_ID_FK         INTEGER,
   FACULTY_NAME         VARCHAR2(150)        not null,
   FACLULTY_DATE_FOUNDATION DATE,
   constraint PK_FACULTIES primary key (FACULTY_ID),
   constraint AK_FACULTY_UNIQUES unique (FACULTY_NAME, FACLULTY_DATE_FOUNDATION)
);

/*==============================================================*/
/* Index: UNIVERSITY_HAS_FACULTIES_FK                           */
/*==============================================================*/
create index UNIVERSITY_HAS_FACULTIES_FK on FACULTIES (
   UNIVER_ID_FK ASC
);

/*==============================================================*/
/* Table: FACULTY_DEAN                                          */
/*==============================================================*/
create table FACULTY_DEAN 
(
   FACULTY_ID_FK        INTEGER              not null,
   DEANERY_ID_FK        INTEGER              not null
);

/*==============================================================*/
/* Index: FACULTY_HAS_DEANERY_FK                                */
/*==============================================================*/
create unique index FACULTY_HAS_DEANERY_FK on FACULTY_DEAN (
   FACULTY_ID_FK ASC
);

/*==============================================================*/
/* Index: DEANERY_BELONGS_TO_FACULTY_FK                         */
/*==============================================================*/
create unique index DEANERY_BELONGS_TO_FACULTY_FK on FACULTY_DEAN (
   DEANERY_ID_FK ASC
);

/*==============================================================*/
/* Table: UNIVERSITIES                                          */
/*==============================================================*/
create table UNIVERSITIES 
(
   UNIVER_ID            INTEGER              not null,
   UNIVER_NAME          VARCHAR2(250)        not null,
   UNIVER_ADDR          VARCHAR2(255)        not null,
   UNIVER_LEVEL         NUMBER(1)            not null,
   constraint PK_UNIVERSITIES primary key (UNIVER_ID),
   constraint AK_UNIVERSITY_UNIQUES unique (UNIVER_NAME, UNIVER_ADDR)
);

alter table DEPARTMENTS
   add constraint FK_DEPARTME_FACULTY_H_FACULTIE foreign key (FACULTY_ID_FK)
      references FACULTIES (FACULTY_ID);

alter table FACULTIES
   add constraint FK_FACULTIE_UNIVERSIT_UNIVERSI foreign key (UNIVER_ID_FK)
      references UNIVERSITIES (UNIVER_ID);

alter table FACULTY_DEAN
   add constraint FK_FACULTY__DEANERY_B_DEANERIE foreign key (DEANERY_ID_FK)
      references DEANERIES (DEANERY_ID);

alter table FACULTY_DEAN
   add constraint FK_FACULTY__FACULTY_H_FACULTIE foreign key (FACULTY_ID_FK)
      references FACULTIES (FACULTY_ID);


/*
=========================
MANUAL CONSTRAINTS
=========================
*/
ALTER TABLE DEANERIES 
    ADD CONSTRAINT DEAN_ID_CHECK CHECK (DEANERY_ID > 0);

ALTER TABLE DEANERIES 
    ADD CONSTRAINT DEAN_NAME_CHECK CHECK (REGEXP_LIKE(DEAN, '^([A-Z]{1}[a-z]{1,49} ){2}([A-Z]{1}[a-z]{1,49}$)'));
    
ALTER TABLE DEANERIES 
    ADD CONSTRAINT DEAN_PHONE_CHECK CHECK(REGEXP_LIKE(DEANERY_PHONE, '^\d{11,15}$'));
    
ALTER TABLE DEANERIES 
    ADD CONSTRAINT DEAN_ADDR_CHECK CHECK(REGEXP_LIKE(DEANERY_ADDR, '^[A-z,0-9 -.]{10,255}$'));
    
ALTER TABLE DEPARTMENTS 
    ADD CONSTRAINT DEP_ID_CHECK CHECK (DEPARTMENT_ID > 0);  

ALTER TABLE DEPARTMENTS
    ADD CONSTRAINT DEP_NAME_CHECK CHECK(REGEXP_LIKE(DEPARTMENT_NAME, '^[A-z -]{10,150}$'));

ALTER TABLE DEPARTMENTS
    ADD CONSTRAINT DEP_QUOTA_CHECK CHECK(REGEXP_LIKE(DEPARTMENT_STUDENTS_QUOTA, '^[0-9]{1,4}$'));
    
ALTER TABLE DEPARTMENTS
    ADD CONSTRAINT DEP_HEAD_CHECK CHECK(REGEXP_LIKE(DEPARTMENT_HEAD, '^([A-Z]{1}[a-z]{1,49} ){2}([A-Z]{1}[a-z]{1,49}$)'));
    
ALTER TABLE FACULTIES 
    ADD CONSTRAINT FACULTY_ID_CHECK CHECK (FACULTY_ID > 0);

ALTER TABLE FACULTIES
    ADD CONSTRAINT FACULTY_NAME_CHECK CHECK(REGEXP_LIKE(FACULTY_NAME, '^[A-z -]{10,150}$'));

ALTER TABLE FACULTIES
    ADD CONSTRAINT FACULTY_DATE_CHECK CHECK(FACLULTY_DATE_FOUNDATION > date '1900-01-01');
    
ALTER TABLE UNIVERSITIES 
    ADD CONSTRAINT UNIVER_ID_CHECK CHECK (UNIVER_ID > 0);  
    
ALTER TABLE UNIVERSITIES 
    ADD CONSTRAINT UNIVER_NAME_CHECK CHECK(REGEXP_LIKE(UNIVER_NAME, '^[A-z -\"]{10,250}$'));
    
ALTER TABLE UNIVERSITIES 
    ADD CONSTRAINT UNIVER_ADDR_CHECK CHECK(REGEXP_LIKE(UNIVER_ADDR, '^[A-z,0-9 -.]{10,255}$'));

ALTER TABLE UNIVERSITIES 
    ADD CONSTRAINT UNIVER_ACR_CHECK CHECK(4 >= UNIVER_LEVEL AND UNIVER_LEVEL >=1);

/*
====================
POPULATION
====================
*/

--- UNIVERSIIES ---
INSERT INTO UNIVERSITIES (UNIVER_ID, UNIVER_NAME, UNIVER_ADDR, UNIVER_LEVEL)
VALUES (1, 'NTUU "KPI"', 'UKRAINE, Kyiv', 4);

INSERT INTO UNIVERSITIES (UNIVER_ID, UNIVER_NAME, UNIVER_ADDR, UNIVER_LEVEL)
VALUES (2, 'Taras Shevchenko NKU', 'UKRAINE, Kyiv', 4);

INSERT INTO UNIVERSITIES (UNIVER_ID, UNIVER_NAME, UNIVER_ADDR, UNIVER_LEVEL)
VALUES (3, 'Poplavskii Colleage', 'Ukraine, Kyiv', 1);

--- FACULTIES ---
INSERT INTO FACULTIES (FACULTY_ID, FACULTY_NAME, FACLULTY_DATE_FOUNDATION, UNIVER_ID_FK) 
VALUES (1, 'Applied Mathematics', TO_DATE('1973-01-01', 'yyyy-mm-dd'), 1);

INSERT INTO FACULTIES (FACULTY_ID, FACULTY_NAME, FACLULTY_DATE_FOUNDATION, UNIVER_ID_FK) 
VALUES (2, 'Faculty of IT', TO_DATE('1991-01-01', 'yyyy-mm-dd'), 1);

INSERT INTO FACULTIES (FACULTY_ID, FACULTY_NAME, FACLULTY_DATE_FOUNDATION, UNIVER_ID_FK) 
VALUES (3, 'Svarka', TO_DATE('1901-01-01', 'yyyy-mm-dd'), 1);

--- DEANERIES ---
INSERT INTO DEANERIES (DEANERY_ID, DEAN, DEANERY_ADDR, DEANERY_PHONE)
VALUES (1, 'Dychka Olexandr Mykolajovich', 'Prospect Peremohy, 37K15', 380445553535); 
INSERT INTO FACULTY_DEAN (DEANERY_ID_FK, FACULTY_ID_FK)
VALUES(1,1);

INSERT INTO DEANERIES (DEANERY_ID, DEAN, DEANERY_ADDR, DEANERY_PHONE)
VALUES (2, 'David J Bowie', 'Prospect Peremohy, 37K18', 88005553535); 
INSERT INTO FACULTY_DEAN (DEANERY_ID_FK, FACULTY_ID_FK)
VALUES(2,2);

INSERT INTO DEANERIES (DEANERY_ID, DEAN, DEANERY_ADDR, DEANERY_PHONE)
VALUES (3, 'Kopychko Serhii Mykolajovich', 'Prospect Peremohy, 37K21', 380442281488); 
INSERT INTO FACULTY_DEAN (DEANERY_ID_FK, FACULTY_ID_FK)
VALUES(3,3);

--- DEPARTMENTS --- 
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, FACULTY_ID_FK, DEPARTMENT_NAME, DEPARTMENT_STUDENTS_QUOTA, DEPARTMENT_HEAD)
VALUES (1, 1, 'Applied Mathematics', 70, 'Chertov Oleg Romanovych');

INSERT INTO DEPARTMENTS (DEPARTMENT_ID, FACULTY_ID_FK, DEPARTMENT_NAME, DEPARTMENT_STUDENTS_QUOTA, DEPARTMENT_HEAD)
VALUES (2, 1, 'Program Engeneering', 50, 'Dychka Olexandr Mykolajovich');

INSERT INTO DEPARTMENTS (DEPARTMENT_ID, FACULTY_ID_FK, DEPARTMENT_NAME, DEPARTMENT_STUDENTS_QUOTA, DEPARTMENT_HEAD)
VALUES (3, 1, 'Computer Engeneering', 100, 'Ivanenko Vadym Mykolajovich');
















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO KIZIM;
GRANT INSERT ANY TABLE TO KIZIM;
GRANT SELECT ANY TABLE TO KIZIM;









/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

    
--Код відповідь:

SELECT DISTINCT ORDER_NUM
FROM ORDERITEMS
WHERE ITEM_PRICE IN (
    SELECT MIN(ITEM_PRICE)
    FROM ORDERITEMS);












/*---------------------------------------------------------------------------
3.b. 
Визначити скільки різних країн зберігається в таблиці CUSTOMERS - назвавши це поле country.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT COUNT("country") AS "country"
FROM
(SELECT DISTINCT CUSTOMERS.CUST_COUNTRY AS "country"
FROM CUSTOMERS);







/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар і його хтось купив.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

RENAME(
    PROJECT ((((VENDORS JOIN PRODUCTS)
        ON VENDORS.VEND_ID = PRODUCTS.VEND_ID)
    JOIN ORDERITEMS)
        ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID) {LOWER(VENDORS.VEND_NAME)}
) {LOWER(VENDORS.VEND_NAME) / "vendor_name"}
