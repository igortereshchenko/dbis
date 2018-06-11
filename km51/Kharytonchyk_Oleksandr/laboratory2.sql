-- LABORATORY WORK 2
-- BY Kharytonchyk_Oleksandr
/*---------------------------------------------------------------------------
1. Вивести ключ покупця, кількість його замовлень та загальну вартість куплених ним товарів.

---------------------------------------------------------------------------*/
--Код відповідь:


SELECT CUSTOMERS.CUST_ID,
       COUNT(DISTINCT ORDERS.ORDER_NUM) AS ORDER_QUNTITY,
       SUM(ORDERITEMS.QUANTITY * ORDERITEMS.ITEM_PRICE) AS PRODUCT_PRICE
       FROM CUSTOMERS JOIN ORDERS
              ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
              JOIN ORDERITEMS 
              ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM   
       GROUP BY (CUSTOMERS.CUST_ID);





/*---------------------------------------------------------------------------
2.  Вивести ключ продукту, що міститься у найдешевших замовленнях покупців, що проживають в Америці.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUSTOMERS.PROD_ID
FROM (
SELECT CUSTOMERS.CUST_ID,
       SUM(ORDERITEMS.QUANTITY * ORDERITEMS.ITEM_PRICE) AS PRODUCT_PRICE
       FROM CUSTOMERS JOIN ORDERS
              ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
              JOIN ORDERITEMS 
              ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NU
      WHERE (CUSTOMERS.CUST_COUNTRY = 'USA')
      HAVING MIN(PRODUCT_PRICE));
