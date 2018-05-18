-- LABORATORY WORK 3
-- BY Shanin_Vladyslav

/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 7. Ключі постачальників v1….vn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/

DECLARE
    vendId Vendors.VEND_ID%TYPE := 'BRS01';
    maxVendNum INTEGER := 7;
    vendNum INTEGER := 0;
    additionalNum INTEGER := 0;
    
    vendName Vendors.VEND_NAME%TYPE;
    vendAddress Vendors.VEND_ADDRESS%TYPE;
    vendCity Vendors.VEND_CITY%TYPE;
    vendState Vendors.VEND_STATE%TYPE;
    vendZip Vendors.VEND_ZIP%TYPE;
    vendCountry Vendors.VEND_COUNTRY%TYPE;
BEGIN
    SELECT  
        COUNT(DISTINCT VEND_ID)
    INTO
        vendNum
    FROM
        Vendors;
    
    SELECT
        VEND_NAME, VEND_ADDRESS, VEND_CITY, VEND_STATE, VEND_ZIP, VEND_COUNTRY
    INTO
        vendName, vendAddress, vendCity, vendState, vendZip, vendCountry
    FROM 
        Vendors
    WHERE
        VEND_ID = vendId;
    
    IF vendNum < maxVendNum THEN
        additionalNum := maxVendNum - vendNum;
        FOR i IN 1..additionalNum LOOP
            INSERT INTO Vendors 
                (VEND_ID, VEND_NAME, VEND_ADDRESS, VEND_CITY, VEND_STATE, VEND_ZIP, VEND_COUNTRY)
            VALUES
                ('v'||i, vendName, vendAddress, vendCity, vendState, vendZip, vendCountry);
        END LOOP;
    END IF;
END;

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив більше 10 продуктів - статус  = "yes"
Якщо він купив менше 10 продуктів - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

SET SERVEROUTPUT ON;

DECLARE
    custId Customers.CUST_ID%TYPE := '1000000003';
    custName Customers.CUST_NAME%TYPE;
    prodAmount INTEGER := 0;
    custStatus VARCHAR2(40);
BEGIN
    SELECT
        Customers.CUST_ID, Customers.CUST_NAME, COUNT(DISTINCT Orders.ORDER_NUM)
    INTO
        custId, custName, prodAmount
    FROM 
        Customers LEFT JOIN Orders ON Customers.CUST_ID = Orders.CUST_ID
    WHERE
        Customers.CUST_ID = custId
    GROUP BY
        Customers.CUST_ID, Customers.CUST_NAME;
        
    IF prodAmount = 0 THEN
        custStatus := 'unknown';
    ELSIF prodAmount < 10 THEN
        custStatus := 'no';
    ELSIF prodAmount >= 10 THEN
        custStatus := 'yes';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(TRIM(custName) || ' ' || custStatus);
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести ім’я покупця та загальну кількість купленим ним товарів.
3.2. Вивести ім'я постачальника за загальну суму, на яку він продав своїх товарів.
6 балів.*/

CREATE VIEW GLOBAL_INFO AS
    SELECT 
        Customers.CUST_ID, 
        Customers.CUST_NAME, 
        Orders.ORDER_NUM, 
        Products.PROD_ID, 
        OrderItems.ORDER_ITEM,
        OrderItems.QUANTITY,
        OrderItems.ITEM_PRICE,
        Vendors.VEND_ID,
        Vendors.VEND_NAME
    FROM
        Customers LEFT JOIN Orders ON Customers.CUST_ID = Orders.CUST_ID
        LEFT JOIN OrderItems ON Orders.ORDER_NUM = OrderItems.ORDER_NUM
        LEFT JOIN Products ON OrderItems.PROD_ID = Products.PROD_ID
        LEFT JOIN Vendors ON Products.VEND_ID = Vendors.VEND_ID;

SELECT
    CUST_NAME, COUNT(DISTINCT ORDER_NUM)
FROM 
    GLOBAL_INFO
GROUP BY 
    CUST_NAME;
    
SELECT
    VEND_ID, VEND_NAME, SUM(QUANTITY * ITEM_PRICE)
FROM
    GLOBAL_INFO
GROUP BY
    VEND_ID, VEND_NAME;
