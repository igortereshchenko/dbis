-- LABORATORY WORK 5
-- BY Miliev_Maksym
--1
create function empty_order
    (cust_id in number)
    return count_ord is
    
    begin
        select count(*) from( 
        
        
         SELECT cust_id from customers
         minus
         select distinct cust_id
         from orders
         )
    end;
    
--2    
    create procedure ret_key
    (e_mail in varchar2)
    return cust_id
    is
        begin
            select cust_id
            from customers 
            where cust_email = e_mail
        exception 
            when cust_email is null
            then DBMS.OUTPUT.LINE( 'CUSTOMER NOT FOUND')  
        end;
