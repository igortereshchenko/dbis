/*1. Написати PL/SQL код, що по вказаному ключу постачальника додає йому продукти з ключами 1,....n, 
щоб сумарна кількість його продуктів була 10. Назви продуктів = кллюч продукту. Ціна кожного продукту = 1.
Операція виконується, якщо у постачальника є хоча б один продукт. 10 балів*/
DECLARE
  vendr_id    VARCHAR2(10) := '';
  prodc_id    VARCHAR2(10) := '';
  prodc_name  VARCHAR2(50) := '';
  count_prodc INTEGER      :=0;
  price_prodc INTEGER      :=0;
BEGIN
  SELECT VEND_ID,
    PROD_ID,
    PROD_NAME,
    COUNT(DISTINCT PROD_ID),
    PROD_PRICE
  INTO vendr_id,
    prodc_id,
    prodc_name,
    count_prodc,
    price_prodc
  FROM PRODUCTS join VENDORS on PRODUCTS.VEND_ID = VENDORS.VEND_ID

/*2. Написати PL/SQL код, що по вказаному ключу постачальникавиводить у консоль його ім'я та изначає  його статус.
Якщо він має 0 продуктів - статус  = "poor"
Якщо він має до 2 продуктів включно - статус  = "common"
Якщо він має більше 2 продуктів - статус  = "rich" 4 бали*/
DECLARE
  vendr_id    VARCHAR2(10) := '';
  vendr_name  VARCHAR2(50) := '';
  items_count INT          :=0;
BEGIN
  SELECT VEND_ID,
    VEND_NAME,
    COUNT(DISTINCT PROD_ID)
  INTO vendr_id,
    vendr_name,
    items_count
  FROM VENDORS
  LEFT JOIN PRODUCTS
  ON VENDORS.PROD_ID = PRODUCTS.PROD_ID;
  GROUP BY VEND_ID,
  VEND_NAME;
  IF items_count :=0 THEN
    DBMS_OUTPUT.PRINT_LINE("poor");
  ELSIF items_count>0 AND items_count <=2 THEN
    DBMS_OUTPUT.PRINT_LINE("common");
  ELSIF items_count>2 THEN
    DBMS_OUTPUT.PRINT_LINE("rich");
  ELSE
    DBMS_OUTPUT.PRINT_LINE("ERROR");
  END IF;
  DBMS_OUTPUT.PRINT_LINE(VEND_NAME);
END;
/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ключ покупця та та ім'я постачальника, що не співпрацювали.
3.2. Вивести ім'я постачальника та загальну кількість проданих ним продуктів 6 балів.*/
 
CREATE VIEW cust_vend AS
SELECT CUST_ID,
  CUST_NAME,
  VEND_ID,
  VEND_NAME,
  PROD_ID,
  PROD_NAME
FROM CUSTOMERS
JOIN ORDERS
ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
JOIN ORDERITEMS
ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
JOIN PRODUCTS
ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
JOIN VENDORS
ON PRODUCTS.VEND_ID = VENDORS.VEND_ID;
SELECT CUST_ID, VEND_NAME FROM cust_vend WHERE ;
SELECT VEND_NAME,
  COUNT(DISTINCT PROD_ID)
FROM cust_vend
WHERE VEND_ID = PROD_ID;
