/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що продав менше 2 різних продуктів одному покупцю.

---------------------------------------------------------------------------*/
--Код відповідь:
    
 SELECT VENDORS.VEND_ID, 
 FROM
 
 SELECT
 DISTINCT
 ORDERITEMS.ORDER_NUM,
 PRODUCTS.PROD_NAME
 FROM
 PRODUCTS JOIN ORDERITEMS
 ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
 
 SELECT VENDOR_ID.*
 (SELECT VENDORS.VEND_ID, ORDERS.ORDER_NUM COUNT(ORDERITEMS.PROD_ID)
 FROM VENDORS JOIN PRODUCTS 
 ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
 JOIN ORDERITEMS 
 ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
 
 GROUP BY VENDORS.VEND_ID, ORDERITEMS.PROD_ID
 HAVING COUNT(DISTINCT ORDERITEMS.PROD_ID < 2)VENDORS.VEND_ID
 
      
/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має не найдешевше замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUSTOMERS.CUST_ID
FROM 
(SELECT ORDERITEMS.ITEM_PRICE
FROM CUSTOMERS.CUST_ID JOIN ORDERS.ORDER_NUM
ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
JOIN ORDERITEMS.ITEM_PRICE
ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
