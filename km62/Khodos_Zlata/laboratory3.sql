-- LABORATORY WORK 3
-- BY Khodos_Zlata
/*1. Написати PL/SQL код, що по вказаному ключу покупця додає йому замовлення з ключами 111,....111+n,
щоб сумарна кількість його замовлень була 10. Дати замовлень - дата його першого замовлення.
10 балів*/

/*2. Написати PL/SQL код, що по вказаному ключу покупця виводить у консоль його ім'я та изначає  його статус.
Якщо він має до 2 замовлень включно - статус  = "common"
інакше він має статус "o status" 4 бали*/
SET SERVEROUTPUT ON;
DECLARE
  customer_name customers.cust_name%type := '';
  customer_status CHAR(15) := '';
  customer_id customers.cust_id%type := &customer_idfk;
BEGIN

END;
/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ключ покупця та ім'я постачальника, що співпрацювали.
3.2. Вивести ключ постачальника та загальну кількість проданих ним продуктів 6 балів.*/
CREATE VIEW INFO AS
SELECT CUSTOMERS.CUST_ID,
  VENDORS.VEND_NAME,
  VENDORS.VEND_ID,
  PRODUCTS.*
FROM CUSTOMERS
JOIN ORDERS
ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
JOIN ORDERITEMS
ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
JOIN PRODUCTS
ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
JOIN VENDORS
ON PRODUCTS.VEND_ID = VENDORS.VEND_ID;

SELECT CUSTOMER.CUST_NAME, VENDORS.VEND_NAME FROM INFO;

SELECT PRODUCTS.VEND_ID,
  COUNT(PRODUCTS.PROD_ID)
FROM INFO
GROUP BY PRODUCTS.VEND_ID;
