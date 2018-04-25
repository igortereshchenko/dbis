-- LABORATORY WORK 3
-- BY Koltsov_Dmytro

/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

DECLARE
    
BEGIN
    SELECT 
        CUST_ID
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень було зроблено покупцями з Англії.
3.2. На яку загальну суму продали постачальники товари покупцям з Англії.
6 балів.*/

CREATE VIEW CUST_VEND_SV AS
    SELECT 
    CUSTOMERS.CUST_ID,
    CUSTOMERS.CUST_COUNTRY,
    VENDORS.VEND_ID,
    ORDERITEMS.ITEM_PRICE,
    ORDERITEMS.QUANTITY
    
    FROM
        CUSTOMERS
        LEFT JOIN ORDERS ON ORDERS.CUST_ID = CUSTOMERS.CUST_ID
        LEFT JOIN ORDERITEMS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
        LEFT JOIN PRODUCTS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
        LEFT JOIN VENDORS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID;
    

SELECT 
    COUNT(DISTINCT CUST_ID) 
    
    FROM CUST_VEND_SV   
    
    WHERE 
        CUST_COUNTRY = 'England';
        
SELECT 
    SUM(QUANTITY * ITEM_PRICE)
    FROM CUST_VEND_SV   
    
    WHERE 
        CUST_COUNTRY = 'England';
        
