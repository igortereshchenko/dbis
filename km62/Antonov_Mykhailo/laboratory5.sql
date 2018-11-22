-- LABORATORY WORK 5
/*
first task
*/
CREATE OR REPLACE FUNCTION func_product
(key_order IN number)
RETURN NUMBER
IS
count_number NUMBER;

BEGIN

SELECT COUNT(order_number)
FROM(
SELECT ORDREITEMS.ORDER_NUM AS order_number, COUNT(ORDERITEMS.PROD_ID) AS count_order
FROM ORDERITEMS
GROUP BY ORDERITEMS.ORDER_NUM
HAVING (count_order) = 1) INTO count_number;

RETURN count_number;

END;

/*
secound task
*/

CREATE OR REPLACE PROCEDURE proc_product
(name_product IN VARCHAR2)
IS count_cust NUMBER;
BEGIN 

EXCEPTION
WHEN OTHERS THEN
  raise_application_error(-606060,'Some text about exception');

SELECT COUNT(cudtomer_id)
FROM(
SELECT ORDERS.CUST_ID as customer_id
FROM ORDERS JOIN 
(SELECT ORDERITEMS.ORDER_NUM as order_number 
FROM PRODUCTS JOIN ORDERITEMS
ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
GROUP BY ORDERITEMS.ORDER_NUM)
ON ORDERS.ORDER_NUM = ordernumber) INTO count cust;

END;

/*
third task
*/

CREATE OR REPLACE PROCEDURE insert_order
(date_order IN DATE, num_order IN NUMBER , customer_id IN NUMBER)
IS
check_date DATE;
BEGIN

SELECT ORDER_DATE
FROM ORDERS
WHERE ORDER_DATE = date_order INTO check_date;

IF check_date = date_order THEN
INSERT INTO ORDERS(ORDER_NUM,ORDER_DATE,CUST_ID)
VALUES(num_order,date_order,customer_id);
END IF;

END;



-- BY Antonov_Mykhailo
