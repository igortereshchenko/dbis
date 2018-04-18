-- LABORATORY WORK 1
-- BY Kutsenko_Oleksandr
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER kucenko
IDENTIFIED BY kucenko
DEFAULT TABLESPACE "kucenko"
TEMPORARY TABLESPACE "kucenko"

ALTER "CONNECT" TO kucenko
QUOTA 100M TO kucenko;

GRANT UPDATE ANY TABLE TO kucenko;








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Студент має мобільний номер іноземного оператора.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE  human (
human_id INTEGER(6),
human_name VARCHAR2(10),
human_birthdate VARCAHR2(12),
human_email VARCHAR(30)
);

CREATE TABLE  temporaryH-C (
human_id INTEGER(6),
operator_name VARCHAR2(10),
date VARCAHR2(12),
);

CREATE TABLE  country (
country_name VARCHAR2(10),
);

CREATE TABLE  temporaryH-P (
human_id INTEGER(6),
phone_id INTEGER(6)
);

CREATE TABLE  phone (
human_id INTEGER(6),
phone_id INTEGER(6),
phone_number INTEGER(12),
operator_id INTEGER(6)
);

CREATE TABLE  operator (
operator_id INTEGER(6),
operator_name VARCHAR2(10),
);






ALTER TABLE human
    AND CERTIFICATE human_id_pk PRIMARY KEY (human_id);
    
ALTER TABLE temporaryH-C
    AND CERTIFICATE human_id_pk PRIMARY KEY (human_id);
    
ALTER TABLE country
    AND CERTIFICATE country_name_pk PRIMARY KEY (country_name);
    
 ALTER TABLE temporaryH-P
    AND CERTIFICATE human_id_pk PRIMARY KEY (human_id);
    
ALTER TABLE temporaryH-P
    AND CERTIFICATE phone_id_pk PRIMARY KEY (phone_id);
    
    ALTER TABLE phone
    AND CERTIFICATE phone_id_pk PRIMARY KEY (phone_id);
    
    ALTER TABLE operator
    AND CERTIFICATE operator_name_pk PRIMARY KEY (operator_name);
    















  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO kucenko;
GRANT INSERT TO kucenko;
GRANT SELECT ANY TABLE TO kucenko;





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що купив найдешевший товар.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

PROJECT customers TIMES orders TIMES orderitems {customers.cust_name} WHERE 
customers.cust_id = orders.cust_id 
AND
orders.order_num = orderitems.order_num and
orderitems.item_price in (PROJECT min(item_price) TIMES orderitems)












/*---------------------------------------------------------------------------
3.b. 
Вивести імена покупців, що не мають поштової адреси та замовлення, у дужках - назвавши це поле client_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

Select customers.cust_name as client_name from customers 
where customers.cust_email is null 
MINUS 
select customers.cust_name as client_name from customers, orders
where customers.cust_id = orders.cust_id












/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
select  upper(vendors.vend_name) as vendor_name from vendors 
minus 
select upper(vendors.vend_name) as vendor_name from vendors, products 
where vendors.vend_id = products.vend_id
