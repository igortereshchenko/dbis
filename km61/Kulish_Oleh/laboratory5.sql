-- LABORATORY WORK 5
-- BY Kulish_Oleh
create or replace function foo id1 
  return int, string
  is 
  
  declare
  begin 
  end
  return select cust_id, cust_name from customers
    where customers.cust_id = id1s;




create or replace procedure foo1 nume_cust 
  is 
  declare
  begin 
    select 
  end
