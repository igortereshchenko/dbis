-- LABORATORY WORK 2
-- BY Kysla_Olha
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту, за умови, що покупець ніколи не купляв даний продукт.

---------------------------------------------------------------------------*/
--Код відповідь:
select 
    customers.cust_id,
    products.prod_id
from CUSTOMERS, Products
minus
select 
    customers.cust_id,
    products.prod_id

from customers
            JOIN orders ON customers.cust_id = orders.cust_id
            JOIN orderitems ON orderitems.order_num = orders.order_num
            JOIN products ON products.prod_id = orderitems.prod_id
group by customers.cust_id,
          products.prod_id;




/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, що працював з покупцем, що має найдорожче замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT
    vendors.vend_id,
    orders.order_num
FROM
    customers
    JOIN orders ON customers.cust_id = orders.cust_id
    JOIN orderitems ON orderitems.order_num = orders.order_num
    JOIN products ON products.prod_id = orderitems.prod_id
    JOIN vendors ON vendors.vend_id = products.vend_id
group by vendors.vend_id ,orders.order_num
having SUM(orderitems.quantity * orderitems.item_price) in (

SELECT
    max (info.all_price)
FROM
    (
        SELECT
            SUM(orderitems.quantity * orderitems.item_price) AS all_price,
            orderitems.order_num
        FROM
            orderitems
        GROUP BY
            orderitems.order_num
    ) info);

