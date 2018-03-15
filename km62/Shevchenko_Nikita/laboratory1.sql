-- LABORATORY WORK 1
-- BY Shevchenko_Nikita
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці та видаляти з них дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
--USER SQL
CREATE USER SHEVCHENKO IDENTIFIED BY DOPKA
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
-- QUOTAS
ALTER USER SHEVCHENKO QUOTA 200M ON USERS;
-- ROLES
GRANT "CONNECT" TO SHEVCHENKO ;

-- SYSTEM PRIVILEGES
GRANT DELETE ANY TABLE TO SHEVCHENKO ;
GRANT CREATE ANY TABLE TO SHEVCHENKO ;









/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент здає роботу викладачу.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE MY_STUDENT(
  student_name VARCHAR2(20) NOT NULL
);

ALTER TABLE MY_STUDENT
  add CONSTRAINT pk_name PRIMARY KEY (student_name);

CREATE TABLE MY_MARK(
  db_mark INTEGER NOT NULL
);
ALTER TABLE MY_MARK
  add CONSTRAINT pk_mark PRIMARY KEY (db_mark);

CREATE TABLE MY_ADDSESSION(
  student_name_fk VARCHAR2(20) NOT NULL,
  db_mark_fk INTEGER NOT NULL,
  count_of_add_sessions INTEGER NOT NULL
);
ALTER TABLE MY_ADDSESSION
 ADD CONSTRAINT pk_set PRIMARY KEY (student_name_fk, db_mark_fk);
  
ALTER TABLE MY_ADDSESSI0N
 ADD CONSTRAINT fk_name_set FOREIGN KEY(student_name_fk) REFERENCES STUDENT(student_name);

ALTER TABLE MY_ADDSESSI0N
  ADD  CONSTRAINT fk_mark_set FOREIGN KEY(db_mark_fk) REFERENCES MARK(db_mark);





  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO SHEVCHENKO






/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, що купляли найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUST_NAME FROM CUSTOMERS WHERE CUSTOMERS.CUST_ID IN (SELECT CUST_ID FROM ORDERS WHERE ORDERS.ORDER_NUM IN (SELECT ORDER_NUM FROM ORDERITEMS WHERE ORDERITEMS.ITEM_PRICE = min(ORDERITEMS.ITEM_PRICE)));















/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:















/*---------------------------------------------------------------------------
c. 
Вивести імена покупців у верхньому регістрі,назвавши це поле customer_name, що не купили жодного товару, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

