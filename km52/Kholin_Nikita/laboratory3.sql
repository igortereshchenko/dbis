-- LABORATORY WORK 3
-- BY Kholin_Nikita
/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх
замовників була 10. Ключі замовників test1….testn.
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/
SET SERVEROUTPUT ON
DECLARE
  vendors_count INTEGER;
BEGIN
  LOOP
    SELECT COUNT(*) INTO vendors_count FROM vendors;
    DBMS_OUTPUT.put_line('Vendors count: ' || vendors_count);
    EXIT
  WHEN vendors_count = 10;
    INSERT
    INTO vendors
      (
        vend_id,
        vend_name
      )
      VALUES
      (
        'test'
        || i,
        '1000000001'
      );
  END LOOP;
END;
/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль
його ім'я та визначає  його статус.
Якщо він має більше 3 замовлень - статус  = "yes"
Якщо він має не менше 3 замовлень - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/
DECLARE
  vend_id vendors.vend_id%TYPE := 'BRS01';
  vend_name vendors.vend_name%TYPE;
  orders_count INTEGER;
  status       VARCHAR2(8);
BEGIN
  SELECT vendors.vend_name,
    COUNT(DISTINCT orders.order_num)
  INTO vend_name,
    orders_count
  FROM vendors
  INNER JOIN products
  ON vendors.vend_id = products.vend_id
  INNER JOIN orderitems
  ON products.prod_id = orderitems.prod_id
  INNER JOIN orders
  ON orders.order_num   = orderitems.order_num
  WHERE vendors.vend_id = 'BRS01'
  GROUP BY vendors.vend_name;
  IF orders_count    > 3 THEN
    status          := 'yes';
  ELSIF orders_count > 0 THEN
    status          := 'no';
  ELSE
    status := 'unknown';
  END IF;
  DBMS_OUTPUT.put_line('Vendor ' || TRIM(vend_name) || ' status is ' || status);
END;
SELECT vendors.vend_name
FROM vendors
INNER JOIN products
ON vendors.vend_id = products.vend_id
INNER JOIN orderitems
ON products.prod_id = orderitems.prod_id
INNER JOIN orders
ON orders.order_num   = orderitems.order_num
WHERE vendors.vend_id = 'BRS01';
/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень має кожен з покупців, що проживає в Австрії.
3.2. Як звуть постачальника з Германії, що продає свої товари більше ніж у 3 різних замовленнях.
6 балів.*/
CREATE VIEW customers_orders_vendors AS
SELECT customers.cust_id,
  customers.cust_country,
  orders.order_num,
  vendors.vend_id,
  vendors.vend_name,
  vendors.vend_country
FROM customers
INNER JOIN orders
ON customers.cust_id = orders.cust_id
INNER JOIN orderitems
ON orders.order_num = orderitems.order_num
INNER JOIN products
ON products.prod_id = orderitems.prod_id
INNER JOIN vendors
ON vendors.vend_id = products.vend_id;
SELECT cust_id,
  COUNT(*)
FROM customers_orders_vendors
WHERE cust_country = 'Australia'
GROUP BY cust_id;
SELECT vend_id,
  vend_name,
  COUNT(*)
FROM customers_orders_vendors
GROUP BY vend_id,
  vend_name
HAVING COUNT(DISTINCT order_num) > 3;
