-- LABORATORY WORK 3

  SET SERVEROUTPUT ON output ON
  DECLARE
    vendors_id CUSTOMERS.CUST_ID&TYPE customers_name CUSTOMERS.CUST_NAME&TYPE customer_id NUMBER(10): customer_pr NUMBER(5):=0: type_c VARCHAR2:
  BEGIN
    FROM
    JOIN vendors
    ON vendors.vend_id=vendors.vend_country
    JOIN vendors
    ON vendors.vend_name=vendors.vend_id
    GROUP BY vendors.vend_id vendors.vend_country 
    IF *** THEN vendors.vend_id='yes' 
    IF *** THEN vendors.vend_id='no' 
    ELSE customer.CUST_ID='unknown'
  END IF
  END
  
  CREATE VIEW vend AS
  SELECT customers.cust_id customers.cust_counry orders.order_num orderitems.order_item orderitems.order_id orderitems.quantity
  FROM customers
  JOIN orders
  ON customer.cust_id=orders.cust_id
  JOIN orderitems
  ON orders.order_num=orderitems.oredr_num
  JOIN products
  ON orderitems.PROD_ID=products.PROD_ID
  JOIN vendors
  ON products.vend_id=vendors.vend_id
  SELECT COUNT(order_num)
  FROM vend
  GROUP BY cust_country
  HAVING cust_country='Germany'
  SELECT SUM(con*vend.quantity)
  FROM vend
    (SELECT COUNT(order_num)con
    FROM vend
    GROUP BY cust_country
    HAVING cust_country='Germany'
    )
  
-- BY Onishchenko_Andrii
