-- LABORATORY WORK 2
-- BY Onishchenko_Andrii

/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що продав менше 2 різних продуктів одному покупцю.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT DISTINCT INFO.VEND_ID FROM
(SELECT VENDORS.VEND_ID, ORDERS.CUST_ID, COUNT(ORDERITEMS.PROD_ID) FROM
VENDORS JOIN PRODUCTS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
JOIN ORDERITEMS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
JOIN ORDERS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
GROUP BY VENDORS.VEND_ID, ORDERS.CUST_ID
HAVING COUNT (DISTINCT ORDERITEMS.PROD_ID)>1) INFO;











/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має не найдешевше замовлення.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT DISTINCT ORDERS.CUST ID
FROM ORDERS JOIN (SELECT DISTINCT ORDERITEMS.ORDER_NUM AS NEEDED_NUM
FROM ORDERITEMS JOIN (SELECT PROD_ID AS NEEDED_PRODID 
FROM PRODUCTS
WHERE PRODPRICE = SELECT
MIN(PRODUCTS.PROD_PRICE) AS MIN_PRICE FROM PRODUCTS))
ON ORDERITEMS.PROD_ID = NEEDED_PRODID)
ON ORDERS.ORDER_NUM = NEEDED_NUM;










