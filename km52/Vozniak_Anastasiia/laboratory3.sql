-- LABORATORY WORK 3
-- BY Vozniak_Anastasiia
/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 10. Ключі постачальників vvv1….vvvn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/DECLARE
    vend_count       INTEGER;
    vendor_id        vendors.vend_id%TYPE;
    vendor_name      vendors.vend_name%TYPE;
    vendor_adress    vendors.vend_adress%TYPE;
    vendor_city      vendors.vend_city%TYPE;
    vendor_state     vendors.vend_state%TYPE;
    vendor_zip       vendors.vend_zip%TYPE;
    vendor_country   vendors.vend_country%TYPE;
begin
    SELECT
        vend_id
    FROM
        vendors;
    Vend_count :=count(vend_id);
    vendor_name := 'Bears R Us';
    vendor_adress := '123 Main Street';
    vendor_city := 'Bear Town';
    vendor_state := 'MI';
    vendor_zip := '44444';
    vendor_country := 'USA';
FOR i IN vend_count..10 loop
    INSERT INTO vendors (
        vend_id,
        vend_name,
        vend_adress,
        vend_city,
        vend_state,
        vend_zip,
        vend_country
    ) VALUES (
        'Vvv'
        || i,
        vendor_name,
        vendor_adress,
        vendor_city,
        vendor_state,
        vendor_zip,
        vendor_country
    )
    end
    loop;

end;

/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/

/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/

CREATE VIEW cust_prod AS
    SELECT
        customers.cust_name,
        orderitems.quantity,
        vendors.vend_country,
        vendors.vend_id,
        vendors.vend_name
    FROM
        customers
        JOIN orders ON customers.cust_id = orders.cust_id
        JOIN orderitems ON orders.order_num = orderitems.order_num
        JOIN products ON orderitems.prod_id = products.prod_id
        JOIN vendors ON products.vend_id = vendors.vend_id;

SELECT
    SUM(c_quantity) AS sum_quantity
FROM
    (
        SELECT
            COUNT(quantity) AS c_quantity,
            vend_id
        FROM
            cust_prod
        WHERE
            vend_country = 'Germany'
        GROUP BY
            vend_id
    );

SELECT
    cust_name,
    COUNT(quantity)
FROM
    cust_prod
GROUP BY
    cust_name;
