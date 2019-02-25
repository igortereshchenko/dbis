-- LABORATORY WORK 2
-- BY Mykhailenko_Yeva
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ постачальника, за умови, що постачальник не продавав жодного продукту цьому покупцю.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT 
CUSTOMERS.CUST_ID,
VENDORS.VEND_ID
FROM CUSTOMERS, VENDORS 
GROUP BY CUSTOMERS.CUST_ID,
VENDORS.VEND_ID

MINUS 

SELECT 
CUSTOMERS.CUST_ID,
VENDORS.VEND_ID
FROM CUSTOMERS
JOIN ORDERS ON
CUSTOMERS.CUST_ID=ORDERS.CUST_ID
JOIN ORDERITEMS ON
ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
JOIN PRODUCTS ON
ORDERITEMS.PROD_ID=PRODUCTS.PROD_ID
JOIN VENDORS ON 
PRODUCTS.VEND_ID=VENDORS.VEND_ID
GROUP BY CUSTOMERS.CUST_ID,
VENDORS.VEND_ID



/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що купляв по 4 різних товари в рамках одного замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT 
CUSTOMERS.CUST_ID
FROM CUSTOMERS JOIN ORDERS ON
CUSTOMERS.CUST_ID=ORDERS.CUST_ID
JOIN ORDERITEMS ON
ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
JOIN PRODUCTS ON
ORDERITEMS.PROD_ID=PRODUCTS.PROD_ID
JOIN VENDORS ON 
PRODUCTS.VEND_ID=VENDORS.VEND_ID
GROUP BY CUSTOMERS.CUST_ID
HAVING COUNT(DISTINCT ORDERITEMS.PROD_ID)=4
