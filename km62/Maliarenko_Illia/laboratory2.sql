/*---------------------------------------------------------------------------
1. Вивести ім'я покупця, номер замовлення та назву продукту, що найменше було куплено у кожному замовленні покупця.

---------------------------------------------------------------------------*/
--Код відповідь:
select customers.cust_name, orders.order_num, products.prod_name
from customers, orders, orderitems, products
where orderitems.order_num in 

select 
in (select order_num, min(orderitems.quantity) as minquant
            from products inner join orderitems using(prod_id)
              inner join orders using(order_num)
            group by order_num)






  
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника, що продавав свої продукти лише трьом покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:
select products.VEND_ID
from orders inner join orderitems using(order_num)
  inner join products using(prod_id)
group by products.VEND_ID
having count(distinct orders.cust_id) = 3
