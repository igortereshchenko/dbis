-- LABORATORY WORK 1
-- BY Bilenko_Vladyslav
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
оновлювати дані в таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER bilenko IDENTIFIED BY bilenko;
DEFAULT TABLESPACE "user";
TEMPORARY TABLESPACE "temp";

ALTER "CONNECT" TO bilenko;
GRANT UPDATE ANY TABLE TO bilenko;







/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина дивиться кіно.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE people (
surname_person VARCHAR2(10),
age_person NUMBER(2));
ALTER TABLE people
  ADD CONSTRAINT surname_person_pk PRIMARY KEY (surname_person);
  
CREATE TABLE the_film (
name_film VARCHAR2(15),
time_film NUMBER(3, 2));
ALTER TABLE the_film
  ADD CONSTRAINT name_film_pk PRIMARY KEY (name_film);
  
CREATE TABLE people_watch_film (
name_person VARCHAR2(10),
sex_person VARCHAR(5));
ALTER TABLE people_watch_film
 ADD FOREIGN KEY name_person REFERENCE people (surname_person_pk);
















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO bilenko;
GRANT INSERT TO bilenko;
GRANT SELECT ANY TABLE TO bilenko;





/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
Select count(cust_id)
from orders
where order_num in (
select order_num
from orderitems
where item_price in(
select min(item_price)
from orderitems));














/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть постачальники має найдовшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

select vend_country
from vendors
where length(trim(vend_country)) in (
select max(length(trim(vend_country)))
from vendors);








/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

PROJECT CUSTOMERS, ORDERITEMS, ORDERS
WHERE (ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM and CUSTOMERS.CUST_ID = ORDERS.CUST_ID)
{DISTINCT RENAME trim(CUST_NAME)||' '||trim(CUST_COUNTRY) as "client_name"};
