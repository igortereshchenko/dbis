/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ постачальника, за умови, що постачальник не продавав жодного продукту цьому покупцю.

---------------------------------------------------------------------------*/
--Код відповідь:

select customers.cust_id, vendors.vend_id
from customers, vendors

minus

select customers.cust_id, vendors.vend_id
from customers join orders on customers.cust_id = orders.cust_id
    join orderitems on orders.order_num = orderitems.order_num
    join products on orderitems.prod_id = products.prod_id
    join vendors on products.vend_id = vendors.vend_id;




/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що купляв по 4 різних товари в рамках одного замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:

select customers.cust_id
from customers join orders on customers.cust_id = orders.cust_id
    join orderitems on orders.order_num = orderitems.order_num
group by customers.cust_id, orderitems.order_num
having count(distinct orderitems.prod_id) = 4;

