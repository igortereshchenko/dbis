-- LABORATORY WORK 2
-- BY Kolesnyk_Mariia
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що продав більше 2 одиниць продуктів різним покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT distinct info.vend_id FROM
  (SELECT VENDORS.VEND_ID, orders.cust_id, count(orderitems.prod_id) FROM
  VENDORS JOIN PRODUCTS ON vendors.vend_id = products.vend_id
    JOIN ORDERITEMS ON PRODUCTS.prod_id = orderitems.prod_id
    JOIN ORDERS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
  GROUP BY vendors.vend_id, orders.cust_id
  HAVING COUNT(distinct orderitems.prod_id) > 2)info;









/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що не має найдорожче замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUSTOMERS.CUST_ID, MAX(ORDERITEMS.QUANTITY*ORDERITEMS.ITEM_PRICE) AS MAX_PRICE
FROM ORDERITEMS
JOIN PRODUCTS
ON (ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID)
GROUP BY CUSTOMERS.CUST_ID;
