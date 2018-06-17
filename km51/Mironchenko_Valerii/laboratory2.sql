-- LABORATORY WORK 2
-- BY Mironchenko_Valerii
/*---------------------------------------------------------------------------
1. Вивести ключ продукту, у скількох замовленнях даний продукт продавався та скільком покупцям

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT PRODUCTS.PROD_ID, COUNT(ORDERS.ORDER_ITEM), COUNT(CUSTOMERS.CUST_ID)
FROM PRODUCTS JOIN ORDERITEMS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
              JOIN ORDERS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
              JOIN CUSTOMERS ON ORDERS.CUST_ID = CUSTOMERS.CUST_ID
GROUP BY PRODUCTS.PROD_ID








/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, продукти якого містяться тільки у 4 замовленнях.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT VENDORS.VEND_ID
FROM VENDORS JOIN PRODUCTS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
             JOIN ORDERITEMS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
             JOIN ORDERS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
GROUP BY VENDORS.VEND_ID
HAVING COUNT(PRODUCTS.PROD_NAME) = 4;
             
             
             
