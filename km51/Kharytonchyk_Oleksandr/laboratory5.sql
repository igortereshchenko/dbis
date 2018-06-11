-- LABORATORY WORK 5
-- BY Kharytonchyk_Oleksandr
CREATE OR REPLACE FUNCTION GetQuantityOfEmptyOrders (idd ORDERS.cust_id%type) IS
RETURN quantityOfEmptyOrders NUMBER;
BEGIN
  SELECT COUNT(*) INTO quantityOfEmptyOrders
  FROM (
    SELECT ORDERS.CUST_ID
    FROM ORDERS FULL JOIN ORDERITEMS 
      ON OREDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
      WHERE (ORDERS.ORDER_NUM NOT IN (ORDERITEMS.ORDER_NUM)) AND (ORDERS_CUST_ID = idd);
       )
  GROUP BY ORDERS.cust_id;  
END;



CREATE OR REPLACE PROCEDURE GetIdByEmail (email IN cust_email%type,
                                          idd OUT cust_id%type) IS
BEGIN 
  SELECT CUST_ID INTO idd
  FROM CUSTOMERS 
  WHERE (CUST_EMAIL = email)
EXCEPTION
  WHEN  NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE ('Exception has been thrown');
END;


CREATE OR REPLACE PROCEDURE SetNameById (idd IN cust_id%type, newName IN cust_name%type) IS
UserIsNotExsist EXCEPTION;
UserHasNoOrders EXCEPTION;
BEGIN
  IF ( idd NOT IN CUSTOMERS.CUST_ID ) THEN
    RAISE UserIsNotExsist
  END IF;
  IF ( idd NOT IN ORDERS.CUST_ID ) THEN
    RAISE UserHasNoOrders
  END IF;
  UPDATE CUSTOMERS 
  SET (CUST_NAME = newName)
  WHERE (CUST_ID = idd)
  EXCEPTION
  WHEN  UserIsNotExsist THEN
  DBMS_OUTPUT.PUT_LINE ('User is not exists!');
  WHEN  UserHasNoOrders THEN
  DBMS_OUTPUT.PUT_LINE ('User has no oreders!');
END;
