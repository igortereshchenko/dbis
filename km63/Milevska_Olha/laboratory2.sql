-- LABORATORY WORK 2
-- BY Milevska_Olha

/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що продав більше 2 одиниць продуктів різним покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:

select distinct info.vend_id from(
select vendors.vend_id, orders.cust_id count(orderitems.prod_id) from
	vendors join products on vendors.vend_id = products.vend_id
		join orderitems on products.prod_id = orderitems.prod_id
		join oders on ordertimes.order_num = orders.order num
	group by vendors.vend_id, orders.cust_id
	having count(distinct orderitems.prod_id)>=2)info;








/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що не має найдорожче замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:
select vendors.vend_id, max(orderitems.quantity*orderitems.item_price) as max_price
from orderitems 
join products on (oderitems.prod_id = products.prod_id)
join vendors on (products.vend_id = vendors.vend_id)
group by vendors.vend_id;








