-- LABORATORY WORK 2
-- BY Sedinin_Yehor
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту за умови, що покупець купив більше 5 одиниць цього продукту.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT customers.cust_id, products.prod_id
FROM customers JOIN orders ON 
    customers.cust_id = orders.cust_id JOIN orderitems ON
        orders.order_num = orderitems.order_num JOIN products ON
            orderitems.prod_id = products.prod_id
WHERE orderitems.quantity > 5
/* --------------------------------------------------------------------------- 
2.  Вивести ключ постачальника на номери замовлень, що містять більше одного з його товарів.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT UNIQUE vendors.vend_id, orderitems.order_num
FROM orderitems JOIN products ON
    orderitems.prod_id = products.prod_id JOIN vendors ON
        products.vend_id = vendors.vend_id
