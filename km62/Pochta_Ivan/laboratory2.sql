-- LABORATORY WORK 2
-- BY Pochta_Ivan
/*---------------------------------------------------------------------------
1. Вивести ім'я покупця, номер замовлення та назву продукту, що найменше було куплено у кожному замовленні покупця.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT CUSTOMERS.cust_name, OrderItems.order_num, TRIM(Products.prod_name) as Products_name
FROM
(
(SELECT CUSTOMERS.cust_id, ORDERS.order_num, MIN(ORDERITEMS.QUANTITY) as min_
FROM CUSTOMERS
JOIN ORDERS
ON Customers.cust_id = ORDERS.CUST_ID
JOIN ORDERITEMS
ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
JOIN PRODUCTS
ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
GROUP BY CUSTOMERS.cust_id, ORDERS.ORDER_NUM) no_words
JOIN ORDERITEMS
ON OrderItems.order_num = no_words.order_num
JOIN PRODUCTS
ON ORDERITEMS.prod_id = Products.prod_id
JOIN ORDERS
ON ORDERS.order_num = ORDERITEMS.order_num
JOIN CUSTOMERS
ON CUSTOMERS.cust_id = Orders.cust_id
)
WHERE ORDERITEMS.quantity = no_words.min_;







  
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника, що продавав свої продукти лише трьом покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT VENDORS.vend_id
FROM ORDERS
JOIN CUSTOMERS
ON ORDERS.cust_id = CUSTOMERS.cust_id
JOIN ORDERITEMS
ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
JOIN PRODUCTS
ON ORDERITEMS.prod_id = PRODUCTS.prod_id
JOIN VENDORS
ON PRODUCTS.vend_id = VENDORS.vend_id
GROUP BY VENDORS.vend_id
HAVING COUNT(DISTINCT CUSTOMERS.cust_id) = 3;
