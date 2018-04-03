-- LABORATORY WORK 2
-- BY Kutsenko_Oleksandr

/*---------------------------------------------------------------------------
1. Вивести номер замовлення та ключ постачальника, вказавши скільки товарів даного постачальника є у даному замовленні.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT Orderitems.order_num , products.vend_id , count(Orderitems.order_num)as count_vend FROM orderitems JOIN products 
ON orderitems.prod_id=products.prod_id 
GROUP BY Orderitems.order_num, products.vend_id 
ORDER BY Orderitems.order_num;








  

/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має замовлення, що містять тільки по одному товару.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT orders.cust_id FROM orders JOIN orderitems 
ON orders.order_num = orderitems.order_num
GROUP BY orders.cust_id HAVING COUNT(orderitems.prod_id)<2;








