-- LABORATORY WORK 2
-- BY Vozniak_Anastasiia
/*---------------------------------------------------------------------------
1. Вивести номер замовлення та ключ постачальника, за умови, що жодного з продуктів цього постачальника у замовленні нема.

---------------------------------------------------------------------------*/
--Код відповідь:

 Select orderitems.order_num, 
Products.vend_id from
Orders  Join Orderitems
On orders.order_num=orderitems.order_num
Join products on
orderitems.prod_id=products.prod_id
join vendors on 
products.vend_id=vendors.vend_id
where 
products.PROD_ID not in (select prod_id from orderitems)
;





/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що працював з постачальником, що продає найменшу кількість продуктів.

---------------------------------------------------------------------------*/

--Код відповідь:


Select orders.cust_id 
From ( Select orders.cust_id, 
vendors.vend_id, orderitems.quantity From
Orders  Join Orderitems
On orders.order_num=orderitems.order_num
Join products on
orderitems.prod_id=products.prod_id
join vendors on 
products.vend_id=vendors.vend_id


Group by orderitems.quantity,orderitems.prod_id
Having (sum(orderitems.quantity)=min((orderitems.quantity)))
)

;
