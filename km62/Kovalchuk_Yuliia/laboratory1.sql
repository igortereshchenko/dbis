/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти та вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Kovalchuk IDENTIFIED BY Kovalchuk ;

DEFAULT TABLESPACE "USERS";
TEMPORARY TABLESPACE "TEMP";

ALTER USER QUOTA 100M ON  USER;
GRANT "CONECT" TO Kovalchuk;

GRANT DELETE ANY TABLE FOR Kovalchuk;
GRANT INSERT ANY TABLE FOR Kovalchuk







/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина купляє певну марку телефону.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE PHONE
PHONE_NAME VARCHAR(20) NOT NULL;
ALTER TABLE PHONE
ADD CONSTRAINT phone_pk PRIMARY KEY (PHONE_NAME)


CREATE TABLE PEOPLE
PEOPLE_NAME VARCHAR(20) NOT NULL;
ALTER TABLE PEOPLE
ADD CONSTRAINT people_pk PRIMARY KEY (people_NAME) 



CREATE TABLE PEOPLE_PHONE
PEOPLE_NAME VARCHAR(20) NOT NULL,
PHONE_NAME VARCHAR(20) NOT NULL),
PEOPLE_PHONE VARCHAR(20) 
);

ALTER TABLE PEOPLE_PHONE
ADD CONSTRAINT people_phone_Pk PRIMARY KEY (phone_pk, people_pk );

ALTER TABLE PEOPLE_PHONE
ADD CONSTRAINT people_phone_fk FORING KEY (phone_fk) REFERNS (phone_name);
ALTER TABLE PEOPLE_PHONE
ADD CONSTRAINT people_phone_fk FORING KEY (people_fk) REFERNS (peoplename);







  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE INSERT TABLE IN Kovalchuk;


/*---------------------------------------------------------------------------
3.a. 
Яка ціна найдорожчого товару, що нікому не було продано?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

REFERENS( max_prise, product (MAX(max_prise) and ( max_prise = orders_id NOT IN(COSTUMER){Custumer, Orders}
 











/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT USERS_NAME,
PRODUCT_NAME = "Customer_name";
FROM CUSTOMER;
WHERE /*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
видаляти та вставляти дані до таблиць
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE USER Kovalchuk IDENTIFIED BY Kovalchuk ;

DEFAULT TABLESPACE "USERS";
TEMPORARY TABLESPACE "TEMP";

ALTER USER QUOTA 100M ON  USER;
GRANT "CONECT" TO Kovalchuk;

GRANT DELETE ANY TABLE FOR Kovalchuk;
GRANT INSERT ANY TABLE FOR Kovalchuk







/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина купляє певну марку телефону.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE PHONE
PHONE_NAME VARCHAR(20) NOT NULL;
ALTER TABLE PHONE
ADD CONSTRAINT phone_pk PRIMARY KEY (PHONE_NAME)


CREATE TABLE PEOPLE
PEOPLE_NAME VARCHAR(20) NOT NULL;
ALTER TABLE PEOPLE
ADD CONSTRAINT people_pk PRIMARY KEY (people_NAME) 



CREATE TABLE PEOPLE_PHONE
PEOPLE_NAME VARCHAR(20) NOT NULL,
PHONE_NAME VARCHAR(20) NOT NULL),
PEOPLE_PHONE VARCHAR(20) 
);

ALTER TABLE PEOPLE_PHONE
ADD CONSTRAINT people_phone_Pk PRIMARY KEY (phone_pk, people_pk );

ALTER TABLE PEOPLE_PHONE
ADD CONSTRAINT people_phone_fk FORING KEY (phone_fk) REFERNS (phone_name);
ALTER TABLE PEOPLE_PHONE
ADD CONSTRAINT people_phone_fk FORING KEY (people_fk) REFERNS (peoplename);







  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE INSERT TABLE IN Kovalchuk;


/*---------------------------------------------------------------------------
3.a. 
Яка ціна найдорожчого товару, що нікому не було продано?
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

REFERENS( max_prise, product (MAX(max_prise) and ( max_prise = orders_id NOT IN(COSTUMER){Custumer, Orders}
 











/*---------------------------------------------------------------------------
3.b. 
Як звуть покупця, у якого у замовленні найдорожчий товар – поле назвати Customer_name.
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

SELECT
PEOPLE_NAME,
CONTRU_PROV,
ORDER_NAM;


