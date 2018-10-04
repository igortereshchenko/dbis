-- LABORATORY WORK 1
-- BY Dmytrenko_Hryhorii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти та вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER dmytrenko IDENTIFIED BY password
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TABLE";

GRANT "CONNECT" TO dmytrenko

ALTER USER dmytrenko QUOTA 100M ON USERS;

GRANT DROP ANY TABLE TO dmytrenko;
GRANT INSERT ANY TABLE TO dmytrenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина купляє певну марку телефону.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     14.04.2018 19:05:50                          */
/*==============================================================*/

/*==============================================================*/
/* Table: Human                                                 */
/*==============================================================*/
create table Human 
(
   human_id             INTEGER              not null,
   human_name           VARCHAR2(20)         not null,
   human_sex            VARCHAR2(6)          not null,
   human_age            INTEGER              not null,
   human_country        VARCHAR2(15)         not null,
   constraint PK_HUMAN primary key (human_id)
);

ALTER TABLE Human
ADD CONSTRAINT human_unique UNIQUE (human_id);

ALTER TABLE Human
ADD CONSTRAINT check_human_name
  CHECK (length(human_name)&gt;2);
  
 ALTER TABLE Human
ADD CONSTRAINT check_human_country
  CHECK (length(human_country)&gt;3);

/*==============================================================*/
/* Table: Human_has_phone                                       */
/*==============================================================*/
create table Human_has_phone 
(
   phone_id             INTEGER              not null,
   human_id             INTEGER              not null,
   constraint PK_HUMAN_HAS_PHONE primary key (phone_id, human_id)
);

ALTER TABLE Human_has_phone
ADD CONSTRAINT human_phone_unique UNIQUE (human_id, phone_id);

/*==============================================================*/
/* Index: Human_has_phone2_FK                                   */
/*==============================================================*/
create index Human_has_phone2_FK on Human_has_phone (
   human_id ASC
);

/*==============================================================*/
/* Index: Human_has_phone_FK                                    */
/*==============================================================*/
create index Human_has_phone_FK on Human_has_phone (
   phone_id ASC
);

/*==============================================================*/
/* Table: Phone_type                                            */
/*==============================================================*/
create table Phone_type 
(
   phone_id             INTEGER              not null,
   phone_type_name      VARCHAR2(15)         not null,
   year_of_creation     INTEGER,
   creator_name         VARCHAR2(20)         not null,
   country              VARCHAR2(15),
   constraint PK_PHONE_TYPE primary key (phone_id)
);

ALTER TABLE Phone_type
ADD CONSTRAINT phone_type_unique UNIQUE (phone_id);

ALTER TABLE Phone_type
ADD CONSTRAINT check_year_of_creation
  CHECK (year_of_creation >= 2000);

/*==============================================================*/
/* Table: Сolleague                                             */
/*==============================================================*/
create table Сolleague 
(
   colleague_id1_fk     INTEGER              not null,
   colleague_id2_fk     INTEGER              not null,
   colleague_date       DATE                 not null,
   constraint PK_СOLLEAGUE primary key (colleague_id1_fk, colleague_id2_fk, colleague_date)
);

ALTER TABLE Сolleague 
ADD CONSTRAINT colleague_unique UNIQUE (colleague_date);

/*==============================================================*/
/* Index: second_colleague_FK                                   */
/*==============================================================*/
create index second_colleague_FK on Сolleague (
   colleague_id2_fk ASC
);

/*==============================================================*/
/* Index: first_colleague_FK                                    */
/*==============================================================*/
create index first_colleague_FK on Сolleague (
   colleague_id1_fk ASC
);

alter table Human_has_phone
   add constraint FK_PHONE_OWNED_BY_HUMAN foreign key (phone_id)
      references Phone_type (phone_id)
      on delete cascade;

alter table Human_has_phone
   add constraint FK_HUMAN_HAS_PHONE foreign key (human_id)
      references Human (human_id)
      on delete cascade;

alter table Сolleague
   add constraint FK_СOLLEAGUE1 foreign key (colleague_id1_fk)
      references Human (human_id)
      on delete cascade;

