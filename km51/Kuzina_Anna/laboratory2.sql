-- LABORATORY WORK 2
-- BY Kuzina_Anna
/*---------------------------------------------------------------------------
1. Вивести ключ покупця, кількість його замовлень та загальну вартість куплених ним товарів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT 

    CUSTOMERS.CUST_ID,
    COUNT(DISTINCT ORDERITEMS.ORDER_ITEM) as COUNT_ORDER_ITEM ,
    SUM(ORDERITEMS.ITEM_PRICE * ORDERITEMS.QUANTITY) as SUM_ITEM_PRICE

FROM

    CUSTOMERS JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID 
    JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
    GROUP BY CUSTOMERS.CUST_ID;










/*---------------------------------------------------------------------------
2.  Вивести ключ продукту, що міститься у найдешевших замовленнях покупців, що проживають в Америці.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT *
FROM (
SELECT CUSTOMERS.CUST_ID,
       CUSTOMERS.CUST_COUNTRY,
       SUM(ORDERITEMS.QUANTITY * ORDERITEMS.ITEM_PRICE) AS PRODUCT_PRICE
       FROM CUSTOMERS JOIN ORDERS
              ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
              JOIN ORDERITEMS 
              ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
              JOIN PRODUCTS
              ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
      WHERE CUSTOMERS.CUST_COUNTRY LIKE '%USA%'
      GROUP BY CUSTOMERS.CUST_ID, CUSTOMERS.CUST_COUNTRY
      )
      info;

