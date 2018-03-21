-- LABORATORY WORK 1
-- BY Kanievskyi_Vladyslav
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти таблиці та робити запити з таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER VVV IDENTIFIED BY VVV
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
ALTER USER VVV QUOTA 100m ON USERS;
GRANT "CONNECT" TO VVV;
GRANT DROP ANY TABLE TO VVV;
GRANT ALTER ANY TABLE TO VVV;
GRANT CREATE ANY TABLE TO VVV;








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
На комп'ютері встановлено OS Windows.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE TABLE pizza
(
pizza_name VARCHAR2(10) NOT NULL
);
ALTER TABLE pizza
ADD CONSTRAINT pizza_name_pk PRIMARY KEY (pizza_name);
CREATE TABLE ing
(
ing_name VARCHAR2(10) NOT NULL
);
ALTER TABLE ing
ADD CONSTRAINT ing_name_pk PRIMARY KEY (pizza_name);
CREATE TABLE ing_pizza
(
ing_pizza_name VARCHAR2(10) NOT NULL,
pizza_name_fk VARCHAR2(10) NOT NULL,
ing_name_fk VARCHAR2(10) NOT NULL
);
ALTER TABLE ing_pizza
ADD CONSTRAINT ing_pizza_name_pk PRIMARY KEY (ing_pizza_name);
ALTER TABLE ing_pizza
ADD CONSTRAINT pizza_name1_fk FOREIGN KEY (pizza_name_fk) REFERENCES pizza(pizza_name);
ALTER TABLE ing_pizza
ADD CONSTRAINT ing_name1_fk FOREIGN KEY (ing_name_fk) REFERENCES pizza(ing_name);













  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:



GRANT CREATE ANY TABLE TO VVV;





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, що не купляли найдешевший товар.
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




SELECT cust_name
FROM (
SELECT cust_name,
CUSTOMERS.cust_id,
order_num
FROM CUSTOMERS,ORDERS
WHERE cust_address=null
and
CUSTOMERS.cust_id=order.cust_id
and
order_num<>null
);










/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що продають товар з найдовшим коментарем.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT UPPER(vendor_name) as vendor_name
FROM VENDORS,PRODUCTS
WHERE VENDORS.vend_id=PRODUCTS.vend_id
and
lenght(prod_desk)=97;

