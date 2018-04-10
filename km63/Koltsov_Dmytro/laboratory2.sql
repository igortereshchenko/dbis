-- LABORATORY WORK 2
-- BY Koltsov_Dmytro
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, кількість його продуктів та загальну вартість проданих ним продуктів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT 
    PRODUCTS.VEND_ID,
    COUNT (PRODUCTS.VEND_ID) as ADDf
    FROM PRODUCTS
    GROUP BY  PRODUCTS.VEND_ID;
    
SELECT
    SUM (ORDERITEMS.QUANTITY*ORDERITEMS.ITEM_PRICE) AS INITR,
    PRODUCTS.VEND_ID
    FROM
    ORDERITEMS JOIN PRODUCTS
        ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
    JOIN VENDORS
        ON PRODUCTS.VEND_ID = VENDORS.VEND_ID
    GROUP BY PRODUCTS.VEND_ID
    









/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого містить найдешевший продукт.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT DISTINCT
    CUSTOMERS.CUST_ID
    FROM
    CUSTOMERS JOIN ORDERS
        ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
    JOIN ORDERITEMS
        ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
     
    WHERE ORDERITEMS.ITEM_PRICE IN (SELECT 
                MIN(ITEM_PRICE)
                FROM ORDERITEMS) 
    
