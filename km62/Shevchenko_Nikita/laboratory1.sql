-- LABORATORY WORK 1
-- BY Shevchenko_Nikita
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці та видаляти з них дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
--USER SQL
CREATE USER SHEVCHENKO IDENTIFIED BY "KOMI$$IY@"
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
  id INTEGER NOT NULL;
  student_name VARCHAR2(20) NOT NULL
);

ALTER TABLE MY_STUDENT
  add CONSTRAINT pk_name PRIMARY KEY (id);

CREATE TABLE TEACHER(
  id INTEGER NOT NULL;
  birthday DATE NOT NULL;
  name VARCHAR2(40) NOT NULL;
  phone_number INTEGER(10);
  mark INTEGER;
);

ALTER TABLE TEACHER
  ADD CONSTRAINT pk_teacher PRIMARY KEY(id);
  
CREATE TABLE ASSESMENTS(
  id INTEGER NOT NULL;
  student_id INTEGER NOT NULL;
  teacher_id INTEGER NOT NULL;
  mark INTEGER;
);
 
ALTER TABLE ASSESMENTS
  ADD CONSTRAINT ass_id PRIMARY KEY(id)

ALTER TABLE ASSESMENTS
 ADD CONSTRAINT stud_id FOREIGN KEY(student_id) REFERENCES STUDENT(id);

ALTER TABLE ASSESMENTS
  ADD  CONSTRAINT teach_id FOREIGN KEY(teacher_id) REFERENCES TEACHER(id);

  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT INSERT ANY TABLE TO SHEVCHENKO


/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, що купляли найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT cust_name (customers)
where cust_id in (PROJECT orders.cust_id ((orders TIMES orderitems) TIMES products)
                 where orders.order_num = orderitems.order_num
                 and products.PROD_ID = orderitems.PROD_ID
                 and products.PROD_price = (PROJECT min(prod_price)  (products)));


/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

select cust_name from customers, orders
where (customers.cust_zip is null)
and customers.cust_id = orders.cust_id


/*---------------------------------------------------------------------------
c. 
Вивести імена покупців у верхньому регістрі,назвавши це поле customer_name, що не купили жодного товару, але мають замовлення.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

select upper(cust_name) cust_name from customers
where cust_id in (select orders.cust_id from orders, orderitems
                 where orders.order_num = orderitems.order_num
                 and ORDERITEMS.QUANTITY in (null, 0))
