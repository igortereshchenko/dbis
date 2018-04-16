-- LABORATORY WORK 3
-- BY Pochta_Ivan
/*1. Написати PL/SQL код, що по вказаному ключу замовника додає йому замовлення з номерами 1,....n,
щоб сумарна кількість його замовлень була 10. Дати нових замовлень дорівнюють даті останього замовлення.
Операція виконується, якщо у замовника є хоча б одне замовлення. 10 балів*/
set SERVEROUTPUT ON;
DECLARE
  vendor_id Vendors.vend_id%type;
  count_of_orders NUMBER(5);
  last_date ORDERS.ORDER_DATE%type;
BEGIN
  vendor_id := 'BRS01';
  SELECT
    Vendors.vend_id,
    MAX( Orders.ORDER_DATE ),
    COUNT(DISTINCT Orders.ORDER_NUM)
  INTO vendor_id, last_date, count_of_orders
  FROM Orders
  JOIN ORDERITEMS
  ON ORDERITEMS.order_num  = ORDERS.order_num
  JOIN PRODUCTS
  ON PRODUCTS.prod_id = ORDERITEMS.PROD_ID
  JOIN VENDORS
  ON PRODUCTS.vend_id  = VEndors.vend_id
  GROUP BY Vendors.vend_id
  HAVING Vendors.vend_id = vendor_id;
  for i in 0..10-count_of_orders LOOP
    /*Just insert all. Ijust have enough of time*/
  END LOOP;
END;

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та изначає  його статус.
Якщо він має 0 замовлень - статус  = "poor"
Якщо він має до 2 замовлень включно - статус  = "common"
Якщо він має більше 2 замовлень - статус  = "rich" 4 бали*/
/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ключ покупця та постачальника, що співпрацювали.
3.2. Вивести ім'я покупця та загальну кількість куплених ним продуктів 6 балів.*/
