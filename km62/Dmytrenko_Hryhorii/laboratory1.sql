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
/* Created on:     14.04.2018 17:30:52                          */
/*==============================================================*/

alter table Human_has_phone
   drop constraint FK_PHONE_OWNED_BY_HUMAN;

alter table Human_has_phone
   drop constraint FK_HUMAN_HAS_PHONE;

alter table Sim_card
   drop constraint FK_SIM_CARD1;

alter table Sim_card
   drop constraint FK_SIM_CARD2;

drop table Human cascade constraints;

drop index Human_has_phone_FK;

drop index Human_has_phone2_FK;

drop table Human_has_phone cascade constraints;

drop table Phone_type cascade constraints;

drop index second_sim_card_FK;

drop index First_sim_card_FK;

drop table Sim_card cascade constraints;

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

/*==============================================================*/
/* Table: Human_has_phone                                       */
/*==============================================================*/
create table Human_has_phone 
(
   phone_type_name      VARCHAR2(15)         not null,
   human_id             INTEGER              not null,
   constraint PK_HUMAN_HAS_PHONE primary key (phone_type_name, human_id)
);

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
   phone_type_name ASC
);

/*==============================================================*/
/* Table: Phone_type                                            */
/*==============================================================*/
create table Phone_type 
(
   phone_type_name      VARCHAR2(15)         not null,
   year_of_creation     INTEGER              not null,
   creator_name         VARCHAR2(20)         not null,
   country              VARCHAR2(15),
   constraint PK_PHONE_TYPE primary key (phone_type_name)
);

/*==============================================================*/
/* Table: Sim_card                                              */
/*==============================================================*/
create table Sim_card 
(
   human_id1_fk         INTEGER              not null,
   human_id2_fk         INTEGER              not null,
   sim_number           INTEGER              not null,
   constraint PK_SIM_CARD primary key (human_id1_fk, human_id2_fk, sim_number)
);

/*==============================================================*/
/* Index: First_sim_card_FK                                     */
/*==============================================================*/
create index First_sim_card_FK on Sim_card (
   human_id2_fk ASC
);

/*==============================================================*/
/* Index: second_sim_card_FK                                    */
/*==============================================================*/
create index second_sim_card_FK on Sim_card (
   human_id1_fk ASC
);

alter table Human_has_phone
   add constraint FK_PHONE_OWNED_BY_HUMAN foreign key (phone_type_name)
      references Phone_type (phone_type_name)
      on delete cascade;

alter table Human_has_phone
   add constraint FK_HUMAN_HAS_PHONE foreign key (human_id)
      references Human (human_id)
      on delete cascade;

alter table Sim_card
   add constraint FK_SIM_CARD1 foreign key (human_id2_fk)
      references Human (human_id)
      on delete cascade;

alter table Sim_card
   add constraint FK_SIM_CARD2 foreign key (human_id1_fk)
      references Human (human_id)
      on delete cascade;

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
        
