-- LABORATORY WORK 1
-- BY Kharytonchyk_Oleksandr
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
створювати таблиці
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER кharytonchyk
IDENTIFIED BY 12345
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER kharrytonchyk QUOTA 100M ON USERS;

GRANT "CONNECT" TO tereshchenko ;
GRANT CREATE ANY TABLE TO tereshchenko;

/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Людина співає пісню.
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:


CREATE TABLE singers
(
    name char (30) NOT NULL,
    experienceInYears int (3),
    quality varchar2(50)
);

CREATE TABLE songs
(
    song   char (30) NOT NULL,
    author char (30)
);

ALTER TABLE singers
(
    ADD CONSTRAINT name_pk PRIMARY KEY (name)
);




  
/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 

---------------------------------------------------------------------------*/
--Код відповідь:

--Код reviewer`a:
GRANT INSERT ANY TABLE TO KHARITONCHYK ;
GRANT SELECT ANY TABLE TO KHARITONCHYK;

--Виправлений код:
GRANT CREATE ANY TABLE TO Kharytonchyk;
GRANT INSERT ANY TABLE TO Kharytonchyk;
GRANT SELECT ANY TABLE TO Kharytonchyk;

/*---------------------------------------------------------------------------
3.a. 
Скільки проданого найдорожчого товару?
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:

--Код reviewer`a:
SELECT SUM(QUANTITY)
FROM ORDERITEMS
WHERE ORDERITEMS.ITEM_PRICE = (SELECT MAX(ITEM_PRICE)
                                FROM ORDERITEMS);
                                
--Виправлений код:                              
SELECT
    SUM(quantity)
FROM
    orderitems
WHERE
    prod_id IN (
                SELECT
                    prod_id
                FROM
                    orderitems
                WHERE
                    item_price = (
                                    SELECT
                                        MAX(item_price)
                                    FROM
                                        orderitems
                                   )
              );

/*---------------------------------------------------------------------------
3.b. 
Який PROD_ID товару, з найкоротшою назвою?
Виконати завдання в SQL. 
4 бали

---------------------------------------------------------------------------*/

--Код відповідь:

--Код reviewer`a:
SELECT PROD_ID 
FROM PRODUCTS
WHERE PRODUCTS.PROD_NAME = (SELECT  MAX(LENGTH(TRIM(PROD_NAME)))
                            FROM PRODUCTS);

--Виправлений код:
SELECT PROD_ID 
FROM PRODUCTS
WHERE LENGTH(TRIM(PROD_NAME)) = (SELECT  MAX(LENGTH(TRIM(PROD_NAME)))
                            FROM PRODUCTS);

/*---------------------------------------------------------------------------
3.c. 
Вивести імена постачальників у верхньому регістрі,назвавши це поле vendor_name, що не мають жодного товару.
Виконати завдання в алгебрі Кодда. 
4 бали

---------------------------------------------------------------------------*/
--Код відповідь:

--Код reviewer`a:
PROJECT(VENDORS){VEND_NAME}
MINUS 
PROJECT(VENDORS TIMES PRODUCTS
WHERE VENDORS.VEND_ID = PRODUCTS.VEND_ID){VEND_NAME};

--Виправлений код:
PROJECT (VENDORS
        WHERE VENDORS.VEND_ID NOT IN (PROJECT(PRODUCTS){ distinct PRODUCTS.VEND_ID}) 
    ){ DISTINCT RENAME(UPPER(TRIM(VENDORS.VEND_NAME)), "vendor_name")};
    
