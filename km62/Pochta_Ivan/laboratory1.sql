-- LABORATORY WORK 1
-- BY Pochta_Ivan
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
модифікувати таблиці та вставляти дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER pochta IDENTIFIED BY johnp
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
Alter user pochta QUota 100M on "USERS"; --додано в якості власного code review
GRANT "CONNECT" TO pochta;
GRANT ALTER ANY TABLE TO pochta;
GRANT INSERT ANY TABLE TO pochta;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент купляє квиток на потяг.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE STUDENT(
  student_id varchar(5) not null,
  student_name varchar(25) not null
);
ALTER TABLE STUDENT ADD CONSTRAINT student_pk PRIMARY KEY( student_id );

CREATE TABLE TICKET(
  ticket_id varchar(5) not null,
  train_id varchar(5) not null,
  customer_id varchar(5) not null
);
ALTER TABLE TICKET ADD CONSTRAINT ticket_pk PRIMARY KEY (ticket_id);
CREATE TABLE STUDENT_BUY_TICKET(
  student_fk varchar(5) not null,
  ticket_fk varchar(5) not null 
);
ALTER TABLE STUDENT_BUY_TICKET ADD CONSTRAINT sbt_pk PRIMARY KEY (ticket_fk);
ALTER TABLE STUDENT_BUY_TICKET  ADD CONSTRAINT sbt_student_fk FOREIGN KEY (student_fk) REFERENCES  STUDENT(student_id);
ALTER TABLE STUDENT_BUY_TICKET  ADD CONSTRAINT sbt_ticket_fk FOREIGN KEY (ticket_fk) REFERENCES  TICKET(ticket_id);
















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:


GRANT SELECT ANY TABLE to POCHTA;
GRANT ALTER ANY TABLE to pochta;
GRANT Create ANY TABLE to POCHTA;
GRANT INSERT ANY TABLE to pochta;









/*---------------------------------------------------------------------------
3.a. 
Якого товару найменше продано?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:















/*---------------------------------------------------------------------------
3.b. 
Скільки одиниць товару продано покупцям, що живуть в Америці?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT COUNT(*)
FROM (
  Select DISTINCt OrderItems.prod_id
  FROM OrderItems, Orders, Customers
  WHERE( OrderItems.order_num = Orders.order_num)
  AND ( Orders.cust_id = Customers.cust_id)
  AND ( Customers.cust_country = 'USA')
);
















/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників, що не продали жодного зі своїх продуктів.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
--SQL
SELECT vend_name 
FROM (
  SELECT vend_name, Vendors.vend_id
  FROM Vendors
  
  MINUS
  
  SELECT DISTINCT vend_name, Vendors.vend_id
  FROM Vendors, OrderItems, Orders, Products
  WHERE OrderItems.order_num = Orders.order_num
  AND OrderItems.prod_id = Products.prod_id
  AND Products.vend_id = Vendors.vend_id
);

--CODDA:
PROJECT (
( PROJECT(Vendors){vend_name, vend_id}) 
  MINUS 
  Project( (Vendors TIMES OrderItems) TIMES (Orders TIMES Products) ){vend_name, Vendors.vend_id} WHERE (OrderItems.order_num = Orders.order_num
  AND OrderItems.prod_id = Products.prod_id
  AND Products.vend_id = Vendors.vend_id) 
) {vend_name };

