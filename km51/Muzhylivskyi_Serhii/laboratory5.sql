-- LABORATORY WORK 5
-- BY Muzhylivskyi_Serhii
--1
CREATE OR REPLACE FUNCTION count_of_not_null_orders(custID orders.cust_id%type)
  RETURN NUMBER
  is amount number;
  BEGIN
    SELECT COUNT(ORDER_NUM)
    INTO amount
    from ORDERS
    where CUST_ID = custID;
    if amount <>0 then
      return amount;
      else raise NO_DATA_FOUND;
      end if;
  end;

DECLARE
  amount_of_orders number;
  id orders.cust_id%TYPE;
BEGIN
    id := '1000000001';
    amount_of_orders:=count_of_not_null_orders(id);
    DBMS_output.put_line(amount_of_orders);
end;


-- 2
CREATE OR REPLACE PROCEDURE key_finder(cName CUSTOMERS.cust_name%type, id OUT CUSTOMERS.cust_id%type)
  is
  BEGIN
    SELECT CUST_ID INTO id FROM CUSTOMERS
      where CUST_NAME = cName;
    EXCEPTION WHEN NO_DATA_FOUND
    then RAISE NO_DATA_FOUND;
  end;

-- 3
create or replace procedure updater(key orders.order_num%type)
  is 
  begin 
    
  end;
