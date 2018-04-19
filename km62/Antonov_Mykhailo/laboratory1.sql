-- LABORATORY WORK 1
-- BY Antonov_Mykhailo

/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
модифікувати таблиці та вставляти дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


-- USER SQL
CREATE USER antonov IDENTIFIED BY "antonov"  ;

-- QUOTAS
ALTER USER antonov QUOTA UNLIMITED ON SYSTEM;

-- ROLES

-- SYSTEM PRIVILEGES
GRANT ALTER ANY TABLE TO antonov ;
GRANT INSERT ANY TABLE TO antonov ;












/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент купляє квиток на потяг.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     19.04.2018 21:04:42                          */
/*==============================================================*/


alter table site_sells_ticket
   drop constraint FK_TIKET_TO_SITE;

alter table site_sells_ticket
   drop constraint FK_SITE_TO_TICKET;

alter table ticket
   drop constraint FK_TICKET_STUDENT;

drop table site cascade constraints;

drop index site_sells_ticket_FK;

drop index site_sells_ticket2_FK;

drop table site_sells_ticket cascade constraints;

drop table student cascade constraints;

drop index student_have_ticket_FK;

drop table ticket cascade constraints;

/*==============================================================*/
/* Table: site                                                  */
/*==============================================================*/
create table site 
(
   link_site            VARCHAR2(20)         not null,
   name_site            VARCHAR2(20)         not null,
   constraint PK_SITE primary key (link_site)
);

/*==============================================================*/
/* Table: site_sells_ticket                                     */
/*==============================================================*/
create table site_sells_ticket 
(
   link_site            VARCHAR2(20)         not null,
   id_ticket            NUMBER(10)           not null,
   price                NUMBER(10)           not null,
   constraint PK_SITE_SELLS_TICKET primary key (link_site, id_ticket)
);

/*==============================================================*/
/* Index: site_sells_ticket2_FK                                 */
/*==============================================================*/
create index site_sells_ticket2_FK on site_sells_ticket (
   id_ticket ASC
);

/*==============================================================*/
/* Index: site_sells_ticket_FK                                  */
/*==============================================================*/
create index site_sells_ticket_FK on site_sells_ticket (
   link_site ASC
);

/*==============================================================*/
/* Table: student                                               */
/*==============================================================*/
create table student 
(
   id_student           NUMBER(10)           not null,
   name_student         VARCHAR2(20)         not null,
   constraint PK_STUDENT primary key (id_student)
);

/*==============================================================*/
/* Table: ticket                                                */
/*==============================================================*/
create table ticket 
(
   id_ticket            NUMBER(10)           not null,
   id_student           NUMBER(10),
   train_ticket         NUMBER(10)           not null,
   constraint PK_TICKET primary key (id_ticket)
);

/*==============================================================*/
/* Index: student_have_ticket_FK                                */
/*==============================================================*/
create index student_have_ticket_FK on ticket (
   id_student ASC
);

alter table site_sells_ticket
   add constraint FK_TIKET_TO_SITE foreign key (link_site)
      references site (link_site);

alter table site_sells_ticket
   add constraint FK_SITE_TO_TICKET foreign key (id_ticket)
      references ticket (id_ticket);

alter table ticket
   add constraint FK_TICKET_STUDENT foreign key (id_student)
      references student (id_student);
      
alter table site
   add constraint name_site_un unique(name_site);

alter table site_sells_ticket
   add constraint price_above_zero check(price>0);
   
alter table site
add constraint link_site_check check (REGEXP_LIKE(link_site, '^[A-Za-z0-9]+(.){1}[a-z]{2,}'));

alter table site_sells_ticket
add constraint link_site_sells_check check (REGEXP_LIKE(link_site, '^[A-Za-z0-9]+(.){1}[a-z]{2,}'));  



INSERT INTO student(id_student,name_student) VALUES(10001,'Misha');
INSERT INTO student(id_student,name_student) VALUES(10002,'Grisha');
INSERT INTO student(id_student,name_student) VALUES(10003,'Egor');


INSERT INTO ticket(id_ticket,id_student,train_ticket) VALUES(112233,10002,10);
INSERT INTO ticket(id_ticket,id_student,train_ticket) VALUES(334466,10001,5);
INSERT INTO ticket(id_ticket,id_student,train_ticket) VALUES(990055,10001,8);

INSERT INTO site(link_site,name_site) VALUES('kpi.ua','KPI');
INSERT INTO site(link_site,name_site) VALUES('work.ua','work_ukraine');
INSERT INTO site(link_site,name_site) VALUES('bilet.ua','ticket_ua');

INSERT INTO site_sells_ticket(link_site,id_ticket,price) VALUES('bilet.ua',112233,200);
INSERT INTO site_sells_ticket(link_site,id_ticket,price) VALUES('bilet.ua',334466,100);
INSERT INTO site_sells_ticket(link_site,id_ticket,price) VALUES('kpi.ua',990055,450);





  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:


GRANT CREATE ANY TABLE TO antonov ;
GRANT SELECT ANY TABLE TO antonov ;


/*---------------------------------------------------------------------------
3.a. 
Якого товару найменше продано?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


SELECT PRODUCTS.PROD_NAME, PRODUCT_ID, PRODUCT_QUANTITY
FROM PRODUCTS JOIN (

SELECT ORDERITEMS.PROD_ID PRODUCT_ID, SUM(ORDERITEMS.QUANTITY) PRODUCT_QUANTITY
FROM ORDERITEMS
GROUP BY ORDERITEMS.PROD_ID
HAVING SUM(QUANTITY) IN (

SELECT MIN(SUM_QUANTITY) MIN_QUANTITY FROM(
SELECT ORDERITEMS.PROD_ID, SUM(ORDERITEMS.QUANTITY) SUM_QUANTITY 
FROM ORDERITEMS
GROUP BY ORDERITEMS.PROD_ID)))
ON PRODUCT_ID=PRODUCTS.PROD_ID;




/*---------------------------------------------------------------------------
3.b. 
Скільки одиниць товару продано покупцям, що живуть в Америці?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT SUM(ORDERITEMS.QUANTITY) SUM_QUANTITY_USA
FROM ORDERITEMS JOIN(

SELECT ORDER_NUM ORDERS_NUM
FROM ORDERS JOIN(

SELECT CUSTOMERS.CUST_ID CUSTOMERS_ID
FROM CUSTOMERS
WHERE CUST_COUNTRY = 'USA')
ON CUSTOMERS_ID = ORDERS.CUST_ID)
ON ORDERS_NUM = ORDERITEMS.ORDER_NUM;






/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників, що не продали жодного зі своїх продуктів.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


PROJECT VEND_NAME
{(PROJECT VENDORS.VEND_NAME , VENDORS.VEND_ID
{VENDORS}
MINUS
PROJECT VENDORS.VEND_NAME , VENDORS.VEND_ID
{VENDORS TIMES PRODUCTS}
WHERE PRODUCTS.VEND_ID = VENDORS.VEND_ID)};

