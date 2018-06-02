-- LABORATORY WORK 5
-- BY Serpokryl_Andrii
SET SERVEROUTPUT ON;
/* Написати функцію, що повертає кількість продуктів постачальника за ім'ям ростачальника*/

create or replace function amount_of_prod (v_name Vendors.vend_name%Type )
return number
Is
 amount number;
 begin
select count(Products.prod_id) into amount 
    from Vendors JOIN Products 
    on Vendors.vend_id = Products.vend_id
    Where Vendors.vend_name = v_name;

return(amount);
end;


create or replace procedure find_vend_key(address IN VENDORS.VEND_ADDRESS%TYPE )
IS
r vendors.vend_id%type;
e exception;
    begin
        sELECT VENDORS.VEND_ID into r FROM VENDORS
        WHERE VENDORS.VEND_ADDRESS = address;
        
        if r = NULL then
        raise e
end

  Exception 
    when e 
    DBMS.Output.putline('Error')
end find_vend_key;
