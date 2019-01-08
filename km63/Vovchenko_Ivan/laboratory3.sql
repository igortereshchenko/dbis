-- LABORATORY WORK 3
-- BY Vovchenko_Ivan
+/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400.
+Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
+10 балів*/
+/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
+Якщо він купив два продукти - статус  = "yes"
+Якщо він купив більше двох продуктів- статус  = "no"
+Якщо він немає замовлення - статус  = "unknown*/
+SET SERVEROUTPUT ON output ON
+DECLARE
+  CUSTOMERS_ID CUSTOMERS.CUST_ID & TYPE CUSTOMERS_NAME CUSTOMERS.CUST_NAME & TYPE CUSTOMER_ID NUMBER(10): CUSTOMER_PR NUMBER(5):=0: type_c VARCHAR2:
+BEGIN
+  CUSTOMER_ID =
+  SELECT CUSTOMER.CUST_ID CUSTOMER.CUST_NAME COUNT(ORDERITEMS.PROD_ID)
+  INTO CUSTOMER_ID,
+    CUSTOMER_NAME,
+    COUNT_PR
+  FROM
+  JOIN ORDERS
+  ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
+  JOIN ORDERITEMS
+  ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM 
+   JOIN PRODUCTS
+  ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
+  GROUP BY CUSTOMERS.CUST_ID CUSTOMERS.CUST_NAME 
+  IF PRODUCTS.PROD_ID = 2 THEN CUSTOMER.CUST_ID = 'yes' 
+  IF PRODUCTS.PROD_ID >= 2 THEN CUSTOMER.CUST_ID='no' 
+  ELSE CUSTOMER.CUST_ID = 'unknown'
+END IF
+END
+/*3. Створити представлення та використати його у двох запитах:
+3.1. Скільки замовлень було зроблено покупцями з Германії.
+3.2. На яку загальну суму продали постачальники товари покупцям з Германії.
+6 балів.*/
+CREATE VIEW CUST_VEND_PROD AS
+SELECT CUSTOMER.CUST_ID CUSTOMER.CUST_COUNTRY ORDERS.ORDER_NUM VENDORS.VEND_ID ORDERITEMS.PROD_ID ORDERITEMS.QUANTITY
+FROM CUSTOMERS
+JOIN ORDERS
+ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
+JOIN ORDERITEMS
+ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
+JOIN PRODUCTS
+ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
+JOIN VENDORS
+ON PRODUCTS.VEND_ID = VENDORS.VEND_ID
+SELECT COUNT(ORDER_NUM)
+FROM CUST_VEND_PROD
+GROUP BY CUST_COUNTRY
+HAVING CUST_COUNTRY='GERMANY'
+SELECT SUM(CON * CUST_VEND_PROD.QUANTITY)
+FROM CUST_VEND_PROD
+  (SELECT COUNT(ORDER_NUM)CON
+  FROM CUST_VEND_PROD
+  GROUP BY CUST_COUNTRY
+  HAVING CUST_COUNTRY='GERMANY'
+  )
