/*---------------------------------------------------------------------------
1. Вивести номери замовлення, кількість продуктів у замовленнях та кількість постачальників, що продавали продукт у замовлення.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT
    ORDERS.ORDER_NUM,
    ORDERITEMS.QUANTITY,
    PRODUCTS.VEND_ID
    FROM ORDERS JOIN ORDERITEMS
    ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
    JOIN PRODUCTS
    ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID;
    
        
    
    








/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, продукти якого містяться тільки у найдешевших замовленнях.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT VEND_ID FROM (SELECT PRODUCTS.VEND_ID, SUM(ORDERITEMS.QUANTITY*ORDERITEMS.ITEM_PRICE) AS ORDER_SUM
            FROM ORDERITEMS JOIN PRODUCTS
            ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID GROUP BY PRODUCTS.VEND_ID)
            WHERE ORDER_SUM = (
SELECT MIN(ORDER_SUM)
        FROM (SELECT PRODUCTS.VEND_ID, SUM(ORDERITEMS.QUANTITY*ORDERITEMS.ITEM_PRICE) AS ORDER_SUM
            FROM ORDERITEMS JOIN PRODUCTS
            ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID GROUP BY PRODUCTS.VEND_ID))
