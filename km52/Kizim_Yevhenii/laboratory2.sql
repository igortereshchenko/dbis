-- LABORATORY WORK 2
-- BY Kizim_Yevhenii
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, кількість його продуктів та загальну вартість проданих ним продуктів.

---------------------------------------------------------------------------*/
--Код відповідь:

--- QUANTITY IS NOT CORRECT ---
SELECT INFO1.VEND_ID, INFO1.SELLED_SUM, INFO2.QUANTITY
FROM 
(SELECT VENDORS.VEND_ID, SUM(ORDERITEMS.QUANTITY * ORDERITEMS.ITEM_PRICE) AS SELLED_SUM
FROM VENDORS JOIN PRODUCTS
        ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
    LEFT JOIN ORDERITEMS
        ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID

GROUP BY VENDORS.VEND_ID) INFO1,

--- QUANTITY OF PRODUCTS ---
(SELECT VENDORS.VEND_ID, COUNT(VENDORS.VEND_ID) AS QUANTITY 
FROM VENDORS JOIN PRODUCTS
    ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
GROUP BY VENDORS.VEND_ID) INFO2
WHERE INFO1.VEND_ID = INFO2.VEND_ID;








/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого містить найдешевший продукт.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT DISTINCT CUSTOMERS.CUST_ID
FROM CUSTOMERS JOIN ORDERS 
        ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
    JOIN ORDERITEMS 
        ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
WHERE ORDERITEMS.PROD_ID IN (
            SELECT PRODUCTS.PROD_ID 
            FROM PRODUCTS
            WHERE PRODUCTS.PROD_PRICE = (SELECT MIN(PROD_PRICE) FROM PRODUCTS));

--- CHEAPEST PRODUCTS ---
/*SELECT PRODUCTS.PROD_ID 
FROM PRODUCTS
WHERE PRODUCTS.PROD_PRICE = (SELECT MIN(PROD_PRICE) FROM PRODUCTS);*/
