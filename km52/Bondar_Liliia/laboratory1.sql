-- LABORATORY WORK 1
-- BY Bondar_Liliia
/*---------------------------------------------------------------------------
1.Створити схему даних з назвою – прізвище студента, у якій користувач може: 
змінювати структуру таблиць та видаляти дані.
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:

CREATE USER bondar IDENTIFIED BY bondar 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

ALTER USER bondar QUOTA 50M ON USERS;

GRANT "CONNECT" TO bondar;

GRANT DELETE ANY TABLE TO bondar;
GRANT ALTER ANY TABLE TO bondar;


/*---------------------------------------------------------------------------
2. Створити таблиці, у яких визначити поля та типи. Головні та зовнішні ключі 
створювати окремо від таблиць використовуючи команди ALTER TABLE. 
Турист забронював готель. 
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:

CREATE TABLE Tourist (
    tourist_id INT NOT NULL,
    tourist_name CHAR(30) NOT NULL,
    tourist_last_name CHAR(30) NOT NULL,
    hotel_id INT
);

CREATE TABLE Hotel (
    hotel_id INT NOT NULL,
    hotel_name CHAR(30) NOT NULL
);

ALTER TABLE  Tourist
    ADD CONSTRAINT tourist_pk PRIMARY KEY tourist_id;
    
ALTER TABLE  Hotel
    ADD CONSTRAINT hotel_pk PRIMARY KEY hotel_id;

ALTER TABLE  Tourist
  ADD CONSTRAINT hotel_fk FOREIGN KEY (hotel_id) REFERENCES Hotel (hotel_id);


/* --------------------------------------------------------------------------- 
3. Надати додаткові права користувачеві (створеному у пункті № 1) для створення таблиць, 
внесення даних у таблиці та виконання вибірок використовуючи команду ALTER/GRANT. 
Згенерувати базу даних використовуючи код з теки OracleScript та виконати запити: 
---------------------------------------------------------------------------*/
--Код відповідь:

GRANT INSERT ANY TABLE TO bondar;


/*---------------------------------------------------------------------------
3.a. 
Як звуть покупця, що не купив найдорожчий продукт.
Виконати завдання в Алгебрі Кодда. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


-- SQL:

SELECT
    CUSTOMERS.CUST_NAME,
FROM CUSTOMERS,
    ORDERS,
    ORDERITEMS,
    PRODUCTS,
    (
    SELECT
        MAX(PRODUCTS.PROD_PRICE) AS PRICE, 
        CUSTOMERS.CUST_ID AS CUST_ID
    FROM CUSTOMERS,
        ORDERS,
        ORDERITEMS,
        PRODUCTS
    WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID
    AND ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
    AND ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID) MAX_PROD_PRICE
WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID
    AND ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
    AND ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
    AND PRODUCTS.PROD_PRICE <  MAX_PROD_PRICE.PRICE;
    

-- Алгебра Кодда:
    
PROJECT (
    CUSTOMERS TIMES ORDERS TIMES ORDERITEMS TIMES PRODUCTS TIMES PROJECT (
        CUSTOMERS TIMES ORDERS TIMES ORDERITEMS TIMES PRODUCTS
        (
        WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID
        AND ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
        AND ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID) MAX_PROD_PRICE){
            MAX(PRODUCTS.PROD_PRICE) AS PRICE, 
            CUSTOMERS.CUST_ID AS CUST_ID
        }
    (WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID
        AND ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
        AND ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
        AND PRODUCTS.PROD_PRICE <  MAX_PROD_PRICE.PRICE)
){
    CUSTOMERS.CUST_NAME,
};




/*---------------------------------------------------------------------------
3.b. 
Вивести номер замовлення та назву товару у даному замовленні, що має найнижчу ціну у рамках замовлення.
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/

--Код відповідь:


SELECT DISTINCT
    ORDERS.ORDER_NUM,
    MIN_PRICES.PROD_NAME
FROM ORDERS, ODERITEMS, PRODUCTS, (
    SELECT
        MIN(ORDERITEMS.QUANTITY * ORDERITEMS.ITEM_PRICE) AS MIN_PRICE,
        PRODUCTS.PROD_ID
    FROM ORDERS, ORDERITEMS, PRODUCTS
    WHERE ORDERS.ORDER_NUM = ODERITEMS.ORDER_NUM,
        ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
    GROUP BY PRODUCTS.PROD_ID) MIN_PRICES
WHERE ORDERS.ORDER_NUM = ODERITEMS.ORDER_NUM
    AND ODERITEMS.PROD_ID = PRODUCTS.PROD_ID
    AND MIN_PRICES.PROD_ID = PRODUCTS.PROD_ID;









/*---------------------------------------------------------------------------
c. 
Вивести країну та пошту покупця, як єдине поле client_name у нижньому регістрі, для тих покупців, що купляли продукти у постачальника з іменем "James". 
Виконати завдання в SQL. 
4 бали
---------------------------------------------------------------------------*/
--Код відповідь:

SELECT DISTINCT
    CUSTOMERS.CUST_COUNTRY AS "client_name"
FROM CUSTOMERS, ORDERS, ORDERITEMS, PRODUCTS
WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID
    AND ORDERS.ORDER_NUM = ODERITEMS.ORDER_NUM
    AND ODERITEMS.PROD_ID = PRODUCTS.PROD_ID
    AND PRODUCTS.VEND_ID IS NOT NULL;
