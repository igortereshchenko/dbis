-- LABORATORY WORK 3
-- BY Adamovskyi_Anatolii
/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 7. Ключі постачальників v1….vn.
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/
DECLARE
  vendor_id vendors.vend_id%type;
  vendor_name vendors.vend_name%type;
  vendor_addres vendors.vend_address%type;
  vendor_city vendors.vend_city%type;
  vendor_state VENDORS.VEND_STATE%type;
  vendor_ZIP VENDORS.VEND_ZIP%type;
  vendor_country vendors.country%type;
  vendor_count INTEGER;
BEGIN
  vendor_id := 'BRS01';
  SELECT vend_name,
    vend_address,
    vend_city,
    vend_state,
    vend_ZIP,
    vend_country
  INTO vendor_name,
    vendor_address,
    vendor_city,
    vendor_state,
    vendor_ZIP,
    vendor_country
  FROM vendors
  WHERE VEND_ID = vendor_id;
  SELECT COUNT(*) INTO vendor_count FROM vendors;
  FOR i IN 1..(7-vendor_count)
  LOOP
    dbms_output.put_line(i);
  END LOOP;
END;
/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив більше 10 продуктів - статус  = "yes"
Якщо він купив менше 10 продуктів - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/
DECLARE
  custumer_id customes.cust_id%type;
  custumer_name customes.cus_name%type;
  count_prod INTEGER;
BEGIN
  custumer_id := '1000000001';
  select cust_name into custumer_name from custopmers where WHERE customers.cust_id           = custumer_id;
  SELECT COUNT(*)
  INTO count_prod
  FROM customers
  JOIN orders
  ON customers.cust_id = ORDERS.CUST_ID
  JOIN orderitems
  ON orderitems.order_num = ORDERS.ORDER_NUM
  WHERE customers.cust_id           = custumer_id;
  if count_prod > 10 then
    dbms_output.put_line('Yes');
  elsif  0 < count_prod and count_prod < 10 then
    dbms_output.put_line('No');
  Else
  dbms_output.put_line('unknown');
  endif;
END;
/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести ім’я покупця та загальну кількість купленим ним товарів.
3.2. Вивести ім'я постачальника за загальну суму, на яку він продав своїх товарів.
6 балів.*/
CREATE VIEW customers_vendors AS
  (SELECT customers.cust_name,
      orderitems.QUANTITY,
      vendors.VEND_NAME,
      orderitems.item_price
    FROM customers
    JOIN orders
    ON orders.cust_id = customers.cust_id
    JOIN orderitems
    ON orderitems.order_num = orders.order_num
    JOIN products
    ON products.prod_id = orderitems.prod_id
    JOIN vendors
    ON vendors.vend_id = products.vend_id
  );
select 
  cust_name,
  sum(QUANTITY) sum_quantity
from 
  customers_vendors
group by
  cust_name;
  
select 
  vend_name,
  sum(QUANTITY * item_price) salery
from 
  customers_vendors
group by
vend_name;
