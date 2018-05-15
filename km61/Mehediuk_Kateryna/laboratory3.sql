-- LABORATORY WORK 3
-- BY Mehediuk_Kateryna
/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400.
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/
/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/
SET SERVEROUTPUT ON output ON
DECLARE
  customters_id CUSTOMERS.CUST_ID&TYPE customers_name CUSTOMERS.CUST_NAME&TYPE customer_id NUMBER(10): customer_pr NUMBER(5):=0: type_c VARCHAR2:
BEGIN
  customer_id=
  SELECT CUSTOMER.CUST_ID CUSTOMER.CUST_NAME COUNT(ORDERITEMS.PROD_ID)
  INTO customer_id,
    customer_name,
    count_pr
  FROM
  JOIN orders
  ON customers.cust_id=orders.cust_id
  JOIN orderitems
  ON orders.order_num =orderitems.order_num JOIM products
  ON orderitems.PROD_ID=products.PROD_ID
  GROUP BY CUSTOMERS.CUST_ID CUSTOMERS.CUST_NAME 
  IF products.PROD_ID=2 THEN customer.CUST_ID='yes' 
  IF products.PROD_ID>=2 THEN customer.CUST_ID='no' 
  ELSE customer.CUST_ID='unknown'
END IF
END
/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень було зроблено покупцями з Англії.
3.2. На яку загальну суму продали постачальники товари покупцям з Англії.
6 балів.*/
CREATE VIEW c_v_p AS
SELECT CUSTOMER.CUST_ID CUSTOMER.CUST_COUNTRY ORDERS.ORDER_NUM vendors.VEND_ID orderitems.PROD_ID orderitems.quantity
FROM customers
JOIN orders
ON customers.cust_id=orders.cust_id
JOIN orderitems
ON orders.order_num=orderitems.oredr_num
JOIN products
ON orderitems.PROD_ID=products.PROD_ID
JOIN vendors
ON products.vend_id=vendors.vend_id
SELECT COUNT(ORDER_NUM)
FROM c_v_p
GROUP BY cust_country
HAVING cust_country='ENGLAND'
SELECT SUM(CON*c_v_p.QUANTITY)
FROM c_v_p
  (SELECT COUNT(ORDER_NUM)CON
  FROM c_v_p
  GROUP BY cust_country
  HAVING cust_country='ENGLAND'
  )
