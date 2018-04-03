-- LABORATORY WORK 2
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту за умови, що покупець купив більше 5 одиниць цього продукту.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT 
   info.СUST_ID,
   info.PROD_ID
  FROM
  (SELECT
  CUSTOMERS.CUST_ID,
  ORDERS.ORDER_ID
 FROM
    CUSTOMERS JOIN ORDERS
     ON CUSTOMERS.CUST_ID=ORDERS.CUST_ID
    JOIN ORDERITEMS 
     ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
    JOIN PRODUCTS
     ON ORDERITEMS.PROD_ID=PRODUCS.PROD_ID
    JOIN VENDORS
     ON PRODUCTS.VEND_ID=VENDORS.VEND_ID
  GROUP BY CUSTOMERS.CUST_ID,CUSTOMERS.CUST_NAME
HAVING COUNT(DISTINCT ORDERS.ORDER_ITEM)>5*/))info;




  
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника на номери замовлень, що містять більше одного з його товарів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT
  info.ORDER_NUM,
  info.VEND_ID
 FROM
  (SELECT
   VENDORSRS.VEND_ID,
  ORDERS.VEND_ID
 FROM
    CUSTOMERS JOIN ORDERS
     ON CUSTOMERS.CUST_ID=ORDERS.CUST_ID
    JOIN ORDERITEMS 
     ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
    JOIN PRODUCTS
     ON ORDERITEMS.PROD_ID=PRODUCS.PROD_ID
    JOIN VENDORS
     ON PRODUCTS.VEND_ID=VENDORS.VEND_ID
  GROUP BY CUSTOMERS.CUST_ID,CUSTOMERS.CUST_NAME
HAVING COUNT(DISTINCT VENDORS.VEND_ID)>5*/))info;
     
-- BY Kolobaieva_Kateryna
