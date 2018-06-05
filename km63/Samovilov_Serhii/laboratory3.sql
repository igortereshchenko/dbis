-- LABORATORY WORK 3
+/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
+Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
+10 балів*/
+
+/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
+Якщо він купив два продукти - статус  = "yes"
+Якщо він купив більше двох продуктів- статус  = "no"
+Якщо він немає замовлення - статус  = "unknown*/
+
+
+DECLARE v_cust_id CUSTOMERS.CUST_ID%type ;
+v_cust_name CUSTOMERS.CUST_NAME%type ; 
+v_cust_status integer; 
+prods_number integer; 
+begin 
+v_cust_id  := '1000000001';
+
+select 
+CUSTOMERS.CUST_ID,
+CUSTOMERS.CUST_NAME,
+count(distinct(ORDERS.ORDER_NUM))
+into v_cust_name, v_cust_status, prods_number
+from customers join orders on CUSTOMERS.CUST_ID = ORDERS.CUST_ID
+join orderitems on ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
+where CUSTOMERS.CUST_ID = v_cust_id
+group by CUSTOMERS.CUST_ID, CUSTOMERS.CUST_NAME ; 
+
+
+
+
+
+
+/*3. Створити представлення та використати його у двох запитах:
+3.1. Скільки продуктів було замовлено покупцями з Германії.
+3.2. Вивести назву продукту та у скількох замовленнях його купляли.
+6 балів.*/
+
+
+create view  product_customer as 
+select 
+products.prod_name,
+customers.cust_country,
+orders.order_num
+from products join orderitems on products.PROD_ID = orderitems.PROD_ID 
+join orders on orderitems.ORDER_NUM = orders.ORDER_NUM 
+join customers on orders.CUST_ID = customers.CUST_ID; 
+
+
+
+select count(prod_name)
+from product_customer
+where CUST_COUNTRY = 'Germany'; 
+
+select 
+prod_name, 
+count(distinct(order_num))
+from product_customer 
+group by prod_name;
+
+
+
-- BY Samovilov_Serhii
