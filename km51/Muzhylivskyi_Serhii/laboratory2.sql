-- LABORATORY WORK 2
-- BY Muzhylivskyi_Serhii
/*---------------------------------------------------------------------------
1. Вивести ключ покупця, кількість його замовлень та загальну вартість куплених ним товарів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT 
    CUSTOMERS.CUST_ID,
    COUNT(DISTINCT ORDERITEMS.ORDER_ITEM),
    SUM(ORDERITEMS.ITEM_PRICE * ORDERITEMS.QUANTITY)
FROM
    CUSTOMERS JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID 
    JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
GROUP BY CUSTOMERS.CUST_ID;









/*---------------------------------------------------------------------------
2.  Вивести ключ продукту, що міститься у найдешевших замовленнях покупців, що проживають в Америці.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT 
    ORDERITEMS.PROD_ID
FROM
    ORDERITEMS JOIN ORDERS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
    JOIN CUSTOMERS ON ORDERS.CUST_ID = CUSTOMERS.CUST_ID
    GROUP ORDERITEMS.PROD_ID
WHERE CUSTOMERS.CUST_COUNTRY = 'USA';
    
    
