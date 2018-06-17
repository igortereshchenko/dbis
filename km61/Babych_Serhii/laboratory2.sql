-- LABORATORY WORK 2
-- BY Babych_Serhii
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту за умови, що покупець купив більше 5 одиниць цього продукту.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT
    CUSTOMERS.CUST_ID,
    PRODUCTS.PROD_ID
    FROM
        CUSTOMERS 
        JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
        JOIN ORDERITEMS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
        JOIN PRODUCTS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
        
    GROUP BY CUSTOMERS.CUST_ID, PRODUCTS.PORD_ID
    HAVING COUNT( ORDERITEMS.QUANTITY > 5)






  
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника на номери замовлень, що містять більше одного з його товарів.

---------------------------------------------------------------------------*/
--Код відповідь:

    SELECT VEND_ID
    FROM ( 
        SELECT VENDORS.VEND_ID, PRODUTS.PROD_ID
        FROM VENDORS 
            JOIN PRODUTS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
            JOIN ORDERITEMS ON PRODUTS.PROD_ID = ORDERITEMS.PROD_ID
            JOIN ORDERS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
            
        GROUP BY VENDORS.VEND_ID
        HAVING COUNT(ORDERITEMS.ORDER_NUM > 1)), VEND_ID ;
