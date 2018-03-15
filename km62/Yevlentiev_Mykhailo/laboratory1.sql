-- LABORATORY WORK 1
-- BY Yevlentiev_Mykhailo
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці та видаляти з них дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER evlentiev IDENTIFIED BY love_sql
DEFAULT TABLESPACE "USERS" TO evlentiev
TEMPERARY TABLESPACE "TEMP" TO evlentiev

ALTER "CONNECT" TO evlentiev
ALTER CREATE ANY TABLE TO evlentiev
ALTER DROP ANY TABLE TO evlentiev








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент здає роботу викладачу.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE STUDENT(
  sudent_name VARCHAR2(30)
);
ALTER TABLE STUDENT
  ADD CONSTRAIN student_pk PRIMERY KEY (student_name)


CREATE TABLE TASK(
  task_name VARCHAR2(30)
);

ALTER TABLE STUDENT
  ADD CONSTRAIN task_pk PRIMERY KEY (task_name)

CREATE TABLE STUDENT_TASK(
  task_name_fk VARCHAR2(30),
  sudent_name_fk VARCHAR2(30),
  marks NUMBER(100)
);

ALTER TABLE STUDENT_TASK
  ADD CONSTRAIN student_task_pk PRIMERY KEY (task_name_fk,student_name_fk)
  
ALTER TABLE STUDENT_TASK
  ADD CONSTRAIN student_fk FOREIN KEY (student_name) REFERENCES STUDENT  
  
ALTER TABLE STUDENT_TASK
  ADD CONSTRAIN task_fk FOREIN KEY (task_name) REFERENCES TASK 
  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

ALTER INSERT ANY TABLE TO evlentiev
ALTER SELECT ANY TABLE TO evlentiev





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, що купляли найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:














/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT 
  USER_EMAIL IS NULL
  AND
  USER_ORDERS 
FROM CUSTOMERS
/*---------------------------------------------------------------------------
c. 
Вивести імена покупців у верхньому регістрі,назвавши це поле customer_name, що не купили жодного товару, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT
  CUSTOMERS AS "customer_name"
  









