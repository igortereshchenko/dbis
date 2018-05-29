-- LABORATORY WORK 2
-- BY Milevska_Olha

/*---------------------------------------------------------------------------
1. Вивести країну постачальника, що продав менше 2 різних продуктів двом різним покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:

select distinct info.vend_country from
(select vendors.vend_id,orders.cust_id, count(orderitems.prod_id)
from vendors
join products on vendors.vend_id = products.vend_id
join orderitems on products.prod_id = orderitems.prod_id
join orders on orderitems.order_num = orders.order_num
group by vendors.vend_id,orders.cust_id
having count(distinct orderitems.prod_id) =<2) info;




/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має замовлення, що містить найдорожчий продукт.

---------------------------------------------------------------------------*/

--Код відповідь:

select customers.cust_id
from customers
join orders on customers.cust_id = orders.cust_id
join orderitems on orders.order_num = orderitems.order_num
join products on orderitems.prod_id = products.prod_id
where products.prod_price = max(products.prod price);







