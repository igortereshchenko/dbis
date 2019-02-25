-- LABORATORY WORK 3
-- BY Mykhailenko_Yeva
/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 10. Ключі постачальників vvv1….vvvn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/

DECLARE 
vendors_id vendors.vend_id%TYPE;
vendors_count INTEGER;

BEGIN
SELECT COUNT (vend_id)
INTO vendors_count
FROM vendors;

FOR i IN 1..(10-vendors_count) LOOP
INSERT INTO vendors (vend_id, vend_name, vend_adress, vend_city, vend_state, vend_zip, vend_country)
(vendors_id, 'Bears R US', '123 Main Street', 'Bear Town', 'MI', '4444', 'USA')
vendors_id := 'vvv' || i;
END LOOP;
END
/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/

DECLARE vendor_id vendors.vend_id%TYPE; vendor_status varchar(10);
BEGIN
vendor_id:= 'BRS01'
SELECT vend_name
FROM vendors
WHERE vendors.vend_id=vendor_id;
IF (SELECT MIN(orderitems.item_price), orderitems.prod_id, vendors.vend_id
FROM orderitems join products on orderitems.prod_id=products.prod_id join vendors on products.vend_id=vendors.vend_id
GROUP BY 

END

/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/

CREATE VIEW join_table AS
SELECT customers.cust_id, customers.cust_name, vendors.vend_id, orderitems.quantity, vendors.vend_country
FROM customers 
JOIN orders ON customers.cust_id=orders.cust_id
JOIN orderitems ON orders.order_num=orderitems.order_num
JOIN products ON products.prod_id=orderitems.prod_id
JOIN vendors ON vendors.vend_id= products.vend_id;

SELECT SUM(quantity)
FROM join_table
WHERE vend_country = 'Germany';

SELECT cust_name,SUM(quantity)
FROM join_table
GROUP BY cust_name;
