-- LABORATORY WORK 1
-- BY Kolobaieva_Kateryna
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
оновлювати дані в таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER kolobaieva IDENTIFIED BY To kolobaieva
DEFAULT TABLESPACE 'USERS'
TIMEPORARY TABLESPACE 'TEMP'

ALTER USER kolobaieva QUOTA 100M ON 'USERS'

GRAND 'CONNECT' To kolobaieva

GRAND UPDATE ANY TABLES To kolobaieva





/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина дивиться кіно.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE films
( 
   type_of char(30) NOT NULL,
   release_of numeric(4),
   building_adress varchar2(40)
);
ALTER TABLE films ADD CONSTRAINT films_pk PRIMARY KEY (type_of);

CREATE TABLE serials
(
   type_of char(30) NOT NULL,
   release_of numeric(4),
   building_adress varchar2(40)
   
);
ALTER TABLE serials ADD CONSTRAINT serials_pk PRIMARY KEY (type_of);

CREATE TABLE buildings
(
   building_adress varchar2(40) NOT NULL,
   number_of_floors numeric(10),
);
ALTER TABLE buildings ADD CONSTRAINT buildings_pk PRIMARY KEY (building_adress);

CREATE TABLE place(
    place_type varchar2(40) not null,
    building_adress varchar2(40) not null
);

ALTER TABLE  place
  ADD CONSTRAINT place_pk PRIMARY KEY ( place_type, building_adress);  
  
ALTER TABLE  place
  ADD CONSTRAINT films_fk FOREIGN KEY (films_fk) REFERENCES films (place_type, building_adress);
  
ALTER TABLE  place
  ADD CONSTRAINT serials_fk FOREIGN KEY (serials_fk) REFERENCES serials (place_type, building_adress);
  
  
CREATE SEQUENCE place_seq
START WITH 1
INCREMENT BY 1;










  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO kolobaieva
GRANT SELECT ANY TABLE TO kolobaieva
GRANT ALTER ANY TABLE TO kolobaieva




/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT
COUNT(customers.cust_id) amount_cust_with_min_price
FROM customers, orders, orderitems 
WHERE customers.cust_id = orders.cust_id 
AND orders.order_num = orderitems.order_num
AND item_price = (SELECT min(item_price) FROM orderitems);













/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть постачальники має найдовшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT VEND_COUNTY 
FROM VENDORS
WHERE LENGTH OF VEND_COUNTRY = MAX IN (
ALTER TABLE VENDORS 
SELECT VEND_COUNTRY );













/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT "client_name" from
(SELECT DISTINCT (trim(CUST_NAME)||' '||trim(CUST_COUNTRY) )AS "client_name", CUSTOMERS.CUST_ID
from CUSTOMERS, ORDERITEMS, ORDERS
where(ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
AND ORDERITEMS.QUANTITY >0
and CUSTOMERS.CUST_ID = ORDERS.CUST_ID));
