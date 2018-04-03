-- LABORATORY WORK 2
-- BY Drapak_Volodymyr
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ постачальника та кількість куплених покупцем продуктів у постачальника.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT CUSTOMERS.CUST_ID, VENDORS.VEND_ID,
SUM(ORDERITEMS.QUANTITY)
FROM CUSTOMERS
JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
JOIN PRODUCTS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
JOIN VENDORS ON PRODUCTS.VEND_ID = VENDORS.VEND_ID
GROUP BY CUSTOMERS.CUST_ID, VENDORS.VEND_ID;




  
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника на номери замовлень, що містять по 2 види куплених його товарів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT VEND_ID
FROM(
  SELECT VENDORS.VEND_ID, ORDERITEMS.ORDER_NUM
  FROM VENDORS
  JOIN PRODUCTS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
  JOIN ORDERITEMS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
  GROUP BY VENDORS.VEND_ID, ORDERITEMS.ORDER_NUM
  HAVING COUNT(ORDERITEMS.ORDER_ITEM) = 2
);













