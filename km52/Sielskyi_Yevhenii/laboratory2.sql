-- LABORATORY WORK 2
-- BY Sielskyi_Yevhenii
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ постачальника, за умови, що постачальник не продавав жодного продукту цьому покупцю.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT DISTINCT CUSTOMERs.CUST_ID,
        VENDORS.VEND_ID
FROM CUSTOMERS FULL OUTER JOIN (
    Select DISTINCT
     CUSTOMERS.CUST_ID,
     VENDORS.VEND_ID
    FROM CUSTOMERS JOIN ORDERS
           ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
             JOIN ORDERITEMS
           ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
             JOIN PRODUCTS
           ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
             JOIN VENDORS
           ON PRODUCTS.VEND_ID = VENDORS.VEND_ID) CUSTOMER_VENDOR 
    ON CUSTOMERS.CUST_ID = CUSTOMER_VENDOR.CUST_ID
        FULL OUTER JOIN VENDORS 
    ON CUSTOMER_VENDOR.VEND_ID = VENDORS.VEND_ID
    WHERE CUSTOMERS.CUST_ID is NULL OR
        VENDORS.VEND_ID is NULL







/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що купляв по 4 різних товари в рамках одного замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT *
FROM (
        Select Customers.CUST_ID,
               COUNT(DISTINCT ORDERITEMS.PROD_ID) AS PROD_COUNT
        From CUSTOMERS JOIN ORDERS
            ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
                JOIN ORDERITEMS
            ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
            
            GROUP BY CUSTOMERS.CUST_ID )
WHERE PROD_COUNT = 4;
