-- LABORATORY WORK 2
-- BY Kozyriev_Anton

/*---------------------------------------------------------------------------
1. Вивести ім'я покупця, номер замовлення та назву продукту, що найменше було куплено у кожному замовленні покупця.

---------------------------------------------------------------------------*/
--Код відповідь:


SELECT CUSTOMERS.CUST_NAME, ORDERS.ORDER_NUM, PRODUCTS.PROD_NAME 
FROM ORDERITEMS JOIN PRODUCTS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
JOIN ORDERS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
JOIN CUSTOMERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
WHERE ORDERITEMS.QUANTITY IN
(SELECT MIN(ALL_QUANTITY.TOTAL)
FROM
(SELECT ORDERITEMS.PROD_ID, SUM(ORDERITEMS.QUANTITY) AS TOTAL
FROM ORDERITEMS
GROUP BY ORDERITEMS.PROD_ID) ALL_QUANTITY);

/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника, що продавав свої продукти лише трьом покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT ORDERS.CUST_ID, ORDERITEMS.PROD_ID, PRODUCTS.VEND_ID
FROM ORDERS JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
JOIN ORDERITEMS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
GROUP BY ORDERITEMS.PROD_ID
HAVING COUNT(DISTINCT PRODUCTS.VEND_ID) = 3;
