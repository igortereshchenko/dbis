-- LABORATORY WORK 1
-- BY Dmytrenko_Hryhorii
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти та вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER dmytrenko IDENTIFIED BY password
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TABLE"

GRANT "CONNECT" TO dmytrenko

ALTER USER dmytrenko ON QUOTE 100M

GRANT DROP ANY TABLE TO dmytrenko
GRANT INSERT ANY TABLE TO dmytrenko

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина купляє певну марку телефону.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE HUMAN(
    human_name VARCHAR(20) NOT NULL
);

ALTER TABLE HUMAN
    ADD CONSTRAINT human_pk PRIMARY KEY (human_name);
    
CREATE TABLE PHONE_TYPE(
    phone_type_name VARCHAR(20) NOT NULL
);

ALTER TABLE PHONE_TYPE
    ADD CONSTAINT phone_type_name_pk PRIMARY KEY (phone_type_name);
    
CREATE TABLE HUMAN_PHONE(
    human_name VARCHAR(20) NOT NULL
    phone_type_name VARCHAR(20) NOT NULL
    human_own_phone VARCHAR(20) NOT NULL
);

ALTER TABLE HUMAN_PHONE
    ADD CONSTRAINT human_own_phone_pk PRIMARY KEY (human_name, phone_type_name);
    
ALTER TABLE HUMAN_PHONE
    ADD CONSTRAINT human_name_fk FOREIGN KEY REFERENCES TO (human_name);
    
ALTER TABLE HUMAN_TABLE
    ADD CONSTRAINT phone_type_name_fk FOREIGN KEY REFERENCES TO (phone_type_name);
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO dmytrenko
GRANT INSERT ANY TABLE TO dmytrenko
GRANT SELECT ANY TABLE TO dmytrenko;

/*---------------------------------------------------------------------------
3.a. 
Яка ціна найдорожчого товару, що нікому не було продано?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:














/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT CUST_NAME AS Customer_name
FROM CUSTOMERS, ORDERITEMS, ORDERS
    WHERE ORDERS.CUST_ID = CUSTOMERS.CUST_ID
    AND ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
    

/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну постачальника, як єдине поле vendor_name, для тих остачальників, що не мають товару.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

