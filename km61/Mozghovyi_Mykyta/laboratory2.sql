-- LABORATORY WORK 2
-- BY Mozghovyi_Mykyta
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ постачальника та кількість куплених покупцем продуктів у постачальника.

---------------------------------------------------------------------------*/
--Код відповідь:
select customers.cust_id,vendors.vend_id,sum(orderitems.quantity)
from customers join orders
    on customers.cust_id=orders.cust_id
    join orderitems
    on orders.order_num=orderitems.order_num
    join products
    on products.prod_id=orderitems.prod_id
    join vendors
    on vendors.vend_id=products.vend_id
group by customers.cust_id,vendors.vend_id;

/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника та номери замовлень, що містять рівно по 2 вида куплених його товарів.
---------------------------------------------------------------------------*/
--Код відповідь:
select orderitems.order_num,vendors.vend_id
from orderitems join products
    on products.prod_id=orderitems.prod_id
    join vendors
    on vendors.vend_id=products.vend_id
group by orderitems.order_num,vendors.vend_id
having count(orderitems.prod_id)=2;