alter table Сolleague
   add constraint FK_СOLLEAGUE2 foreign key (colleague_id2_fk)
      references Human (human_id)
      on delete cascade;


/* Create human */

INSERT INTO Human (human_id, human_name, human_sex, human_age, human_country) 
  VALUES ('210023422', 'Robert', 'm', '34', 'Belgium');

INSERT INTO Human (human_id, human_name, human_sex, human_age, human_country) 
  VALUES ('238470932', 'Bob', 'm', '21', 'Austria');

INSERT INTO Human (human_id, human_name, human_sex, human_age, human_country) 
  VALUES ('934862897', 'Monica', 'f', '26', 'USA');

INSERT INTO Human (human_id, human_name, human_sex, human_age, human_country) 
  VALUES ('883456765', 'Richard', 'm', '19', 'Great Britain');

/* Create Phone_type */

INSERT INTO Phone_type (phone_id, phone_type_name, year_of_creation, creator_name, country) 
   VALUES ('9234683', 'Pixel 2 XL', '2017', 'Google', 'USA');
   
INSERT INTO Phone_type (phone_id, phone_type_name, year_of_creation, creator_name, country) 
   VALUES ('5400218', 'Galaxy S9', '2018', 'Samsung', 'South Korea');
   
INSERT INTO Phone_type (phone_id, phone_type_name, year_of_creation, creator_name, country) 
   VALUES ('6744923', 'P20 PRO', '2018', 'Huawei', 'China');
   
INSERT INTO Phone_type (phone_id, phone_type_name, year_of_creation, creator_name, country) 
   VALUES ('2758091', 'iPhone X', '2017', 'Apple', 'USA');

/* Add phone_types to Human_has_phone */

INSERT INTO Human_has_phone (phone_id, human_id)
   VALUES ('6744923','238470932');
   
INSERT INTO Human_has_phone (phone_id, human_id)
   VALUES ('2758091', '883456765');

INSERT INTO Human_has_phone (phone_id, human_id)
   VALUES ('9234683', '934862897');

INSERT INTO Human_has_phone (phone_id, human_id)
   VALUES ('5400218', '210023422' );

/* Create Colleague */

INSERT INTO Colleague (colleague_id1_fk, colleague_id2_fk, colleague_date) 
  VALUES ('238470932', '883456765', TO_DATE('2009-04-23', 'YYYY-MM-DD'));
  
INSERT INTO Colleague (colleague_id1_fk, colleague_id2_fk, colleague_date) 
  VALUES ('883456765', '210023422', TO_DATE('1989-06-14', 'YYYY-MM-DD') );
  
INSERT INTO Colleague (colleague_id1_fk, colleague_id2_fk, colleague_date) 
  VALUES ('934862897', '238470932', TO_DATE('1977-12-28', 'YYYY-MM-DD'));
  
INSERT INTO Colleague (colleague_id1_fk, colleague_id2_fk, colleague_date) 
  VALUES ('210023422', '238470932', TO_DATE('2014-08-17', 'YYYY-MM-DD'));

/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO dmytrenko
GRANT ALTER ANY TABLE TO dmytrenko
GRANT SELECT ANY TABLE TO dmytrenko;

/*---------------------------------------------------------------------------
3.a. 
Яка ціна найдорожчого товару, що нікому не було продано?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT Products
WHERE Products.prod_id IN
(PROJECT Products { Products.prod_id }
MINUS
PROJECT Orderitems { Orderitems.prod_id })
{ MAX(Products.prod_price)}

/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT CUST_NAME AS Customer_name
FROM CUSTOMERS, ORDERITEMS, ORDERS
    WHERE ORDERS.CUST_ID = CUSTOMERS.CUST_ID
    AND ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
    AND ORDERITEMS.ITEM_PRICE in (Select max(ITEM_PRICE) From ORDERITEMS);

/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну постачальника, як єдине поле vendor_name, для тих остачальників, що не мають товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT (TRIM(Vendors.vend_name) || ' ' || TRIM(Vendors.vend_country)) as vendor_name
FROM Vendors
    WHERE Vendors.vend_id IN (
        SELECT Vendors.vend_id
        FROM Vendors    
            MINUS        
        SELECT Products.vend_id
        FROM Products);
        
