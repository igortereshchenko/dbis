-- LABORATORY WORK 1
-- BY Hrydko_Oleksandr
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
робити вибірки з таблиць та оновлювати дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER hrydko
IDENTIFIED BY hrydko
DEFAULT tablespace "USERS"
TEMPORARY tablespace "TEMP";

ALTER USER hrydko
QUOTA 100M ON USERS;

GRANT "CONNECT" TO hrydko;

GRANT SELECT  ANY TABLE TO hrydko;
GRANT UPDATE ANY TABLE TO hrydko;





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
На вулиці стоїть будинок, що має 10 квартир.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE STREET 
(
  STREET_NAME VARCHAR2(20 BYTE) NOT NULL 
, STREET_NUMBER NUMBER(3, 0) NOT NULL 
, COUNTRY VARCHAR2(20 BYTE) NOT NULL 
, STREET_LENGTH NUMBER(3, 0) NOT NULL 
) ;


ALTER TABLE STREET
ADD CONSTRAINT STREET_name_pk PRIMARY KEY (STREET_NAME,STREET_NUMBER);

ALTER TABLE STREET
  ADD CONSTRAINT NAME_ CHECK (LENGTH(STREET_NAME)>0 );
  
ALTER TABLE STREET ADD CONSTRAINT U_S UNIQUE (STREET_NAME, STREET_NUMBER, COUNTRY, STREET_LENGTH );
  

  INSERT INTO STREET  (STREET_NAME,STREET_NUMBER,COUNTRY,STREET_LENGTH,COUNT_OF_HOUSES) 
  VALUES ( 'VASULKIVSKA','9','UKRAINE','5'
 );
 INSERT INTO STREET  (STREET_NAME,STREET_NUMBER,COUNTRY,STREET_LENGTH,COUNT_OF_HOUSES) 
  VALUES ( 'OLENUTELIHU','12','UKRAINE','4'
 );
 INSERT INTO STREET  (STREET_NAME,STREET_NUMBER,COUNTRY,STREET_LENGTH,COUNT_OF_HOUSES) 
  VALUES ( 'SHULIAVSKA','14','UKRAINE','9'
 );
--------------------------------------------------------------------------------
CREATE TABLE HOUSE 
(
  HOUSE_NUMBER NUMBER(3) NOT NULL 
, PEOPLE_ID NUMBER(12) NOT NULL 
, HOUSE_AREA NUMBER(5) NOT NULL 
, COUNT_OF_PEOPLE NUMBER(4) NOT NULL 
);

ALTER TABLE HOUSE
ADD CONSTRAINT house_name_pk PRIMARY KEY (HOUSE_NUMBER);

ALTER TABLE HOUSE
  ADD CONSTRAINT NAME2_ CHECK (HOUSE_AREA>0 );
  
ALTER TABLE HOUSE ADD CONSTRAINT U_H UNIQUE (HOUSE_AREA, HOUSE_NUMBER, PEOPLE_ID, COUNT_OF_PEOPLE );

 INSERT INTO HOUSE  (HOUSE_NUMBER, PEOPLE_ID, COUNT_OF_PEOPLE, HOUSE_AREA) 
  VALUES ( '1','1001','21','32'
 );
  INSERT INTO HOUSE  (HOUSE_NUMBER, PEOPLE_ID, COUNT_OF_PEOPLE, HOUSE_AREA) 
  VALUES ( '2','1002','43','87'
 );
  INSERT INTO HOUSE  (HOUSE_NUMBER, PEOPLE_ID, COUNT_OF_PEOPLE, HOUSE_AREA) 
  VALUES ( '3','1003','11','22'
 );
--------------------------------------------------------------------------------
CREATE TABLE STREET_ON_HOUSE 
(
  HOUSE_NUMBER NUMBER(3, 0) NOT NULL 
, STREET_NAME VARCHAR2(40 BYTE) NOT NULL 
, STREET_NUMBER NUMBER(4, 0) NOT NULL 
, count_of_HOUSE NUMBER(4, 0) NOT NULL 
) ;

