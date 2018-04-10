-- LABORATORY WORK 2
-- BY Hrydko_Oleksandr
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, кількість його продуктів та загальну вартість проданих ним продуктів.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT
    vendors.vend_id,
    COUNT(DISTINCT orderitems.prod_id) as prod_count ,
    SUM(orderitems.quantity*orderitems.item_price) as price
FROM
    orderitems
    JOIN products ON orderitems.prod_id = products.prod_id
    JOIN vendors ON products.vend_id = vendors.vend_id
GROUP BY
    vendors.vend_id
ORDER BY
    vendors.vend_id;







/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого містить найдешевший продукт.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT
     DISTINCT customers.cust_id
FROM
    customers
    JOIN orders ON customers.cust_id = orders.cust_id
    JOIN orderitems ON orderitems.order_num = orders.order_num
WHERE
    orders.order_num IN (
        SELECT
            orderitems.order_num
        FROM
            orderitems
        GROUP BY
            orderitems.order_num
        HAVING
            MIN(orderitems.item_price) IN (
                SELECT
                    MIN(min_)
                FROM
                    (
                        SELECT
                            orderitems.order_num,
                            MIN(orderitems.item_price) AS min_
                        FROM
                            orderitems
                        GROUP BY
                            orderitems.order_num
                    )
            )
    );
