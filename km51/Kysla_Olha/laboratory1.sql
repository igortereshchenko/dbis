-- LABORATORY WORK 1
-- BY Kysla_Olha
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER OLGAKYSLA IDENTIFIED BY pass
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE  "TEMP";

ALTER USER OLGAKYSLA QUOTA 100M ON USERS;


GRANT CONNECT TO OLGAKYSLA;
GRANT CREATE ANY TABLE TO OLGAKYSLA ;




/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має мобільний номер іноземного оператора.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE STUDENTS(
    student_id_code INTEGER,
    city VARCHAR(50)
);
ALTER TABLE STUDENTS ADD CONSTRAINT stud_pk PRIMARY KEY (student_id_code);
ALTER TABLE STUDENTS ADD CONSTRAINT city_pk PRIMARY KEY (city);

CREATE TABLE OPERATORS(
      Code_operator INTEGER,
      
);
ALTER TABLE PHONE ADD CONSTRAINT Code_operator_pk PRIMARY KEY (Code_operator);


CREATE TABLE PHONE(
     phone_tel INTEGER,
     Code_operator_fk INTEGER,
     city_fk VARCHAR(50)
);
ALTER TABLE PHONE ADD CONSTRAINT phone_pk PRIMARY KEY (Code_operator_fk,city_fk);

ALTER TABLE PHONE ADD CONSTRAINT Code_operator_fk FOREIGN KEY OPERATORS(Code_operator) ;
ALTER TABLE PHONE ADD CONSTRAINT cityfk FOREIGN KEY STUDENTS (sity);


------------------------------------------------------------------------


/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     19.04.2018 3:05:13                           */
/*==============================================================*/


alter table phone_number
   drop constraint FK_OPERATOR_HAS_NUMBER;

alter table phone_number
   drop constraint FK_PHONE_HAS_NUMBER;

alter table students_has_phones
   drop constraint FK_PHONES_HAVE_STUDENTS;

alter table students_has_phones
   drop constraint FK_STUDENTS_HAVE_PHONES;

drop table operators cascade constraints;

drop index phone_number_FK;

drop index phone_number2_FK;

drop table phone_number cascade constraints;

drop table phones cascade constraints;

drop table students cascade constraints;

drop index students_has_phones_FK;

drop index students_has_phones2_FK;

drop table students_has_phones cascade constraints;

/*==============================================================*/
/* Table: operators                                             */
/*==============================================================*/
create table operators 
(
   oper_name            VARCHAR2(30)         not null,
   oper_code            VARCHAR2(10)         not null,
   constraint PK_OPERATORS primary key (oper_code)
);

/*==============================================================*/
/* Table: phone_number                                          */
/*==============================================================*/
create table phone_number 
(
   oper_code_fk         VARCHAR2(10)         not null,
   phone_id_fk          NUMBER(20)           not null,
   phone_number         NUMBER(10)           not null,
   phone_number_date    DATE                 not null,
   constraint PK_PHONE_NUMBER primary key (oper_code_fk, phone_id_fk, phone_number_date)
);

/*==============================================================*/
/* Index: phone_number2_FK                                      */
/*==============================================================*/
create index phone_number2_FK on phone_number (
   phone_id_fk ASC
);

/*==============================================================*/
/* Index: phone_number_FK                                       */
/*==============================================================*/
create index phone_number_FK on phone_number (
   oper_code_fk ASC
);

/*==============================================================*/
/* Table: phones                                                */
/*==============================================================*/
create table phones 
(
   phone_id             NUMBER(20)           not null,
   phone_type           VARCHAR2(30)         not null,
   constraint PK_PHONES primary key (phone_id)
);

/*==============================================================*/
/* Table: students                                              */
/*==============================================================*/
create table students 
(
   stud_id              NUMBER(20)           not null,
   stud_name            VARCHAR2(20)         not null,
   stud_surname         VARCHAR2(30)         not null,
   constraint PK_STUDENTS primary key (stud_id)
);

/*==============================================================*/
/* Table: students_has_phones                                   */
/*==============================================================*/
create table students_has_phones 
(
   phone_id_fk          NUMBER(20)           not null,
   stud_id_fk           NUMBER(20)           not null,
   stud_phone_date      DATE                 not null,
   constraint PK_STUDENTS_HAS_PHONES primary key (phone_id_fk, stud_id_fk, stud_phone_date)
);

/*==============================================================*/
/* Index: students_has_phones2_FK                               */
/*==============================================================*/
create index students_has_phones2_FK on students_has_phones (
   stud_id_fk ASC
);

/*==============================================================*/
/* Index: students_has_phones_FK                                */
/*==============================================================*/
create index students_has_phones_FK on students_has_phones (
   phone_id_fk ASC
);

alter table phone_number
   add constraint FK_OPERATOR_HAS_NUMBER foreign key (oper_code_fk)
      references operators (oper_code)
      on delete cascade;

alter table phone_number
   add constraint FK_PHONE_HAS_NUMBER foreign key (phone_id_fk)
      references phones (phone_id)
      on delete cascade;

alter table students_has_phones
   add constraint FK_PHONES_HAVE_STUDENTS foreign key (phone_id_fk)
      references phones (phone_id)
      on delete cascade;

