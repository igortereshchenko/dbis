-- LABORATORY WORK 1
-- BY Artemenko_Yaroslav
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці та редагувати структуру таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER artemenko IDENTIFIED BY artemenko 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER artemenko quota 100M on users;

GRANT "connect" to artemenko;

GRANT CREATE ANY TABLE to artemenko;
GRANT ALTER ANY TABLE to artemenko;








/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина має аккаунт Facebook.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE TABLE people(
    people_name varchar2(30) NOT NULL
    );
ALTER TABLE people
    ADD CONSTRAINT name_pk PRIMARY KEY (people_name);

CREATE TABLE acc (
    acc_id NUMBER(10) NOT NULL
    );
ALTER TABLE acc
    ADD CONSTRAINT acc_pk PRIMARY KET (acc_id);
    
CREATE TABLE people_acc(
    people_name_fk varchar(30) NOT NULL,
    acc_id_fk NUMBER(10) NOT NULL,
    friends varchar(30) NOT NULL
    );
ALTER TABLE people_acc
    ADD CONSTRAINT people_acc_pk PRIMARY KEY (people_name_fk,acc_id_fk);
ALTER TABLE people_acc
    ADD CONSTRAINT people_fk FOREIGN KEY (people_name_fk) REFERENCES people(people_name);
ALTER TABLE people_acc
    ADD CONSTRAINT acc_fk FOREIGN KEY (acc_id_fk) REFERENCES acc(acc_if);
    
    














  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
GRANT SELECT ANY TABLE to artemenko;
GRANT INSERT ANY TABLE to artemenko;






/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, яким продано найдешевший товар ?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

Project CUSTOMERS {cust_name}
WHERE cust_id in (
Project ORDERS {cust_id}
WHERE order_num in(
Project ORDERITEMS {order_num}
WHERE item_price in (
Project ORDERITEMS {MIN(item_price)})));









/*---------------------------------------------------------------------------
3.b. 
Який звуть покупця з найкоротшим email?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


Project CUSTOMERS {cust_name}
WHERE length(trim(cust_email)) in (
Project CUSTOMERS {min(length(trim(cust_email)))}
WHERE cust_email is not NULL);












/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників, що не мають жодного товару.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT vendors.vend_name
FROM
products, vendors
MINUS
SELECT vendors.vend_name
FROM
products, vendors
WHERE vendors.vend_id = products.vend_id ;
