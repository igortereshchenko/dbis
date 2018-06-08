-- TASK 1

CREATE OR REPLACE FUNCTION price_func(order_id IN INT)
RETURN INT 
AS
  price INT;  
BEGIN

SELECT
  SUM(orderitems.quantity * orderitems.item_price)
INTO
  price
FROM
  orderitems
WHERE orderitems.order_num = order_id;

RETURN price;

END price_func;

-- TASK 2

CREATE OR REPLACE FUNCTION order_date_func(product_name IN VARCHAR2)
RETURN DATE 
AS
  result_str VARCHAR2;
  CURSOR is cur;
BEGIN

SELECT
  customers.cust_name || orders.order_date
INTO
  result_str
FROM
  customers INNER JOIN orders ON customers.cust_id = orders.cust_id
  INNER JOIN orderitems ON orders.order_num = orderitems.order_num
  INNER JOIN products ON orderitems.prod_id = products.prod_id
WHERE products.prod_name = product_name;

RETURN result_str;

END order_date_func;
