-- LABORATORY WORK 3
-- BY Sedinin_Yehor
/*1. Написати PL/SQL код, що по вказаному ключу замовника додає йому замовлення з номерами 1,....n, 
щоб сумарна кількість його замовлень була 10. Дати нових замовлень дорівнюють даті останього замовлення. 
Операція виконується, якщо у замовника є хоча б одне замовлення. 10 балів*/


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та изначає  його статус.
Якщо він має 0 замовлень - статус  = "poor"
Якщо він має до 2 замовлень включно - статус  = "common"
Якщо він має більше 2 замовлень - статус  = "rich" 4 бали*/
SELECT cusomers.cust_id, count(orders.order_num)
FROM customers JOIN orders
ON customers.cust_id = orders.cust_id

GROUP BY cusomers.cust_id
/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ключ покупця та постачальника, що співпрацювали.
3.2. Вивести ім'я покупця та загальну кількість куплених ним продуктів 6 балів.*/
CREATE VIEW customers_vendors AS

SELECT customers.cust_id, vendors.vend_id
FROM customers JOIN orders JOIN orderitems 
  JOIN products JOIN vendors
ON (customers.cust_id = orders.cust_id and orders.order_num = orderitems.prod_id  
and orderitems.prod_id = products.prod_id and products.vend_id = vendors.vend_id)



SELECT customers.cust_name, count(orderitems.order_item)
FROM customers JOIN orders JOIN orderitems
ON customers.cust_id = orders.order_num and orders.order_num = orderitems.order_num

GROUP BY customers.cust_name, count(orderitems.order_item)
