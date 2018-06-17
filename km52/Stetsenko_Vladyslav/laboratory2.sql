/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту, за умови, що покупець ніколи не купляв даний продукт.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT PRODUCTS.PROD_ID, CUSTOMERS.CUST_ID FROM (
  CUSTOMERS JOIN ORDERS
    ON ORDERS.CUST_ID=CUSTOMERS.CUST_ID JOIN ORDERITEMS
        ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM JOIN PRODUCTS
            ON ORDERITEMS.PROD_ID=PRODUCTS.PROD_ID
) WHERE ORDERS.ORDER_NUM is NULL
;







/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, що працював з покупцем, що має найдорожче замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT VENDORS.VEND_ID, MAX(ORDERITEMS.ITEM_PRICE) FROM PRODUCTS JOIN VENDORS 
  ON PRODUCTS.VEND_ID=VENDORS.VEND_ID JOIN ORDERITEMS
    ON ORDERITEMS.PROD_ID=PRODUCTS.PROD_ID GROUP BY VENDORS.VEND_ID;
