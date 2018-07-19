-- LABORATORY WORK 3
-- BY Usenko_Artem
/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників була 10. Ключі замовників test1….testn. 
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/
DECLARE
    cust_need_id   customers.cust_id%TYPE;
    cust_name      customers.cust_name%TYPE;
    count_row      INT := 0;
    j              INT := 0;
BEGIN
    cust_need_id := '1000000001';
    SELECT
        COUNT(*)
    INTO count_row
    FROM
        vendors;

    SELECT
        cust_name
    INTO cust_name
    FROM
        customers
    WHERE
        cust_id = cust_need_id;

    FOR i IN count_row..10 LOOP
        j := j + 1;
        INSERT INTO customers (
            cust_id,
            cust_name
        ) VALUES (
            'test' || j,
            cust_name
        );

    END LOOP;

END;


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він має більше 3 замовлень - статус  = "yes"
Якщо він має не менше 3 замовлень - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

SET SERVEROUTPUT ON

DECLARE
    customer_name     customers.cust_name%TYPE;
    customer_id       customers.cust_id%TYPE;
    orders_count      INTEGER;
    customer_status   VARCHAR(30) := ' ';
BEGIN
    customer_id := '1000000003';
    SELECT
        customers.cust_name,
        COUNT(orders.order_num)
    INTO
        customer_name,
        orders_count
    FROM
        customers left
        JOIN orders ON customers.cust_id = orders.cust_id
    WHERE
        customers.cust_id = customer_id
    GROUP BY
        customers.cust_id,
        customers.cust_name;

    IF
        orders_count = 0
    THEN
        customer_status := 'unknown';
    ELSIF orders_count < 3 THEN
        customer_status := 'no';
    ELSIF ( orders_count > 3 ) THEN
        customer_status := 'yes';
    ELSE
        customer_status := '';
    END IF;

    dbms_output.put_line(trim(customer_name)
                           || ' '
                           || customer_status);
END;
/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень має кожен з покупців, що проживає в Австрії.
3.2. Як звуть постачальника з Германії, що продає свої товари більше ніж у 3 різних замовленнях.
6 балів.*/

CREATE OR REPLACE VIEW customers_vendords AS
    SELECT
        customers.cust_id,
        customers.cust_name,
        customers.cust_country,
        orders.order_num,
        vendors.vend_id,
        vendors.vend_country,
        vendors.vend_name
    FROM
        customers
        LEFT OUTER JOIN orders ON customers.cust_id = orders.cust_id
        LEFT JOIN orderitems ON orders.order_num = orderitems.order_num
        LEFT JOIN products ON orderitems.prod_id = products.prod_id
        FULL JOIN vendors ON products.vend_id = vendors.vend_id;



SELECT
    vend_name
FROM
    (
        SELECT
            vend_id,
            vend_name,
            COUNT(DISTINCT order_num) AS count
        FROM
            customers_vendords
        WHERE
            vend_country = 'Germany'
        GROUP BY
            vend_id,
            vend_name
    )
WHERE
    count > 3;

SELECT
    cust_name,
    COUNT(DISTINCT order_num)
FROM
    customers_vendords
WHERE
    cust_country = 'Austria'
GROUP BY
    cust_name;
