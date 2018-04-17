-- LABORATORY WORK 3
-- BY Mozghovyi_Mykyta
/*1. Написати PL/SQL код, що по вказаному ключу замовлення додає в його будь-Який продукт 10 разів, змінюючи order_item у циклі.
Операція виконується, якщо у даному замовлення вже є хочаб один товар. 10 балів*/
DECLARE
  count_loop INT:=10;
  order_key  INT:=0;
BEGIN
  SELECT prod_id
  into prod_key
  FROM orderitems
  WHERE order_item>=1
  AND order_num=order_key;
  FOR i IN 1..count_loop
  LOOP
    INSERT INTO orderitems (orderitems.order_num,orderitems.order_item,orderitems.prod_id,orderitems.quantity,orderitems.item_price)
    values(order_key,i,prod_key) END loop;
END;
/*2. Написати PL/SQL код, що по вказаному ключу замовленнЯ виводить у консоль його дату та изначає  його статус.
якщо воно має 0 товарів у середині - статус  = "poor"
якщо воно має до 2 товарів включно - статус  = "common"
якщо воно має бґльше 2 товарів - статус  = "rich" 4 бали*/

/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести ключ постачальника та номер замовленнЯ, куди продає постачальник свої продукти.
3.2. Вивести ім'Я постачальника та загальну кількість проданих ним товарів 6 балів.*/
CREATE VIEW vendor_orderitems AS
SELECT vendors.*,
  orderItems.*
FROM vendors
JOIN products
ON products.vend_id=vendors.vend_id
JOIN orderitems
ON products.prod_id=orderitems.prod_id;

select vend_id,order_num
from vendor_orderitems
group by vend_id,order_num
ORDER BY 1;

select vend_name,sum(quantity)
from vendor_orderitems 
group by vend_name
ORDER BY 1;
