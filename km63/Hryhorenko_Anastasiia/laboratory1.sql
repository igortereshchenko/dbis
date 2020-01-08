-- LABORATORY WORK 1
-- BY Hryhorenko_Anastasiia
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці та редагувати структуру таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE USER grigorenko
IDENTIFIED BY grigorenko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
 
ALTER USER grigorenko QUOTA 100M ON USERS;

GRANT "CONNECT" TO grigorenko;

GRANT CREATE ANY TABLE TO grigorenko;
GRANT ALTER ANY TABLE TO grigorenko;











/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина має аккаунт Facebook.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE HUMAN (
    human_name VARCHAR2(30) NOT NULL
    );
    
ALTER TABLE HUMAN
    ADD CONSTRAINT human_name_pk PRIMARY KEY (human_name);
    
CREATE TABLE ACOUNT (
    ac_name VARCHAR2(30) NOT NULL
    );

ALTER TABLE ACOUNT 
    ADD CONSTRAINT human_name_pk PRIMARY KEY (human_name);  

CREATE TABLE HUMAN_AC (
    human_name_fk VARCHAR2(30) NOT NULL
    ac_name_fk VARCHAR2(30) NOT NULL
    number_of_ac NUMBER(15) NOT NULL
    );

ALTER TABLE HUMAN_AC 
    ADD CONSTRAINT human_ac_pk PRIMARY KEY (human_name_fk, ac_name_fk);
    
ALTER TABLE HUMAN_AC 
    ADD CONSTRAINT human_fk FOREIGN KEY (human_name_fk) REFERENCES NUMAN(human_name);

ALTER TABLE HUMAN_AC 
    ADD CONSTRAINT ac_fk FOREIGN KEY (ac_name_fk) REFERENCES ACOUNT(ac_name);













  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT INSERT ANY TABLE TO grigorenko;
GRANT SELECT ANY TABLE TO grigorenko;





/*---------------------------------------------------------------------------
3.a. 
Як звуть покупців, яким продано найдешевший товар ?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUST_NAME
FROM CUSTOMERS, ORDERS, ORDERITEMS
WHERE item_price = MIN(ITEM_PRICE);













/*---------------------------------------------------------------------------
3.b. 
Який звуть покупця з найкоротшим email?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT CUST_NAME
FROM CUSTOMERS
WHERE cust_email = MIN(COUNT(CUST_EMAIL);













/*---------------------------------------------------------------------------
c. 
Вивести імена постачальників, що не мають жодного товару.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT VEND_NAME
FROM
    (SELECT VEND_ID, VEND_NAME
     FROM VENDORS, PRODUCTS
     MINUS
     SELECT VEND_ID, VEND_NAME
     FROM PRODUCTS);
    

