-- LABORATORY WORK 3
-- BY Korin_Yosyp
*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

set SERVEROUTPUT ON
DECLARE 
customers_id CUSTOMERS.CUST_ID%TYPE;
customers_name CUSTOMERS.CUST_NAME%TYPE;
customer_id NUMBER(10);
count_pr NUMBER(5):=0;
type_c VARCHAR2;
BEGIN
customer_id = 1000000003;

select 
CUSTOMERS.CUST_ID,
CUSTOMERS.CUST_NAME,
count(ORDERITEMS.PROD_ID)
into customers_id,customers_name,count_pr
FROM
JOIN orders
ON customers.cust_id = orders.cust_id
JOIN orderitems
ON orders.order_num = orderitems.order_num
JOIN products
ON orderitems.PROD_ID = products.PROD_ID
group by CUSTOMERS.CUST_ID,
CUSTOMERS.CUST_NAME;

IF 

END IF;

END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень було зроблено покупцями з Англії.
3.2. На яку загальну суму продали постачальники товари покупцям з Англії.
6 балів.*/

CREATE VIEW c_v_p AS
SELECT 
customers.cust_id,
customers.cust_country,
orders.ORDER_NUM,
vendors.VEND_ID,
orderitems.prod_id,
orderitems.quantity
FROM customers
JOIN orders
ON customers.cust_id = orders.cust_id
JOIN orderitems
ON orders.order_num = orderitems.order_num
JOIN products
ON orderitems.PROD_ID = products.PROD_ID
JOIN vendors
ON products.vend_id = vendors.VEND_ID;


SELECT count(ORDER_NUM)
FROM c_v_p
GROUP BY cust_country
HAVING cust_country = 'ENGLAND';


SELECT SUM(CON*c_v_p.QUANTITY)
FROM c_v_p,
(SELECT count(ORDER_NUM) CON
FROM c_v_p
GROUP BY cust_country
HAVING cust_country = 'ENGLAND');
