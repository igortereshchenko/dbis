-- LABORATORY WORK 3
-- BY Kharytonchyk_Oleksandr
/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників була 10. Ключі замовників test1….testn.
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/



SET SERVEROUTPUT ON;
SET AUTOPRINT ON;

DECLARE
  v_VEND_ID Vendors.VEND_ID%TYPE;
  v_vend_countaty NUMBER := 10;
BEGIN
  DBMS_OUTPUT.ENABLE;
  FOR i IN 1..v_vend_countaty LOOP
    DMBS_OUT.PUT_LINE();
  
  END LOOP;

END;
/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він має більше 3 замовлень - статус  = "yes"
Якщо він має не менше 3 замовлень - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/



DECLARE
  v_cust_status = '';
BEGIN
  DBMS_OUTPUT.ENABLE;
  v_customer_id               := '1000000003';

  
  IF (ORDERITEMS.ORDER_ITEM   <= 3) THEN
    v_cust_status             := 'yes';
  ELSIF (ORDERITEMS.ORDER_ITEM > 3) THEN
    v_cust_status             := 'no';
  ELSE
    v_cust_status := 'unknown';
  END IF;
  DMBS_OUT.PUT_LINE( TRIM(CUSTOMERS.CUST_NAME) || v_cust_status);
END;



/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень має кожен з покупців, що проживає в Австрії.
3.2. Як звуть постачальника з Германії, що продає свої товари більше ніж у 3 різних замовленнях.
6 балів.*/

CREATE VIEW CUSTOMERS_VENDORS AS
SELECT * 
FROM CUSTOMERS JOIN ORDERS
  ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
  JOIN ORDERITEMS 
  ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
  JOIN PRODUCTS 
  ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
  JOIN VENDORS 
  ON VENDORS.VEND_ID = PRODUCTS.VEND_ID;

SELECT  CUST_ID,
        COUNT(ORDER_ITEM)
FROM CUSTOMERS_VENDORS
WHERE CUST_COUNTRY = 'Austria'
GROUP BY CUST_ID;

SELECT  VEND_NAME
FROM CUSTOMERS_VENDORS
WHERE (CUST_COUNTRY = 'Germany');
