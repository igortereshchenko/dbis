/*---------------------------------------------------------------------------
1. Вивести ключ продукту та ключ його постачальника, за умови, що даний продукт продавався у трьох замовленнях, загальна вартість кожного зних більша 500.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT 
  info.PROD_ID,
  info.VEND_ID
FROM 
  (SELECT PRODUCTS.PROD_ID 
          VENDORS.VEND_ID
  FROM PRODUCTS JOIN ORDERITEMS
    ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
                JOIN ORDERS
    ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
                JOIN VENDORS
    ON PRODUCTS.VEND_ID = VENDORS.VEND_ID
GROUP BY  ORDERITEMS.PROD_ID,  ORDERITEMS.ORDER_NUM
HAVING COUNT(DISTINCT ORDERITEMS.PROD_ID )=3 and ORDERITEMS.ITEM_PRICE >500)info;








  
/* --------------------------------------------------------------------------- 
2.  Вивести назви країн та вказати, скільки в ній живе постачальників і скільки покупців продуктів цих постачальників.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT 
info.VEND_COUNTRY,
info.CUST_COUNTRY
FROM(SELECT CUSTOMERS.CUST_COUNTRY, VENDORS.VEND_COUNTRY
FROM CUSTOMERS JOIN ORDERS
    ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
    JOIN ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
GROUP BY  ORDERITEMS.PROD_ID,  ORDERITEMS.ORDER_NUM
HAVING COUNT(DISTINCT VENDORS.VEND_COUNTRY = COUNT(DISTINCT ORDERS.PROD_ID)))info;
