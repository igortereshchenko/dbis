-- LABORATORY WORK 2
/*---------------------------------------------------------------------------
1. Вивести номер замовлення та ключ постачальника, вказавши скільки товарів 
даного постачальника є у даному замовленні.

---------------------------------------------------------------------------*/
--Код відповідь:
Select orderitems.order_num,products.vend_id, sum(orderitems.quantity) suma
from customers join orders
ON customers.cust_id=orders.cust_id
join orderitems
ON orders.order_num=orderitems.order_num
join products
ON orderitems.prod_id=products.prod_id
group by orderitems.order_num,products.vend_id
  

/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має замовлення, що містять продукти лише від 3 
постачальників.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT customers.cust_id, count(distinct products.vend_id) counter
from customers join orders
ON customers.cust_id=orders.cust_id
join orderitems
ON orders.order_num=orderitems.order_num
join products
ON orderitems.prod_id=products.prod_id
group by customers.cust_id
having count(distinct products.vend_id)=3;
-- BY Beshta_Vladyslav
