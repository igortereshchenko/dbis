-- LABORATORY WORK 3
-- BY Mironchenko_Valerii
/*1. Написати PL/SQL код, що додає замовлення покупцю з ключем 1000000001, щоб сумарна кількість його замовлень була 4. 
Ключі нових замовлень  - ord1….ordn. Дата цих замовлень відповідає даті замовлення з номером 20005.
10 балів*/

/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав більше 10 продуктів - статус  = "yes"
Якщо він продав менше 10 продуктів - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/
DECLARE 
    VENDOR_ID   VENDORS.VEND_ID%STATUS;
    VENDOR_NAME VENDORS.VEND_NAME;
    VENDOR_STATUS   VARCHAR2(10);
    ITEMS_COUNT     INTEGER := 0;
BEGIN
    VENDOR_ID := 'BRS01';
    SELECT
        VENDORS.VEND_ID, VENDORS.VEND_NAME, COUNT(ORDERITEMS.ORDER_ITEM)
    INTO
        VENDOR_ID, VENDOR_NAME, ITEMS_COUNT
    FROM
         ORDERITEMS     JOIN PRODUCTS   ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
                        JOIN VENDORS    ON VENDORS.VEND_ID = PRODUCTS.VEND_ID;
    WHERE VENDORS.VEND_ID = VENDOR_ID
    IF ITEMS_COUNT > 10 THEN VENDOR_STATUS := 'YES';
    ELSIF ITEMS_COUNT < 10 THEN VENDOR_STATUS := 'NO';
    ELSE VENDOR_STATUS := 'UNKNOWN';
    END IF;
    DBMS_OUTPUT.PUT_LINE(TRIM(VENDOR_NAME) || TRIM(VENDOR_STATUS));
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести номери замовлення та кількість постачальників, що продавали свої товари у кожне з замовлень.
3.2. Вивести ім'я постачальника та кількість його покупців.
6 балів.*/

CREATE VIEW VENDORS_PRODUCTS AS 
    SELECT ORDERS.ORDER_NUM, VENDORS.VEND_NAME, CUSTOMERS.CUST_NAME
    FROM CUSTOMERS JOIN ORDERS     ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
                   JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
                   JOIN PRODUCTS   ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
                   JOIN VENDORS    ON VENDORS.VEND_ID = PRODUCTS.VEND_ID;

/*3.1*/
SELECT ORDER_NUM, COUNT(VEND_NAME)
FROM VENDORS_PRODUCTS;

/*3.2*/                   
SELECT VEND_NAME, COUNT(CUST_ID)
FROM VENDORS_PODUCTS;
