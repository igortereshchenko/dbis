/*1. Написати PL/SQL код, що по вказаному ключу постачальника додає йому продукти з ключами 111,....111+n,
щоб сумарна кількість його продуктів була 10. Назви продуктів - будь-яка ностанта. Ціна кожного продукту наступного продукту на одиницю більша ніж попередній, починати з 1.
10 балів*/

/*2. Написати PL/SQL код, що по вказаному ключу постачальникавиводить у консоль його ім'я та изначає  його статус.
Якщо він має до 2 продуктів включно - статус  = "common"
Якщо він має більше 2 продуктів - статус  = "rich"
інакше він має статус "o status" 4 бали*/

--dbms_output on
--dbms_input on
--тут надо включить пакет ввода и пакет вывода, но я не помню синтаксис :(
DECLARE
  vendor_id vendors.vend_id%type := &v_id_input;
  vendor_name vendors.vend_name%type;
  vendor_products_count integer;
  vendor_status varchar2(10);
BEGIN
  SELECT vendors.vend_id,
    COUNT(products.prod_id)
    into vendor_id, vendor_products_count
  FROM vendors
  LEFT JOIN products
  ON products.vend_id = vendors.vend_id
  GROUP BY vendors.vend_id;
   
  if vendor_products_count <= 2 then vendor_status := ' - common';
  else if vendor_products_count > 2 then vendor_status := ' - rich';
  else vendor_status := 'o status';
  end if;
  
  dbms_output.printline(trim(vendor_id) || trim(vendor_status));
  
END;
/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ім'я покупця та ім'я постачальника, що не співпрацювали.
3.2. Вивести ключ постачальника та загальну кількість проданих ним продуктів 6 балів.*/
--3 сотрудничали
CREATE VIEW any_view AS
SELECT *
FROM customers NATURAL
JOIN orders NATURAL
JOIN orderitems NATURAL
JOIN products NATURAL
JOIN vendors;
--3.1
SELECT cust_id, cust_name, vend_id FROM any_view;
--3.2
SELECT DISTINCT vend_id, SUM(quantity) as total_amount FROM any_view GROUP BY vend_id;
