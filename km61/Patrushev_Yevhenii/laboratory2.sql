-- LABORATORY WORK 2
-- BY Patrushev_Yevhenii
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту за умови, що customer купив більше 5 одиниць цього продукту.

---------------------------------------------------------------------------*/
--Код відповідь:


select customers.cust_id, orderitems.prod_id
from customers join orders
on customers.cust_id = orders.cust_id
join orderitems
on orders.order_num = orderitems.order_num
group by customers.cust_id, orderitems.prod_id
having sum(orderitems.quantity)>5
order by 1;


  
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника на номери замовлень, що містять більше одного з його товарів.

---------------------------------------------------------------------------*/
--Код відповідь:


select orderitems.order_num, vendors.vend_id
from orderitems join products
on orderitems.prod_id = products.prod_id
join vendors
on vendors.vend_id = products.vend_id
group by orderitems.order_num, vendors.vend_id
having count( distinct orderitems.prod_id)>1
order by 1;
