/*1. Написати PL/SQL код, що по вказаному ключу постачальника додає йому продукти з ключами 111,....111+n, 
щоб сумарна кількість його продуктів була 10. Назви продуктів - будь-яка ностанта. 
Ціна кожного продукту наступного продукту на одиницю більша ніж попередній, починати з 1.
 10 балів*/
 

SET SERVEROUTPUT ON
DECLARE
  n_last_date       DATE;
  n_vend_id         VARCHAR2(20) DEFAULT 'BRS01';
  n_count_of_orders INT DEFAULT 0;
  n_how_many_to_add INT DEFAULT 0;
  
  
BEGIN
  SELECT COUNT(DISTINCT ORDER_NUM)
  INTO n_count_of_orders
  FROM orders
  WHERE 
  
  IF 
  
  ELSE
  
  END IF;
END;



/*2. Написати PL/SQL код, що по вказаному ключу постачальникавиводить у консоль його ім'я та изначає  його статус.
Якщо він має до 2 продуктів включно - статус  = "common"
Якщо він має більше 2 продуктів - статус  = "rich"
інакше він має статус "o status" 4 бали*/
DECLARE
  v_vend_id      Varchar2(20) default 'brs01';
  v_vend_name    Varchar2(20);
  v_product_count int DEFAULT 0;
  v_vent_status  Varchar(10) default 'poor';
BEGIN
  SELECT vend_NAME INTO v_vend_name FROM vendors WHERE vend_ID = v_vend_id;
  SELECT COUNT(DISTINCT prod_id)
  INTO v_product_count 
  FROM  products
  WHERE vend_ID = v_vend_id;
  DBMS_ouput.put_line(v_vend_name);
  IF v_product_count    <= 2 THEN
    v_vend_status     := 'common';
  elsif  v_product_count > 2 THEN
    v_vend_status     := 'rich';
  ELSE
    v_vend_status := 'o status';
  END IF;
END;  
 
 


/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ім'я покупця та ім'я постачальника, що не співпрацювали.
3.2. Вивести ключ постачальника та загальну кількість проданих ним продуктів 6 балів.*/

CREATE VIEW my_view AS
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








