-- LABORATORY WORK 2
-- BY Moroziuk_Yevhenii
/*---------------------------------------------------------------------------
1. Вивести ключ продукту та ключ його постачальника, за умови, що даний продукт продавався у трьох замовленнях,
   загальна вартість кожного зних більша 500.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT
PRODUCTS.PROD_ID,
VENDORS.VEND_ID
FROM VENDORS JOIN PRODUCTS 
ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
JOIN ORDERITEMS ON
PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
GROUP BY PRODUCTS.PROD_ID,VENDORS.VEND_ID
HAVING COUNT(DISTINCT ORDERITEMS.PROD_ID)=3 AND SUM(ORDERITEMS.QUANTITY*ORDERITEMS.ITEM_PRICE)>500;

  
/* --------------------------------------------------------------------------- 
2.  Вивести назви країн та вказати, скільки в ній живе постачальників і скільки покупців продуктів цих постачальників.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT -- WITHOUT CUST_COUNTRY
    DISTINCT VENDORS.VEND_COUNTRY AS VEND_COUNTRY,
    COUNT(VENDORS.VEND_COUNTRY) AS VEND_COUNT
    FROM VENDORS
    GROUP BY VENDORS.VEND_COUNTRY
    
-- COUNT(CUSTOMERS.CUST_COUNTRY) AS CUST_COUNT
 --JOIN PRODUCTS ON
           /* VENDORS.VEND_ID = PRODUCTS.VEND_ID
                 JOIN ORDERITEMS ON 
            PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
                JOIN ORDERS ON
            ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
                JOIN CUSTOMERS ON
            ORDERS.CUST_ID = CUSTOMERS.CUST_ID*/











