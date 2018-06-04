-- LABORATORY WORK 1
-- BY Kondratiuk_Andrii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
модифікувати таблиці та вставляти дані
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
--SQL USER
CREATE USER kondratyuk IDENTIFIED BY 1111
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
--QUOUTE
ALTER USER kondratyuk QUOTA 100M ON "USERS";
--CONNECTION
GRANT "CONNECT" TO kondratyuk;
--GRANTED
GRANT ALTER ANY TABLE TO kondratyuk; 
GRANT DELETE ANY TABLE TO kondratyuk;
GRANT INSERT ANY TABLE TO kondratyuk;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент купляє квиток на потяг.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE STUDENT
    (student_name VARCHAR2(30) NOT NULL);
ALTER TABLE STUDENT















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT CREATE ANY TABLE TO kondratyuk;
GRANT SELECT ANY TABLE TO kondratyuk;

/*---------------------------------------------------------------------------
3.a. 
Якого товару найменше продано?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:
--Завдання має нечіткі границі розуміння, тому виконано в двох варіантах.

--Виводиться найменше проданого товару за одне замовлення:
SELECT DISTINCT orderitems.prod_id, orderitems.quantity FROM orderitems
WHERE orderitems.quantity IN (SELECT MIN(orderitems.quantity) FROM orderitems);

--Виводиться найменше проданого товару зі всіх зроблених замовлень, без GROUP BY цей варіант не можливо виконати:
SELECT prod_id, "amount" FROM 
(
  SELECT orderitems.prod_id, SUM(orderitems.quantity) as "amount" FROM orderitems 
  GROUP BY orderitems.prod_id
) 
WHERE "amount" IN 
(
  SELECT MIN("amount") FROM 
  (
    SELECT orderitems.prod_id, SUM(orderitems.quantity) as "amount" FROM orderitems 
    GROUP BY orderitems.prod_id
  )
);

/*---------------------------------------------------------------------------
3.b. 
Скільки одиниць товару продано покупцям, що живуть в Америці?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT SUM(quantity) FROM 
( 
  SELECT orderitems.quantity FROM orderitems, orders, customers 
  WHERE(orderitems.order_num = orders.order_num)
  AND (orders.cust_id = customers.cust_id) 
  AND (customers.cust_country = 'USA')
);

/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників, що не продали жодного зі своїх продуктів.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
PROJECT((PROJECT(vendors){vend_name, vend_id}){vend_name}
MINUS
PROJECT DISTINCT (PROJECT DISTINCT(products TIMES vendors TIMES orderitems)
{vendors.vend_name, products.vend_id, orderitems.prod_id}
WHERE (products.prod_id = orderitems.prod_id) 
AND products.vend_id = vendors.vend_id)){vend_name, vend_id};
