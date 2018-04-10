-- LABORATORY WORK 2
-- BY Shanin_Vladyslav

/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, кількість його продуктів та загальну вартість проданих ним продуктів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT 
    VENDORS.VEND_ID,
    COUNT(DISTINCT PRODUCTS.PROD_ID),
    NVL(SUM(ORDERITEMS.ITEM_PRICE * ORDERITEMS.QUANTITY), 0)
FROM
    VENDORS
    LEFT JOIN PRODUCTS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
    LEFT JOIN ORDERITEMS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
GROUP BY VENDORS.VEND_ID;

/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого містить найдешевший продукт.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT 
    CUSTOMERS.CUST_ID
FROM
    CUSTOMERS
    JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
WHERE
    ORDERS.ORDER_NUM IN (SELECT 
                             ORDER_NUM
                         FROM
                             ORDERITEMS
                         WHERE ITEM_PRICE IN (SELECT MIN(ITEM_PRICE) 
                                              FROM ORDERITEMS));
