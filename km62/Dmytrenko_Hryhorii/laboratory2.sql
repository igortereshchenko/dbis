-- LABORATORY WORK 2
-- BY Dmytrenko_Hryhorii
/*---------------------------------------------------------------------------
1. Вивести ім'я покупця, номер замовлення та назву продукту, що найменше було куплено у кожному замовленні покупця.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT customers.cust_name, orders.order_num, products.prod_name
FROM customers join orders on
    customers.cust_id = orders.cust_id
    join orderitems on
    orders.order_num = orderitems.order_num
    join products on
    orderitems.prod_id = products.prod_id
GROUP BY prod_id;


/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника, що продавав свої продукти лише трьом покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT customers.cust_id, vendors.vend_id
FROM vendors join  products on
    vendors.vend_id = products.vend_id
    join orderitems on
    products.prod_id = orderitems.prod_id
    join orders on
    orderitems.order_num = orders.order_num
    join customers on
    customers.cust_id = orders.cust_id
WHERE COUNT ;
