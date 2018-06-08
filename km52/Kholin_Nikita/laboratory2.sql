-- LABORATORY WORK 2
-- BY Kholin_Nikita
/*---------------------------------------------------------------------------
1. Вивести номер замовлення та ключ постачальника,
вказавши скільки товарів даного постачальника є у даному замовленні.
---------------------------------------------------------------------------*/
--Код відповідь:
SELECT orders.order_num,
  vendors.vend_id,
  COUNT(*)
FROM orders
INNER JOIN orderitems
ON orders.order_num = orderitems.order_num
INNER JOIN products
ON products.prod_id = orderitems.prod_id
INNER JOIN vendors
ON vendors.vend_id = products.vend_id
GROUP BY orders.order_num,
  vendors.vend_id;
/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має замовлення, що містять продукти лише від 3 постачальників.
---------------------------------------------------------------------------*/
--Код відповідь:
SELECT customers.cust_id,
  orders.order_num,
  COUNT(*)
FROM customers
INNER JOIN orders
ON customers.cust_id = orders.cust_id
INNER JOIN orderitems
ON orders.order_num = orderitems.order_num
INNER JOIN products
ON products.prod_id = orderitems.prod_id
INNER JOIN vendors
ON vendors.vend_id = products.vend_id
GROUP BY customers.cust_id,
  orders.order_num
HAVING COUNT(DISTINCT vendors.vend_id) = 3;
