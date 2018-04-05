-- LABORATORY WORK 2
/*---------------------------------------------------------------------------
1. Вивести ключ продукту та ключ його постачальника, за умови, що даний продукт продавався у трьох замовленнях, загальна вартість кожного зних більша 500.

---------------------------------------------------------------------------*/
--Код відповідь:


SELECT PRODUCTS.PROD_ID , PRODUCTS.VEND_ID
FROM PRODUCTS;



SELECT ORDERITEMS.PROD_ID,COUNT(ORDERITEMS.ORDER_NUM)
FROM ORDERITEMS
GROUP BY ORDERITEMS.PROD_ID
;





  
/* --------------------------------------------------------------------------- 
2.  Вивести назви країн та вказати, скільки в ній живе постачальників і скільки покупців продуктів цих постачальників.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT VENDORS.VEND_ID, VENDORS.VEND_COUNTRY,COUNT(VENDORS.VEND_ID)
FROM VENDORS
GROUP BY VEND_COUNTRY;

SELECT ORDERS.CUST_ID,COUNT(DISTINCT ORD)
FROM ORDERS JOIN (
SELECT PRODUCTS.VEND_ID,ORDERITEMS.ORDER_NUM AS ORD 
FROM PRODUCTS JOIN ORDERITEMS
ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID)
ON ORDERS.ORDER_NUM = ORD
GROUP BY CUST_ID;


-- BY Antonov_Mykhailo
