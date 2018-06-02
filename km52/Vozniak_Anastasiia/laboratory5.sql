-- LABORATORY WORK 5
-- BY Vozniak_Anastasiia


CREATE OR REPLACE FUNCTION count_order (
    customer_id IN VARCHAR2
) RETURN NUMBER
    IS
BEGIN
    SELECT
        customers.cust_id,
        COUNT(orders.order_num)
    FROM
        customers
        JOIN orders ON customers.cust_id = orders.cust_id
        JOIN orderitems ON orders.order_num = orderitems.order_num
    WHERE
        customers.cust_id = customer_id
        AND   orders.order_num IN (
            SELECT
                order_num
            FROM
                orderitems
        )
    GROUP BY
        customers.cust_id;

    count_ord := count(orders.order_num);
    RETURN count_ord;
END count_order;

CREATE OR REPLACE PROCEDURE return_id (
    customer_name   IN VARCHAR2,
    customer_id     OUT VARCHAR2
)
    IS
BEGIN
    SELECT
        cust_name
    FROM
        customersk
    WHERE
        cust_name = customer_name;

    customer_name := cust_name;
    dbms_output.put_line('Ключ покупця:',customer_name);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Неможливо виконати операцію');
END return_id;

CREATE or replace procedure update_date(
    ord_num   IN orders.order_num%TYPE
) is
declare
    ord_date   orders.order_date%TYPE;
BEGIN
    SELECT
        order_num
    FROM
        orders
    WHERE
        order_num = ord_num;

    UPDATE orders
        SET
            order_date = ord_date
    WHERE
        order_num = ord_date;

END update_date;
