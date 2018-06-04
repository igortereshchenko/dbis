-- LABORATORY WORK 3
-- BY Kondratiuk_Andrii
 
 /*1. Написати PL/SQL код, що по вказаному ключу постачальника додає йому продукти з ключами 111,....111+n, 
щоб сумарна кількість його продуктів була 10. Назви продуктів - будь-яка ностанта. Ціна кожного продукту наступного продукту на одиницю більша ніж попередній, починати з 1.
 10 балів*/
SET SERVEROUTPUT ON;
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
  END LOOP;
END;


/*2. Написати PL/SQL код, що по вказаному ключу постачальникавиводить у консоль його ім'я та изначає  його статус.
Якщо він має до 2 продуктів включно - статус  = "common"
Якщо він має більше 2 продуктів - статус  = "rich"
інакше він має статус "o status" 4 бали*/


CREATE VIEW info AS
    SELECT vendors.vend_id, COUNT(products.prod_id) AS count_prod  FROM products
    FULL OUTER JOIN vendors ON products.vend_id = vendors.vend_id
    GROUP BY vendors.vend_id;

DECLARE
    vendor_id vendors.vend_id%type;
    count_of_orders NUMBER(5);
BEGIN
    SELECT info.vend_id, info.count_prod FROM info
    INTO vendor_id, count_of_orders
    DBMS_OUTPUT.PUT_LINE(vendor_id);
END;



/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ім'я покупця та ім'я постачальника, що не співпрацювали.
3.2. Вивести ключ постачальника та загальну кількість проданих ним продуктів 6 балів.*/

CREATE VIEW information1 AS
    SELECT SUM(orderitems.quantity) AS amount,customers.cust_name, vendors.vend_name, vendors.vend_id FROM customers
    JOIN orders ON customers.cust_id = orders.cust_id
    JOIN orderitems ON orders.order_num = orderitems.order_num
    JOIN products ON orderitems.prod_id = products.prod_id
    FULL OUTER JOIN vendors ON products.vend_id = vendors.vend_id
    GROUP BY customers.cust_name, vendors.vend_name, vendors.vend_id;

SELECT information1.vend_id, information.amount FROM information
