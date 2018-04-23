-- LABORATORY WORK 2
-- BY Popravko_Oleksii
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що продав лише по одному продукту і тільки 3 покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT VENDORS.VEND_ID, ORDERITEMS.ORDER_ITEM, CUSTOMERS.CUST_NAME
FROM VENDORS JOIN PRODUCTS
ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
JOIN ORDERITEMS 
ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
JOIN ORDERS
ON orders.order_num = ORDERITEMS.ORDER_NUM
JOIN CUSTOMERS
ON ORDERS.CUST_ID = CUSTOMERS.CUST_ID
GROUP_BY VENDORS.VEND_ID, CUSTOMERS.CUST_NAME
HAVING ORDERITEMS.ORDER_ITEM = 1 AND COUNT(CUSTOMERS.CUST_NAME)=3;







/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого не найдорожче.

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT CUSTOMERS.CUST_ID, 
FROM CUSTOMERS JOIN ORDERS
ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
JOIN ORDERITEMS
ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
GROUP BY CUST_ID
HAVING MAX(ORDER_ITEM*ITEM_PRICE);
