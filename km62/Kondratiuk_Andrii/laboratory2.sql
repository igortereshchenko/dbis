-- LABORATORY WORK 2
-- BY Kondratiuk_Andrii
/*---------------------------------------------------------------------------
1. Вивести ключ продукту та ключ його постачальника, за умови, що даний продукт продавався у трьох замовленнях, загальна вартість кожного зних більша 500.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT products.prod_id, vendors.vend_id
FROM orderitems
JOIN products ON orderitems.prod_id = products.prod_id
JOIN vendors ON products.vend_id = vendors.vend_id
GROUP BY products.prod_id, vendors.vend_id
HAVING some_name IN
(
  SELECT order_num, (DISTINCT prod_id) FROM orderitems
  WHERE order_num > 3));






  
/* --------------------------------------------------------------------------- 
2.  Вивести назви країн та вказати, скільки в ній живе постачальників і скільки покупців продуктів цих постачальників.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT DISTINCT vendors.vend_country, vendors.vend_id, customers.cust_id 
FROM customers
JOIN orders ON orders.cust_id = customers.cust_id
JOIN orderitems ON orderitems.order_num = orders.order_num
JOIN products ON products.prod_id = orderitems.prod_id
JOIN vendors ON vendors.vend_id = products.vend_id
GROUP BY vendors.vend_country, vendors.vend_id, customers.cust_id 
HAVING














