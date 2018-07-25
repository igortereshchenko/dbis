-- LABORATORY WORK 2
-- BY Korin_Yosyp
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту, за умови, що покупець ніколи не купляв даний продукт.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT
    customers.cust_id,
    products.prod_id
FROM
    customers,
    products
MINUS
SELECT
    customers.cust_id,
    products.prod_id
FROM
    customers
    JOIN orders ON customers.cust_id = orders.cust_id
    JOIN orderitems ON orders.order_num = orderitems.order_num
    JOIN orderitems ON orders.order_num = orderitems.order_num
    JOIN products ON orderitems.prod_id = products.prod_id;

/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, що працював з покупцем, що має найдорожче замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT DISTINCT
    vendors.vend_id
FROM
    customers
    JOIN orders ON customers.cust_id = orders.cust_id
    JOIN orderitems ON orders.order_num = orderitems.order_num
    JOIN orderitems ON orders.order_num = orderitems.order_num
    JOIN products ON orderitems.prod_id = products.prod_id
    JOIN vendors ON products.vend_id = vendors.vend_id
WHERE
    orderitems.prod_id IN (
        SELECT
            orderitems.prod_id
        FROM
            orderitems
        GROUP BY
            orderitems.prod_id
        HAVING
            SUM(orderitems.quantity) IN (
                SELECT
                    MAX(prod_q)
                FROM
                    (
                        SELECT
                            orderitems.prod_id,
                            SUM(orderitems.quantity) AS prod_q
                        FROM
                            orderitems
                        GROUP BY
                            orderitems.prod_id
                    )
            )
    );
