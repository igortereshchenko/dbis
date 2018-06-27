-- LABORATORY WORK 2
-- BY Dziuba_Yevhen
/*---------------------------------------------------------------------------
1. Вивести ім'я покупця, номер замовлення та назву продукту, що найменше було куплено у кожному замовленні покупця.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT CUSTOMERS.CUST_NAME,
ORDERS.ORDER_NUM,
PRODUCTS.PROD_NAME
FROM CUSTOMERS
JOIN ORDERS 
ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
JOIN ORDERITEMS
ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
JOIN PRODUCTS 
ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
HAVING COUNT();








  
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника, що продавав свої продукти лише трьом покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT VENDORS.VEND_ID
FROM VENDORS
JOIN PRODUCTS 
ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
JOIN ORDERITEMS 
ON PRODUCTS.PROD_ID =  ORDERITEMS.PROD_ID
JOIN ORDERS
ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
GROUP BY  VENDORS.VEND_ID
HAVING COUNT(DISTINCT CUST_ID)=3;




