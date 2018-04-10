-- LABORATORY WORK 2
-- BY Ushatska_Vasylyna
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту, за умови, що покупець ніколи не купляв даний продукт.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT CUSTOMERS.CUST_ID,PRODUCTS.PROD_ID
FROM CUSTOMERS  LEFT JOIN ORDERS
ON CUSTOMERS.CUST_ID=ORDERS.CUST_ID
JOIN ORDERITEMS
ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
FULL OUTER JOIN PRODUCTS
ON ORDERITEMS.PROD_ID=PRODUCTS.PROD_ID
MINUS 
SELECT CUSTOMERS.CUST_ID,PRODUCTS.PROD_ID
FROM CUSTOMERS JOIN ORDERS
ON CUSTOMERS.CUST_ID=ORDERS.CUST_ID
JOIN ORDERITEMS
ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
JOIN PRODUCTS
ON ORDERITEMS.PROD_ID=PRODUCTS.PROD_ID










/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, що працював з покупцем, що має найдорожче замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT VEND_ID,MAX( ORDERITEMS.ITEM_PRICE*ORDERITEMS.QUANTITY)

 FROM CUSTOMERS  JOIN ORDERS
ON CUSTOMERS.CUST_ID=ORDERS.CUST_ID
JOIN ORDERITEMS
ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
JOIN PRODUCTS
ON ORDERITEMS.PROD_ID=PRODUCTS.PROD_ID
JOIN VENDORS
ON PRODUCTS.VEND_ID= VENDORS.VEND_ID
