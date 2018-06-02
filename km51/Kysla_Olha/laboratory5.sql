-- LABORATORY WORK 5
-- BY Kysla_Olha
set serveroutput on 

CREATE OR REPLACE FUNCTION f_name (
    v_cust_id customers.cust_id%TYPE
) RETURN number  AS
    v_count_ord  number(20);
BEGIN
     SELECT count(orders.order_num) INTO v_count_ord 
            
        FROM
            customers
            JOIN orders ON customers.cust_id = orders.cust_id
            right join ORDERITEMS on orders.order_num = ORDERITEMS.order_num
            
        WHERE
            ORDERITEMS.ORDER_NUM is null;
        return v_count_ord;

END f_name;

------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE proc_by_email ( email  IN customers.cust_email%TYPE, c_id  OUT customers.cust_id%type)
    IS
    BEGIN
        SELECT
         customers.cust_id
        INTO
         c_id
        FROM
         customers
        WHERE
         customers.cust_email = email;
         dbms_output.put_line(c_id);
    EXCEPTION when NO_DATA_FOUND THEN 
 dbms_output.put_line ('this customer does not exist '); 
END proc_by_email;


DECLARE
    email         customers.cust_email%TYPE;
    c_id   customers.cust_id%type;
BEGIN
     email := 'jjones@fun4all.com';
    proc_by_email(email => email,c_id => c_id);
    dbms_output.put_line(c_id);
END;

------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE f_cust_name ( name in customers.cust_name )
is 
v_count number ;
v_id customers.cust_id% type ; 
v_order orders.order_num%type ;
begin 
select count (customers.cust_name)into v_count from customers
where customers.cust_name = name ;

if (v_count = 1) then 
    select customers.cust_id into v_id from customers
    where customers.cust_name = name ;
    
    select orders.order_num into v_order 
    from CUSTOMERS join orders on 
    orders.cust_id = v_id;
    
    if (v_order is null) then 
        update customers 
        set customers.cust_id = 'new name';
    end if;

end if;

end f_cust_name;
