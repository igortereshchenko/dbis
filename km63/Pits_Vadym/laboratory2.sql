/*---------------------------------------------------------------------------
1. Вивести країну постачальника, що продав менше 2 різних продуктів двом різним покупцям.
-------------------------------------------------------------------------*/
--Код відповідь:

select PRODUCTS.PROD_NAME,
       CUSTOMERS.CUST_NAME,
       VENDORS.VEND_COUNTRY
       
from   VENDORS join PRODUCTS
on     VENDORS.VEND_ID = PRODUCTS.VEND_ID
       join ORDERITEMS 
       on PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
       join ORDERS
       on ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
       join CUSTOMERS
       on ORDERS.CUST_ID = CUSTOMERS.CUST_ID
       
group by VENDORS.VEND_COUNTRY,CUSTOMERS.CUST_NAME
having count (distinct PRODUCTS.PROD_NAME)<2,(distinct CUSTOMERS.CUST_NAME)=2 


/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має замовлення, що містить найдорожчий продукт.
---------------------------------------------------------------------------*/

--Код відповідь:

select CUSTOMERS.CUST_ID
       max(PRODUCTS.PROD_PRICE)
       
from CUSTOMERS join ORDERS
on CUSTOMERS.CUST_ID = ORDERS.CUST_ID
join ORDERITEMS
on ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
join PRODUCTS
on ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID

group by CUSTOMERS.CUST_ID,PRODUCTS.PROD_PRICE
where (distinct CUSTOMERS.CUST_ID) = max(PRODUCTS.PROD_PRICE)
