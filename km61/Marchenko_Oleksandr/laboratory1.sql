/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
оновлювати дані в таблицях
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER Marchenko IDENTIFIED BY Marchenko;

TEMPORARY TEMPLATE "TEMPSPACE"; 
DEFAULT USER "USERSPACE";

GRANT "CONNECT" TO Marchenko;  
GRANT UPDATE ANY TABLE TO Marchenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина дивиться кіно.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:
CREATE TABLE Films
(
    filmName VARCHAR(30)
);
ALTER TABLE Films
(

);

CREATE TABLE Humanoid
(
    humanName VARCHAR(30)
);

ALTER TABLE Humanoid
(

);

CREATE TABLE CinemaHistory
(
    
);
ALTER TABLE CinemaHistory
(

);
ALTER TABLE CinemaHistory
(

);
ALTER TABLE CinemaHistory
(

);

/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

GRANT CREATE ANY TABLE TO Marchenko;
GRANT SELECT ANY TABLE TO Marchenko;
GRANT INSERT ANY TABLE TO Marchenko; --OR ADD
CREATE DATABASE SomeName();


/*---------------------------------------------------------------------------
3.a. 
Скільком покупцям продано найдешевший товар?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

SELECT COUNT(DISTINCT CUST_ID)
    FROM ORDERS, ORDERITEMS 
        WHERE ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM 
            AND ORDERITEMS.ITEM_PRICE IN (SELECT MIN(ITEM_PRICE) FROM ORDERITEMS);


/*---------------------------------------------------------------------------
3.b. 
Яка країна, у якій живуть постачальники має найдовшу назву?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/
SELECT DISTINCT VEND_COUNTRY 
    FROM VENDORS 
        WHERE LENGTH(TRIM(VEND_NAME)) IN 
            (SELECT MAX(LENGTH(TRIM(VEND_NAME))) FROM VENDORS);
/*---------------------------------------------------------------------------
c. 
Вивести ім’я та країну покупця, як єдине поле client_name, для тих покупців, що мають не порожнє замовлення.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
RENAME(PROJECT CUSTOMERS { DISTINCT TRIM(CUST_NAME) || " " || TRIM(CUST_COUNTRY) } 
                    WHERE CUST_ID IN (PROJECT ORDERS {DISTINCT(CUST_ID)})) { TRIM(CUST_NAME) || " " || TRIM(CUST_COUNTRY)  => "client_name"};
