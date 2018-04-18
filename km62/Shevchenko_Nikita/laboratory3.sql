-- LABORATORY WORK 3
-- BY Shevchenko_Nikita
/*1. Ќаписати PL/SQL код, що по вказаному ключу замовника дода№ йому замовленнЯ з номерами 1,....n, 
щоб сумарна кґлькґсть його замовлень була 10. „ати нових замовлень дорґвнюють датґ останього замовленнЯ. 
ЋперацґЯ викону№тьсЯ, Якщо у замовника № хоча б одне замовленнЯ. 10 балґв*/

SET SERVEROUTPUT ON
DECLARE
  v_last_date       DATE;
  v_cust_id         VARCHAR2(20) DEFAULT '1000000001';
  v_count_of_orders INT DEFAULT 0;
  v_how_many_to_add INT DEFAULT 0;
BEGIN
  SELECT COUNT(DISTINCT ORDER_NUM)
  INTO v_count_of_orders
  FROM ORDERS
  WHERE CUST_ID = v_cust_id;
  SELECT MAX(ORDER_DATE) INTO v_last_date FROM ORDERS WHERE CUST_ID = v_cust_id;
  IF v_count_of_orders != 0 THEN
    v_how_many_to_add  := 10 - v_count_of_orders;
    FOR i                   IN 1..v_how_many_to_add
    LOOP
      INSERT INTO ORDERS VALUES
        (i,v_last_date,v_cust_id
        );
    END LOOP;
  ELSE
    dbms_output.put_line('No orders!');
  END IF;
END;
/*2. Ќаписати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ґм'Я та изнача№  його статус.
џкщо вґн ма№ 0 замовлень - статус  = "poor"
џкщо вґн ма№ до 2 замовлень включно - статус  = "common"
џкщо вґн ма№ бґльше 2 замовлень - статус  = "rich" 4 бали*/

DECLARE
  v_cust_id      VARCHAR2(20) DEFAULT '1000000001';
  v_cust_name    VARCHAR2(20);
  v_orders_count INT DEFAULT 0;
  v_cust_status  VARCHAR2(10) DEFAULT 'poor';
BEGIN
  SELECT CUST_NAME INTO v_cust_name FROM CUSTOMERS WHERE CUST_ID = v_cust_id;
  SELECT COUNT(DISTINCT ORDER_NUM)
  INTO v_orders_count
  FROM ORDERS
  WHERE CUST_ID = v_cust_id;
  dbms_ouput.put_line(v_cust_name);
  IF v_orders_count    = 0 THEN
    v_cust_status     := 'poor';
  elsif v_orders_count > 0 AND v_orders_count < 3 THEN
    v_cust_status     := 'common';
  ELSE
    v_cust_status := 'rich';
  END IF;
END;

/*3. ‘творити предсавленнЯ та використати його у двох запитах:
3.1. ‚ивести ключ покупцЯ та постачальника, що спґвпрацювали.
3.2. ‚ивести ґм'Я покупцЯ та загальну кґлькґсть куплених ним продуктґв 6 балґв.*/
CREATE VIEW MY_VIEW AS
SELECT CUSTOMERS.CUST_ID,
  CUSTOMERS.CUST_NAME,
  VENDORS.VEND_ID,
  COUNT(PRODUCTS.PROD_ID)
FROM CUSTOMERS
JOIN ORDERS
ON (CUSTOMERS.CUST_ID = ORDERS.CUST_ID)
JOIN ORDERITEMS
ON (ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM)
JOIN PRODUCTS
ON (ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID)
JOIN VENDORS
ON (VENDORS.VEND_ID = PRODUCTS.VEND_ID)
GROUP BY CUSTOMERS.CUST_ID,
  CUSTOMERS.CUST_NAME,
  VENDORS.VEND_ID;





