-- LABORATORY WORK 5
--1 завдання
create or replace function countCust(cust_name customers.cust_name%Type) RETURN number
is 

prod_count number;
begin 
    select count(cust_id) into cust_count
    from customers join orders
    on customers.cust_id = orders.cust_id
    join orderitems
    on orders.ORDER_NUM=orderitems.ORDER_NUM
    where  prod_id is null;
    RETURN  prod_count;
    end countCust;

--2 завдання
create or replace procedure custKey (cust_name in customers.cust_name%Type,cust_email in customers.cust_email%Type, key out customers.cust_id%Type ) 
is 
    begin 
        select customers.cust_id into key
        from customers
        where cust_name = cust_name and cust_email=cust_email;
    EXCEPTION
    when no_data_found then 
    RAISE_application_error (-20555, 'No found vendor`s key');
end custKey;

--3 завдання
create or replace procedure updateORDER (oldOrderName in orders.order_num%Type,newordernum in orders.porder_num%Type ) 
is 

count3 exception;
order_count number;
    begin 
    
    select order_num into  newordernum
    from customers join orders
    on customers.cust_id = orders.cust_id
    where orders.porder_num = oldOrderName;
    
    if (cust_name not in customers.cust_name)then 
    raise  count3 ;
    ELSE
    update orders SET order_num = newordernum
    where order_num = oldOrderName;
    end if;
EXCEPTION
    when no_data_found then 
    RAISE_application_error (-20555, 'No found product');
    when count3 then 
    RAISE_application_error (-20556, 'Order count = 3');

end updateORDER ;





-- BY Beshta_Vladyslav
