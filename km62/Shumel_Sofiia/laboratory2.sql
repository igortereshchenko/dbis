
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що продав лише по одному продукту і тільки 3 покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT PRODUCTS.VEND_ID
FROM PRODUCTS 
  JOIN ORDERITEMS
    ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
WHERE ORDERITEMS.QUANTITY = 1

UNION

SELECT PRODUCTS.VEND_ID
FROM PRODUCTS 
  JOIN ORDERITEMS
    ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
    JOIN ORDERS
      ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
      JOIN CUSTOMERS 
      ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
GROUP BY VEND_ID
HAVING COUNT(CUSTOMERS.CUST_ID)=3;




/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого не найдорожче.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT ORDERS.CUST_ID
FROM ORDERS JOIN ORDERITEMS 
ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
WHERE ORDERITEMS.QUANTITY < MAX(QUANTITY)
GROUP BY ORDERS.CUST_ID;







