-- LABORATORY WORK 1
-- BY Mozghovyi_Mykyta
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER student
IDENTIFIED BY P123
TEMPORARY TABLESPACE "USER";
GRANT CREATE TABLE TO student;
/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має мобільний номер іноземного оператора.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE student(
 student_name varchar(20) NOT NULL
);
CREATE TABLE mobile_operator(
  operator_name VARCHAR2(20) NOT NULL,
  user_name varchar(20),
  mobile_number NUMBER(10,0) NOT NULL,
  country VARCHAR2(20)
);
ALTER TABLE mobile_operator 
  ADD CONSTRAINT
  pk PRIMARY KEY(operator_name);
ALTER TABLE student 
  ADD CONSTRAINT
  fk FOREIGN KEY(country_fk,mobile_number_fk,operator_name_fk)
  REFERENCES mobile_operator(country,mobile_number,operator_name) ;
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 
---------------------------------------------------------------------------*/
--Код відповідь:
GRANT INSERT ANY TABLE TO student;
GRANT SELECT TO student;
/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
PROJECT CUSTOMERS TIMES ORDERITEMS TIMES ORDERS 
WHERE ITEM_PRICE IN 
  PROJECT ORDERITEMS MIN(ITEM_PRICE)
{CUST_NAME}
/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси та замовлення, у дужках - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT CUST_NAME AS "client_name"
FROM CUSTOMERS
WHERE CUST_ZIP=NULL
AND CUST_ID IN(
          SELECT CUST_ID
          FROM CUSTOMERS
          MINUS
          SELECT CUST_ID
          FROM ORDERS
          );
/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT VEND_NAME AS "vendor_name"
FROM VENDORS
WHERE VEND_ID IN(
          SELECT VEND_ID
          FROM VENDORS
          MINUS
          SELECT VEND_ID
          FROM PRODUCTS
          );
