-- LABORATORY WORK 3
-- BY Hevlich_Vadym

/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників була 10. Ключі замовників test1….testn. 
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він має більше 3 замовлень - статус  = "yes"
Якщо він має не менше 3 замовлень - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

DECLARE
    cust_id char(10) := '';
    cust_name char(50) := '';
    cust_status char(10) := '';
    orders_count int := 0;
BEGIN

    SELECT
        CUSTOMERS.CUST_ID,
        CUSTOMERS.CUST_NAME,
        COUNT(ORDERS.ORDER_NUM)
    INTO cust_id, cust_name, orders_count
    FROM CUSTOMERS JOIN ORDERS
        ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID AND CUSTOMERS.CUST_ID = '1000000001' -- 1000000001 - вказаний ключ замовника
        GROUP BY CUSTOMERS.CUST_ID, CUSTOMERS.CUST_NAME;
    
    IF orders_count > 3 THEN
        cust_status := 'yes';
    ELSIF orders_count = 3 THEN
        cust_status := 'no';
    ELSIF orders_count = 0 THEN
        cust_status := 'unknown';
    END IF;

    DBMS_OUTPUT.PUT_LINE(TRIM(cust_name) || ' ' || TRIM(cust_status));
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень має кожен з покупців, що проживає в Австрії.
3.2. Як звуть постачальника з Германії, що продає свої товари більше ніж у 3 різних замовленнях.
6 балів.*/

CREATE VIEW customers_data as
SELECT
    CUSTOMERS.CUST_ID,
    ORDERS.ORDER_NUM,
    VENDORS.VEND_NAME,
    CUSTOMERS.CUST_COUNTRY,
    VENDORS.VEND_COUNTRY,
    PRODUCTS.PROD_ID
FROM CUSTOMERS, ORDERS, VENDORS, PRODUCTS
    WHERE CUSTOMERS.CUST_ID = ORDERS.CUST_ID AND VENDORS.VEND_ID = PRODUCTS.VEND_ID;

SELECT
    COUNT(order_num)
FROM customers_data
WHERE CUST_COUNTRY = 'Austria';

SELECT
    vend_name
FROM customers_data
WHERE vend_country = "Germany" AND COUNT(PROD_ID) > 3;
