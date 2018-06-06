-- LABORATORY WORK 2
-- BY Lukianchenko_Rehina

/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, кількість його продуктів та загальну вартість проданих ним продуктів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT VEND_COUNT.VEND_ID, COUNT_PROD_ID, SUM_PRICE
FROM 
        
        (SELECT VENDORS.VEND_ID AS VEND_ID , COUNT(PRODUCTS.PROD_ID) AS COUNT_PROD_ID 
        FROM VENDORS LEFT OUTER JOIN PRODUCTS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
        GROUP BY VENDORS.VEND_ID) VEND_COUNT
        
        JOIN 
        
        (SELECT VENDORS.VEND_ID AS VEND_ID , SUM (ORDERITEMS.QUANTITY*ORDERITEMS.ITEM_PRICE) AS SUM_PRICE
        FROM VENDORS LEFT OUTER JOIN PRODUCTS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
                      FULL JOIN ORDERITEMS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
        GROUP BY VENDORS.VEND_ID) VEND_SUM

                ON  VEND_COUNT.VEND_ID = VEND_SUM.VEND_ID;


/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого містить найдешевший продукт.

---------------------------------------------------------------------------*/

--Код відповідь:

    SELECT DISTINCT CUSTOMERS.CUST_ID
    FROM CUSTOMERS JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
                   JOIN ORDERITEMS ON   ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
                   JOIN PRODUCTS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
    WHERE PRODUCTS.PROD_PRICE IN 
                                 (SELECT MIN(PRODUCTS.PROD_PRICE)
                                  FROM PRODUCTS);
