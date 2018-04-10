/*---------------------------------------------------------------------------
1. Вивести ключ покупця, кількість його замовлень та загальну вартість куплених ним товарів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT customers.cust_id, count(*), SUM(orderitems.item_price*orderitems.quantity)
FROM customers join orders on customers.cust_id=orders.cust_id
join orderitems on orders.order_num=orderitems.order_num
GROUP BY customers.cust_id;










/*---------------------------------------------------------------------------
2.  Вивести ключ продукту, що міститься у найдешевших замовленнях покупців, що проживають в Америці.

---------------------------------------------------------------------------*/



--Код відповідь:
SELECT products.prod_id 
FROM (SELECT orders.order_num, SUM(orderitems.item_price*orderitems.quantity) AS minim
FROM customers join orders on customers.cust_id=orders.cust_id
join orderitems on orders.order_num=orderitems.order_num
join products on orderitems.prod_id=products.prod_id
WHERE customers.cust_country='USA'
GROUP BY orders.order_num)
HAVING minim = MIN(minim);
