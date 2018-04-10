-- LABORATORY WORK 2
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, кількість його продуктів та загальну вартість проданих ним продуктів.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT VENDORS.VEND_ID, 
      COUNT(ORDERITEMS.QUANTITY) AS sumOfProducts, 
      SUM(ORDERITEMS.QUANTITY*ORDERITEMS.ITEM_PRICE) AS ORDER_SUM
      
FROM CUSTOMERS JOIN ORDERS
  ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
    JOIN ORDERITEMS
      ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
      
GROUP BY VENDORS.VEND_ID, sumOfProducts, ORDER_SUM; 


/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого містить найдешевший продукт.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT CUSTOMERS.CUST_ID

FROM CUSTOMERS JOIN ORDERS
  ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
               JOIN ORDERITEMS 
  ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
               JOIN PRODUCTS
  ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
  
GROUP BY CUSTOMERS.CUST_ID

HAVING (ORDERITEMS.ITEM_PRICE) IN 
  (SELECT ORDERITEMS.ITEM_PRICE
    FROM  ORDERITEMS
    WHERE ORDERITEMS.ITEM_PRICE = MIN(ORDERITEMS.ITEM_PRICE));
-- BY Vovchenko_Ivan
