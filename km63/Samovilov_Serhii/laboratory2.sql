-- LABORATORY WORK 2
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ постачальника, за умови, що постачальник не продавав жодного продукту цьому покупцю.
---------------------------------------------------------------------------*/
--Код відповідь:*/
SELECT RESULT.CUST_ID, RESULT.VEND_ID 
FROM(
select CUSTOMERS.CUST_ID, VENDORS.VEND_ID, COUNT(VENDORS.VEND_ID)
from CUSTOMERS JOIN ORDERS 
  ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
JOIN ORDERITEMS 
  ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
 JOIN PRODUCTS 
  ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
  RIGHT JOIN VENDORS
  ON PRODUCTS.VEND_ID = VENDORS.VEND_ID
WHERE PRODUCTS.VEND_ID IS NULL
GROUP BY CUSTOMERS.CUST_ID, VENDORS.VEND_ID
  ) RESULT;



/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що купляв по 4 різних товари в рамках одного замовлення.
---------------------------------------------------------------------------*/
--Код відповідь:*/
 select RESULT.CUST_ID  
FROM (select 
        CUSTOMERS.CUST_ID,
        ORDERS.ORDER_NUM,
        count(distinct ORDERITEMS.PROD_ID)
      from CUSTOMERS join ORDERS 
        ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
      JOIN ORDERITEMS 
        ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
      group by CUSTOMERS.CUST_ID, ORDERS.ORDER_NUM
      having count(distinct ORDERITEMS.PROD_ID) = 4 
        )RESULT   
    
-- BY Samovilov_Serhii
