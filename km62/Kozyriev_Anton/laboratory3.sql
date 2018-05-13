-- LABORATORY WORK 3
-- BY Kozyriev_Anton
/*1. Написати PL/SQL код, що по вказаному ключу покупця додає йому замовлення з ключами 111,....111+n, 
щоб сумарна кількість його замовлень була 10. Дати замовлень - дата його першого замовлення.
 10 балів*/

SET STARTSERVER ON
DECLARE
  v_cust_requierd_id CUSTOMERS.CUST_ID%TYPE := &v_cust_requierd_id;
  v_n NUMBER(3) := &v_n;
  v_first_data ORDERS.ORDER_DATE%TYPE;
  ITER NUMBER(3) := 0;
BEGIN
  
  --v_first_data := MIN(ORDERS.ORDER_DATE);
  
  FOR ITER IN 1..v_n 
    LOOP
      INSERT INTO ORDERS(ORDER_NUM, ORDER_DATE, CUST_ID)
      VALUES (111 + ITER, '01.05.2004', v_cust_requierd_id);
      EXIT WHEN COUNT(ORDERS.ORDER_NUM) = 10;
    END LOOP;
  
END;

/*2. Написати PL/SQL код, що по вказаному ключу покупця виводить у консоль його ім'я та изначає  його статус.
Якщо він має до 2 замовлень включно - статус  = "common"
інакше він має статус "o status" 4 бали*/

SET STARTSERVER ON
DECLARE
  v_cust_requierd_id CUSTOMERS.CUST_ID%TYPE := &v_cust_requierd_id;
  v_cust_name CUSTOMERS.CUST_NAME%TYPE;
  v_order_count NUMBER(3) := 0;
  v_total_count NUMBER(3) := 0;
BEGIN

  SELECT TOTAL_SUM.CUST_NAME, TOTAL_SUM.COUNTER 
  INTO v_cust_name, v_order_count
  FROM (
  SELECT CUSTOMERS.CUST_ID, COUNT(ORDERS.ORDER_NUM) AS COUNTER
  FROM CUSTOMERS JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
  GROUP BY CUSTOMERS.CUST_ID) TOTAL_SUM JOIN CUSTOMERS ON CUSTOMERS.CUST_ID = TOTAL_SUM.CUST_ID
  WHERE CUSTOMERS.CUST_ID = v_cust_requierd_id;
  
  IF (v_order_count <= 2) THEN
    DBMS_OUTPUT.PUT_LINE('' || v_cust_name || ' - common');
  ELSE
    DBMS_OUTPUT.PUT_LINE('' || v_cust_name || ' - o status');
  END IF;
END;

/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ключ покупця та ім'я постачальника, що співпрацювали.*/

CREATE OR REPLACE VIEW CUST_KEY_TO_VENDOR AS
  SELECT CUSTOMERS.CUST_ID, VENDORS.VEND_NAME
  FROM CUSTOMERS 
  JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
  JOIN ORDERITEMS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
  JOIN PRODUCTS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
  JOIN VENDORS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID;
  
/*3.2. Вивести ключ постачальника та загальну кількість проданих ним продуктів 6 балів.*/

SELECT VENDORS.VEND_ID, COUNT(ORDERITEMS.PROD_ID) AS COUNT_NUM
FROM VENDORS JOIN PRODUCTS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
JOIN ORDERITEMS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
GROUP BY VENDORS.VEND_ID;
