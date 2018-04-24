-- LABORATORY WORK 2
-- BY Larionova_Yuliia
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що не продав більше 2 продуктів різним покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:


select vendors.vend_id
from vendors 
join products on products.vend_id = vendors.vend_id
join orderitems on products.prod_id = orderitems.prod_id
join orders on orderitems.order_num = orders.order_num
group by vendors.vend_id
having count(distinct orders.cust_id) > 2;

/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має найдешевше замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:
select customers.cust_id
from customers
join orders on customers.cust_id = orders.cust_id
join orderitems on orders.order_num = orderitems.order_num
group by customers.cust_id
having min(sum(orderitems.quantity * orderitems.item_price))
