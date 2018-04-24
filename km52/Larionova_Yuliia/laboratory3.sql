-- LABORATORY WORK 3
-- BY Larionova_Yuliia
/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 7. Ключі постачальників v1….vn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/
DECLARE
    vendor_id       vendors.vend_id%TYPE;
    vendor_name     vendors.vend_name%TYPE;
    vendor_adress   vendors.vend_adress%TYPE;
    vendor_city     vendors.vend_city%TYPE;
    vendor_state    vendors.vend_state%TYPE;
    vendor_zip      vendors.vend_zip%TYPE;
    vendor_country  vendors.vend_country%TYPE;
    vendors_count   INTEGER := 7;
BEGIN
    vendor_id := 'v';
    vendor_name := 'Bears R Us';
    vendor_adress := '123 Main Street';
    vendor_city := 'Bear Town';
    vendor_state := 'MI';
    vendor_zip : = '44444';
    vendor_country := 'USA';
    
    FOR i IN 1..vendors_count LOOP
        INSERT INTO vendors (
            vend_id,
            vend_name,
            vend_adress,
            vend_city,
            vend_state,
            vend_zip,
            vendor_country
        ) VALUES (
            TRIM(vendor_id) || i,
            TRIM(vendor_name),
            TRIM(vendor_adress),
            TRIM(vendor_city),
            TRIM(vendor_state),
            TRIM(vendor_zip),
            TRIM(vendor_country)
        );
 
    END LOOP;
 
END;


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ключ та визначає  його статус.
Якщо він зробив 3 замовлення - статус  = "3"
Якщо він не зробив 3 замовлення - статус  = "no 3"
Якщо він немає замовлення - статус  = "unknown*/.

DECLARE
    customer_id   customers.cust_id%TYPE;
    order_type    NVARCHAR2(14);
    items_count   INTEGER := 0;
BEGIN

    SELECT
        cust_id,
        COUNT(order_num)
    INTO
        customer_id, items_count
    FROM
        orders
    GROUP BY
        cust_id;
    IF(items_count = 3) THEN
      order_type := '3';
    ELSIF items_count = 0 THEN
      order_type := 'unknown';
    ELSE
      order_type :='NO 3';
    END IF;
 
    dbms_output.put_line(trim(customer_id) || order_type);
END;
  


/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень було зроблено покупцями з Германії.
3.2. Вивести назву продукту, що продавався більше ніж у 3 різних замовленнях.
6 балів.*/
create view train as
 select count(orders.order_num)
 from orders
 join customers on orders.cust_id = customers.cust_id
 where customers.cust_country = 'Germany';
 /*3.2. Вивести назву продукту, що продавався більше ніж у 3 різних замовленнях.*/
 select products.prod_name
 from products
 join orderitems on products.prod_id = orderitems.prod_id
 group by orderitems.order_num
 having count(orderitems.prod_id) > 3;
