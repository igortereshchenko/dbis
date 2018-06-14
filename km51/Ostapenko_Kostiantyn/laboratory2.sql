-- LABORATORY WORK 2
-- BY Ostapenko_Kostiantyn

/*---------------------------------------------------------------------------
1. Вивести країну постачальника, що продав менше 2 різних продуктів двом різним покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:

select  vendors.vend_country,  count(orderitems.order_num)
from vendors
full join products on products.vend_id=vendors.vend_id
full join orderitems on orderitems.prod_id=products.prod_id

group by vendors.vend_country
having(count(orderitems.order_num)<2);







/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має замовлення, що містить найдорожчий продукт.

---------------------------------------------------------------------------*/

--Код відповідь:

select orders.cust_id,max(products.prod_price) from Customers
 inner join Orders on Orders.cust_id=Customers.cust_id
 inner join orderitems on orderitems.order_num=orders.order_num
 inner join products on products.prod_id= orderitems.prod_id
 group by customers.cust_id, products.prod_id
 HAVING(max(products.prod_price)=products.prod_price);
 
 


 
