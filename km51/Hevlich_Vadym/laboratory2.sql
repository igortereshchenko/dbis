-- LABORATORY WORK 2
-- BY Hevlich_Vadym

/*---------------------------------------------------------------------------
1. Вивести ключ продукту, у скількох замовленнях даний продукт продавався та скільком покупцям

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT
    PRODUCTS.PROD_ID,
    COUNT(ORDERS.ORDER_NUM) AS PROD_ORDERS_COUNT,
    COUNT(CUSTOMERS.CUST_ID) AS PROD_CUSTOMERS_COUNT
FROM PRODUCTS
    JOIN
    ORDERITEMS
    ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
    JOIN
    ORDERS
    ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
    JOIN
    CUSTOMERS
    ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
    GROUP BY PRODUCTS.PROD_ID;


/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, продукти якого містяться тільки у 4 замовленнях.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT 
    VENDORS.VEND_ID
FROM
    VENDORS
    JOIN
    PRODUCTS
    ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
    JOIN
    ORDERITEMS
    ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
    JOIN
    ORDERS
    ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
    GROUP BY VENDORS.VEND_ID
    HAVING COUNT(ORDERS.ORDER_NUM) = 4;
