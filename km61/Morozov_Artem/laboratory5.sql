-- LABORATORY WORK 5
-- BY Morozov_Artem
--написатіи функцію , що повертае ключ та ім"я покупця , за ключем його замовлен
set SERVEROUTPUT ON


create or replace function name_for_key (key ORDERS.ORDER_NUM%TYPE)
RETURN VARCHAR2 as
  res varchar2 := ' ';
begin 
  select cust_name || ' ' || cust_id into res 
  from orders LEFT join customers on orders.cust_id =customers.cust_id
  where ORDERS.ORDER_NUM = key;
end name_for_key;


--
create or replace procedure DELETE_this ( var in out
