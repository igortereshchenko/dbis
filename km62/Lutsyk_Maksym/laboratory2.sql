-- LABORATORY WORK 2
-- BY Lutsyk_Maksym

/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що продав лише по одному продукту і тільки 3 покупцям.

---------------------------------------------------------------------------*/
--Код відп
SELECT vendors.vend_id
FROM ORDERS
JOIN customers ON Orders.cust_id = customers.cust_id
JOIN orderitems ON orderitems.order_num = orders.order_num
JOIN products ON orderitems.prod_id = products.prod_id
JOIN vendors ON products.vend_id = vendors.vend_id
GROUP BY vendors.vend_id
HAVING COUNT(DISTINCT customers.cust_id) = 3;









/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого не найдорожче.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT CUST_ID
FROM ( SELECT ORDER_NUM, ORDER_ITEM, CUST_ID
FROM Orders JOIN OrderItems 
Where Orders.Cust_ID = OrderItems.CUST_ID;)
WHERE ORDER_ITEM IN (SELECT MAX(ORDER_ITEM) FROM OrderItems;);








