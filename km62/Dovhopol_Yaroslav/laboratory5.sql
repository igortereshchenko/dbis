-- LABORATORY WORK 5
-- BY Dovhopol_Yaroslav
SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION ORDERS_COUNT (DATE_TO_CHECK ORDERS.order_date%type)
return integer;
declare orderscount integer;
  begin 
    select count(*) into orderscount
    from ORDERS
    where order_date = DATE_TO_CHECK
    
    return orderscount;
end;




CREATE OR REPLACE PROCEDURE rename_customer(customer_id CUSTOMERS.CUST_ID%type,
                                            new_name CUSTOMERS.CUST_NAME%type)
IS
  CHEKER NUMBER(10);
BEGIN 
  
  SELECT COUNT(*) INTO CHECKER FROM ORDERS WHERE CUST_ID = customer_id
    
  IF(CHECKER > 0) THEN 
    UPDATE CUSTOMERS
    SET CUST_NAME = new_name
    WHERE   CUST_ID = customer_id
  END IF;
  
  EXCEPTION 
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PRINTLINE("AN ERROR OCURED");
END;
