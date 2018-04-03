-- LABORATORY WORK 2
-- BY Bilenko_Vladyslav
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту за умови, що customer купив більше 5 одиниць цього продукту.

---------------------------------------------------------------------------*/
--Код відповідь:

select orders.cust_id, orderitems.prod_id
from orders join orderitems
on orderitems.order_item > 5;






  
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника на номери замовлень, що містять більше одного з його товарів.

---------------------------------------------------------------------------*/
--Код відповідь:


select products.vend_id, orderitems.ORDER_NUM
from products left join orderitems
on orderitems.ORDER_NUM in (
select count(prod_id) from orderitems
where 
(vend_id = prod_id) and count(prod_id) > 2 );