alter table students_has_phones
   add constraint FK_STUDENTS_HAVE_PHONES foreign key (stud_id_fk)
      references students (stud_id)
      on delete cascade;
      
      
----------------------------------------------------------------------------------------
ALTER TABLE phone_number ADD CONSTRAINT phone_number_unique UNIQUE (phone_number);

ALTER TABLE students
  ADD CONSTRAINT check_stud_id
  CHECK (stud_id>0);

ALTER TABLE students
  ADD CONSTRAINT check_stud_name
  CHECK ( REGEXP_LIKE (stud_name, '[A-Z][a-z]{1,19}'));

ALTER TABLE students
  ADD CONSTRAINT check_stud_surname
  CHECK ( REGEXP_LIKE (stud_surname, '[A-Z][a-z]{1,29}'));

ALTER TABLE phones
  ADD CONSTRAINT check_phone_id
  CHECK ( phone_id >0);

ALTER TABLE phones
  ADD CONSTRAINT check_phone_type
  CHECK ( REGEXP_LIKE (phone_type, '[A-Za-z]{1,10}\d{1,10}'));

ALTER TABLE operators
  ADD CONSTRAINT check_oper_name
  CHECK ( REGEXP_LIKE (oper_name, '[A-Z][a-z]{1,29}'));
  
ALTER TABLE operators
  ADD CONSTRAINT check_oper_code
  CHECK ( REGEXP_LIKE (oper_code, '0\d{2}'));

ALTER TABLE students_has_phones
  ADD CONSTRAINT check_stud_phone_date
  CHECK ( REGEXP_LIKE (stud_phone_date, '[0-9]{2}\.[0-9]{2}\.[0-9]{2}'));

ALTER TABLE phone_number 
  ADD CONSTRAINT check_phone_number_date
  CHECK ( REGEXP_LIKE (phone_number_date, '[0-9]{2}\.[0-9]{2}\.[0-9]{2}'));
-------------------------------------------------------------------------------------
INSERT INTO OPERATORS (OPER_NAME, OPER_CODE) VALUES ('life', '063');
INSERT INTO OPERATORS (OPER_NAME, OPER_CODE) VALUES ('kyiv', '076');
INSERT INTO OPERATORS (OPER_NAME, OPER_CODE) VALUES ('mts', '086');

INSERT INTO PHONE_NUMBER( OPER_CODE_FK,PHONE_ID_FK,PHONE_NUMBER,PHONE_NUMBER_DATE) VALUES ('063', '12', '10','10.12.18');
INSERT INTO PHONE_NUMBER( OPER_CODE_FK,PHONE_ID_FK,PHONE_NUMBER,PHONE_NUMBER_DATE) VALUES ('093', '11', '15','10.16.18');
INSERT INTO PHONE_NUMBER( OPER_CODE_FK,PHONE_ID_FK,PHONE_NUMBER,PHONE_NUMBER_DATE) VALUES ('076', '22', '13','11.12.18');

INSERT INTO PHONES ( PHONE_ID, PHONE_TYPE) VALUES ('1', 'gts5360');
INSERT INTO PHONES ( PHONE_ID, PHONE_TYPE) VALUES ('2', 'gtl5260');
INSERT INTO PHONES ( PHONE_ID, PHONE_TYPE) VALUES ('3', 'gtk5361');

INSERT INTO STUDENTS (STUD_ID,STUD_NAME, STUD_SURNAME) VALUES ('1', 'ola','kysla');
INSERT INTO STUDENTS (STUD_ID,STUD_NAME, STUD_SURNAME) VALUES ('2', 'sofa','shymel');
INSERT INTO STUDENTS (STUD_ID,STUD_NAME, STUD_SURNAME) VALUES ('3', 'anna','kysina');

INSERT INTO STUDENTS_HAS_PHONES(PHONE_ID_FK,STUD_ID_FK,STUD_PHONE_DATE ) VALUES ('1', '1','15.02.18');
INSERT INTO STUDENTS_HAS_PHONES(PHONE_ID_FK,STUD_ID_FK,STUD_PHONE_DATE ) VALUES ('5', '5','16.02.17');
INSERT INTO STUDENTS_HAS_PHONES(PHONE_ID_FK,STUD_ID_FK,STUD_PHONE_DATE ) VALUES ('4', '6','19.03.18');





  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO OLGAKYSLA ;
GRANT SELECT ANY TABLE TO OLGAKYSLA ;
GRANT INSERT ANY TABLE TO OLGAKYSLA ;





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/
select (customers.cust_name)
from customers, orders, orderitems 
where (orders.ORDER_NUM = orderitems.ORDER_NUM) 
    and (customers.cust_id = orders.cust_id)
    and (item_price = (Select min(item_price) from orderitems ));

--Код відповідь:

 












/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси та замовлення, у дужках - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT cust_name as client_name
FROM CUSTOMERS, ORDERS 
WHERE (CUSTOMERS.CUST_ID != ORDERS.CUST_ID) AND CUST_ADDRESS = NULL;



/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

select distinct upper (vend_name) as vendor_name
from vendors, products, orderitems
where Vendors.vend_id = Products.vend_id AND Products.prod_id = Orderitems.prod_id ;