ALTER TABLE STREET_ON_HOUSE
ADD CONSTRAINT STREET_ON_HOUSE_pk PRIMARY KEY (HOUSE_NUMBER,STREET_NAME,STREET_NUMBER);

  INSERT INTO STREET_ON_HOUSE (HOUSE_NUMBER, STREET_NAME, STREET_NUMBER,COUNT_OF_HOUSE) 
  VALUES ( '1','VASULKIVSKA','9','12'
 );
 
INSERT INTO STREET_ON_HOUSE (HOUSE_NUMBER, STREET_NAME, STREET_NUMBER,COUNT_OF_HOUSE) 
  VALUES ( '2','SHULIAVSKA','14','10'
 );
 INSERT INTO STREET_ON_HOUSE (HOUSE_NUMBER, STREET_NAME, STREET_NUMBER,COUNT_OF_HOUSE) 
  VALUES ( '3','OLENUTELIHU','12','21'
 );
--------------------------------------------------------------------------------
CREATE TABLE PEOPLE 
(
  PEOPLE_ID NUMBER(12, 0) NOT NULL 
, PEOPLE_NAME VARCHAR2(20 BYTE) NOT NULL 
, COUNTRY VARCHAR2(10 BYTE) NOT NULL 
, STREET_ADRESS VARCHAR2(20 BYTE) NOT NULL 
);


ALTER TABLE PEOPLE
ADD CONSTRAINT PEOPLE_pk PRIMARY KEY (PEOPLE_ID);

ALTER TABLE PEOPLE
  ADD CONSTRAINT NAME1_ CHECK (LENGTH(PEOPLE_NAME)>0 );
  
ALTER TABLE PEOPLE ADD CONSTRAINT U_P UNIQUE (PEOPLE_NAME, PEOPLE_ID, COUNTRY, STREET_ADRESS );

 INSERT INTO PEOPLE (PEOPLE_ID, PEOPLE_NAME, COUNTRY, STREET_ADRESS) 
  VALUES ( '1001','SASHA','UKARAINE','VASULKIVSKA'
 );
  INSERT INTO PEOPLE (PEOPLE_ID, PEOPLE_NAME, COUNTRY, STREET_ADRESS) 
  VALUES ( '1002','MUKOLA','UKARAINE','SHULIAVSKA'
 );
  INSERT INTO PEOPLE (PEOPLE_ID, PEOPLE_NAME, COUNTRY, STREET_ADRESS) 
  VALUES ( '1003','JON','UKARAINE','SHULIAVSKA'
 );
--------------------------------------------------------------------------------















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/

--Код відповідь:
GRANT SELECT ANY TABLE TO hrydko;
GRANT INSERT  ANY TABLE TO hrydko;
GRANT CREATE  ANY TABLE TO hrydko;






/*---------------------------------------------------------------------------
3.a. 
Який номер замовлення куди входить найдорожчий товар та яке ім'я покупця цього замовлення?
Виконати завдання в алгебрі Кодда.
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
PROJECT (ORDERITEMS, ORDERS, CUSTOMERS
WHERE ORDERITEMS.ITEM_PRICE IN (
PROJECT (ORDERITEMS) {MAX(ITEM_PRICE)}
)
AND CUSTOMERS.CUST_ID = ORDERS.CUST_ID
AND ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM)
{ORDERS.ORDER_NUM, CUSTOMERS.CUST_NAME};













/*---------------------------------------------------------------------------
3.b. 
Визначити скільки унікальних електронних адрес покупців - назвавши це поле count_email.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT COUNT(DISTINCT(CUST_EMAIL)) AS count_email
FROM customers;














/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у нижньому регістрі,назвавши це поле vendor_name, що мають товар, але його ніхто не купляв.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT LOWER(VENDORS.VEND_NAME) AS vendor_name
FROM VENDORS, PRODUCTS
WHERE VENDORS.VEND_ID = PRODUCTS.VEND_ID
AND PRODUCTS.PROD_ID NOT IN (
SELECT ORDERITEMS.PROD_ID
FROM ORDERITEMS
);



