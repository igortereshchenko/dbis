-- LABORATORY WORK 2
-- BY Khodakivskyi_Vadym
/*---------------------------------------------------------------------------
1. Вивести номер замовлення та ключ постачальника, за умови, що жодного з продуктів цього постачальника у замовленні нема.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT 
  ORDERS.ORDER_NUM,
  VENDORS.VEND_ID
FROM ORDERS,ORDERITEMS, PRODUCTS, VENDORS
MINUS
SELECT 
  ORDERS.ORDER_NUM,
  VENDORS.VEND_ID
FROM 
  VENDORS JOIN PRODUCTS
    ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
    JOIN ORDERITEMS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
    JOIN ORDERS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
  ;










/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що працював з постачальником, що продає найменшу кількість продуктів.

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT 
  DISTINCT CUSTOMERS.CUST_NAME
  FROM CUSTOMERS JOIN ORDERS 
    ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
    JOIN ORDERITEMS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
    JOIN PRODUCTS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
    JOIN VENDORS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
  WHERE VENDORS.VEND_ID = (SELECT TOTAL.VEND_ID
FROM
(SELECT 
  VENDORS.VEND_ID,
  SUM(ORDERITEMS.QUANTITY) AS SUM_QUANTITY
FROM 
  VENDORS JOIN PRODUCTS 
    ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
  JOIN ORDERITEMS
    ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
GROUP BY VENDORS.VEND_ID
HAVING SUM(ORDERITEMS.QUANTITY) = (SELECT MIN(SUM_QUANTITY) FROM (SELECT 
  VENDORS.VEND_ID,
  SUM(ORDERITEMS.QUANTITY) AS SUM_QUANTITY
FROM 
  VENDORS JOIN PRODUCTS 
    ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
  JOIN ORDERITEMS
    ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
GROUP BY VENDORS.VEND_ID))) TOTAL)
;
