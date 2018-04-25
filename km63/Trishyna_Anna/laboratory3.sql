-- LABORATORY WORK 3
-- BY Trishyna_Anna
/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/
DECLARE
vendor_id vendors.vend_id%TYPE;
vendor_name vendors.vend_name%TYPE;
products_name products.prod_id%TYPE;
products_price products.prod_name%Type;
items_count INTEGER:=100;
BEGIN
vendor_id:='BRS01';
product_id:='key';
product_name:='PROD';
END;
/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/
DECLARE
vendr_id VARCHAR(10):= ";
vendr_name VARCHAR(20):=";
items_count INT :=0;
BEGIN
SELECT VEND_ID,
VEND_NAME,
COUNT(DISTINCT PROD_ID)
INTO vendr_id, 
vendr_name,
items_count
FROM VENDORSLEFT JOIN PRODUCTS
ON VENDORS.PROD_ID=PRODUCTS.PROD_ID
GROUP BY VEND_ID,VEND_NAME;
IF items_count:=2;
THEN 
DBMS_OUTPUT.PRINT_LINE("YES");
ELSIF items_count>2;
THEN 
DBMS_OUTPUT.PRINT_LINE("NO");
ELSE
DBMS_OUTPUT.PRINT_LINE("UNKNOWN");
END IF 
DBMS_OUTPUT.PRINT_LINE("VEND_NAME");
END;
/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень було зроблено покупцями з Англії.
3.2. На яку загальну суму продали постачальники товари покупцям з Англії.
6 балів.*/

CREATE VIEW VENDORSORDERS AS
SELECT VENDORS.VEND_ID,
VENDORS.VEND_NAME,
ORDERITEMS.ORDER_NUM,
ORDERITEMS.ORDER_ITEM

FROM VENDORS
JOIN PRODUCTS 
ON VENDORS.VEND_ID=PRODUCTS.VEND_ID
JOIN ORDERITEMS ON PRODUCTS.PROD_ID=ORDERITEMS.PROD_ID;
SELECT DISTINCT VEND_ID,ORDER_NUM
FROM VENDORSORDERS;
SELECT VEND_NAME,SUM(ORDER_ITEM)
FROM VENDORSORDER
GROUP BY VEND_ID, VEND_NAME;

 WHERE vend_country='England';
