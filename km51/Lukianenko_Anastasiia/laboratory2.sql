/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, кількість його продуктів та загальну вартість проданих ним продуктів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT
   VENDORS.VEND_ID,
    COUNT(DISTINCT PRODUCTS.PROD_ID) AS PROD_COUNT,
    SUM(QUANTITY * ITEM_PRICE) AS SUM_PROD
FROM VENDORS LEFT JOIN (PRODUCTS LEFT JOIN ORDERITEMS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID) ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
GROUP BY VENDORS.VEND_ID;


/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого містить найдешевший продукт.

---------------------------------------------------------------------------*/

--Код відповідь:
        
SELECT DISTINCT ORDERS.CUST_ID
FROM ORDERS JOIN (SELECT DISTINCT ORDERITEMS.ORDER_NUM AS NEEDED_NUM
        FROM ORDERITEMS JOIN (SELECT PROD_ID AS NEEDED_PRODID
        FROM PRODUCTS
        WHERE PROD_PRICE =(SELECT
            MIN(PRODUCTS.PROD_PRICE) AS MIN_PRICE
        FROM PRODUCTS))
        ON ORDERITEMS.PROD_ID = NEEDED_PRODID
        )
ON ORDERS.ORDER_NUM = NEEDED_NUM;
