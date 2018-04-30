-- LABORATORY WORK 2/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту за умови, що покупець купив більше 5 одиниць цього продукту.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT 
   CUSROMERS.СUST_ID,
   ORDERS.PROD_ID
 FROM
    CUSTOMERS JOIN ORDERS
     ON CUSTOMERS.CUST_ID=ORDERS.CUST_ID
    JOIN ORDERITEMS 
     ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
    JOIN PRODUCTS
     ON ORDERITEMS.PROD_ID=PRODUCS.PROD_ID
  GROUP BY CUSTOMERS.CUST_ID,ORDERITEMS.PROD_ID
HAVING SUM(ORDERITEMS.QUANTITY)>5
ORDER BY 1;



  
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника на номери замовлень, що містять більше одного з його товарів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT
  ORDERS.ORDER_NUM,
  VENDORS.VEND_ID
 FROM
    ORDERITEMS JOIN PRODUCTS
     ON ORDERITEMS.PROD_ID=PRODUCS.PROD_ID
    JOIN VENDORS
     ON PRODUCTS.VEND_ID=VENDORS.VEND_ID
  GROUP BY ORDERITEMS.ORDER_NUM,VENDORS.VEND_ID
HAVING COUNT(DISTINCT ORDERITEMS.PROD_ID)>1
ORDER BY 1;
-- BY Kolobaieva_Kateryna
