-- LABORATORY WORK 3
-- BY Antiushyn_Yaroslav
/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 7. Ключі постачальників v1….vn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ключ та визначає  його статус.
Якщо він зробив 3 замовлення - статус  = "3"
Якщо він не зробив 3 замовлення - статус  = "no 3"
Якщо він немає замовлення - статус  = "unknown*/

/*3. Створити представлення та використати його у двох запитах:

3.1. Скільки замовлень було зроблено покупцями з Германії.
*/


ADD VIEW customers_vendors as
  SELECT 
    customers.cust_name,
    customers.cust_country,
    orderitems.prod_id,
    products.prod_name
  
  FROM customers 
    JOIN orders ON orders.cust_id = customers.cust_id
    JOIN orderitems ON orders.order_num = orderitems.order_num
    JOIN products ON products.prod_id = orderitems.prod_id
    JOIN vendors ON vendors.vend_id = products.vend_id;
      
      
<--first query
    SELECT COUNT(prod_id)
    FROM customers_vendors
    WHERE cust_country = 'GERMANY';
    
    
 /*  3.2. Вивести назву продукту, що продавався більше ніж у 3 різних замовленнях.
6 балів.

second query*/

  SELECT prod_name
  FROM customers_vendors
  WHERE (SELECT COUNT(prod_id) FROM customers_vendors) !< 3 ;
