-- LABORATORY WORK 3
-- BY Lukianchenko_Rehina
/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників була 10. Ключі замовників test1….testn. 
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/


DECLARE
    customer_name   customers.cust_name%TYPE;
    customer_id     customers.cust_id%TYPE;
    cust_count      INT := 0;
BEGIN
    customer_id := '1000000001';
    SELECT
        COUNT(DISTINCT customers.cust_id)
    INTO
        cust_count
    FROM
        customers;

    SELECT
        cust_name
    INTO
        customer_name
    FROM
        customers
    WHERE
        cust_id = customer_id;

    FOR i IN 1.. ( 10 - cust_count ) LOOP
        INSERT INTO customers (
            cust_id,
            cust_name
        ) VALUES (
            'test'
            || i,
            customer_name
        );

    END LOOP;

END;



/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він має 3 або більше  замовлень - статус  = "yes"
Якщо він має менше 3 замовлень - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/


DECLARE
    customer_name     customers.cust_name%TYPE;
    customer_id       customers.cust_id%TYPE;
    orders_count      INTEGER;
    customer_status   VARCHAR(30) := ' ';
BEGIN
    customer_id := '1000000001';
    SELECT
        customers.cust_name,
        COUNT(orders.order_num)
    INTO
        customer_name,orders_count
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
    ELSIF ( orders_count > 3 OR orders_count = 3 ) THEN
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
CREATE OR REPLACE VIEW cust_vend AS
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
        LEFT JOIN orders ON customers.cust_id = orders.cust_id
        LEFT JOIN orderitems ON orders.order_num = orderitems.order_num
        LEFT JOIN products ON orderitems.prod_id = products.prod_id
        LEFT JOIN vendors ON products.vend_id = vendors.vend_id;

SELECT
    cust_name,
    COUNT(DISTINCT order_num)
FROM
    cust_vend
WHERE
    cust_country = 'Austria'
GROUP BY
    cust_name;
    
    
    
SELECT
    vend_name
FROM
    (
        SELECT
            vend_id,
            vend_name,
            COUNT(DISTINCT order_num) AS count_order_num
        FROM
            cust_vend
        WHERE
            vend_country = 'Germany'
        GROUP BY
            vend_id,
            vend_name
    )
WHERE
    count_order_num > 3;
