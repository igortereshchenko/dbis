-- LABORATORY WORK 5
-- BY Biedukhin_Tymur

CREATE OR REPLACE FUNCTION order_counter (IN customer_key)
  RETURN number(5);
IS
  result number(5);
BEGIN
  SELECT INTO result COUNT(*)
    FROM Orders 
    WHERE Orders.cust_id = customer_key 
  return result;
END;


CREATE OR REPLACE PROCEDURE key_getter (IN customer_name, OUT customer_key)
IS
BEGIN
  SELECT INTO customer_key cust_id 
    FROM Customers 
    WHERE Customers.cust_name = customer_name
  EXCEPTION
    WHEN NO_DATA_FOUND THEN 
    dbms_output.put_line('Can not find key by this name');
END;


CREATE OR REPLACE PROCEDURE date_update (IN order_number, IN new_date)
IS
  doesnt_exist EXCEPTION;
  not_empty EXCEPTION;
BEGIN
  UPDATE Orders
    SET order_date = new_date
    WHERE order_num = order_number
  EXCEPTION 
    WHEN doesnt_exist THEN 
    dbms_output.put_line('Order number doesnt exist');
END;
