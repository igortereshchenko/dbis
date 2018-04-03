-- LABORATORY WORK 2
-- BY Mehediuk_Kateryna
1. Вивести ключ покупця та ключ постачальника та кількість куплених покупцем продуктів у постачальника.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT
CUSTOMER.CUST_ID
ORDERS.ORDER_NUM
PRODUCTS.PROD_ID
FROM
CUSTOMERS, ORDERS
CUSTOMERS JOIN ORDERS
CUSTOMER.OREDR_NUM = ORDERS.ORDER_NUM
JOIN PRODUCTS
ORDERS.PROD_ID = PRODUCT.PROD_ID;











  
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника на номери замовлень, що містять по 2 куплених його товарів.

---------------------------------------------------------------------------*/
--Код відповідь:
Select
ORDERS.ORDER_NUM
PRODUCTS.PROD_ID
FROM
ORDERS, PRODUCTS
MINUS
SELECT
ORDERS.ORDER_NUM
PRODUCTS.PROD_ID
ORDERS JOIN ORDERITEMS
ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
JOIN PRODUCTS
ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
GROUP BY(ORDERS.ORDER_NUM, PRODUCTS.PROD_ID)
HAVING COUNT(DISTINCT PRODUCTS.PROD_ID=2);

