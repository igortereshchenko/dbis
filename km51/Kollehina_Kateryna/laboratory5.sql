-- LABORATORY WORK 5
-- BY Kollehina_Kateryna
create or replace function quantity_customers ( country customers.cust_country%TYPE)
return int;
is
  int quantity; 
begin
  select 
     count(customers.cust_name)
     into 
      quantity 
     from customers
       join orders on customers.cust_id=orders.cust_id
       right join orderitems on orderitems.order_num=orders.order_num
       where customers.cust_country=country and orderitems.order_items is null; 
  return quantity;

end quantity_customers;

create or replace procedure email_name_customers ( email in customers.cust_email%TYPE,  c_name in customers.cust_name%TYPE, C_id out customers.cust_id%TYPE);
is
begin 
    select
     cust_id
    into  
     c_id
    from customers 
    where customers.cust_name= cust_name
    dbms_output.put_line(c_id);
exception
 when no_data_found then
 raise exception;
end email_name_customers;

create or replace procedure add_order_to_customer( ordernum in orders.order_num%TYPE,orderdate_new in orders.order_date%TYPE)
is
tmp_date orders.order_date%type;
my_exception exception;
 pragma
 exception_init(my_exception, -2292);
begin 
 select orders.order_date, 
 into tmp_date
 where order_num = ordernum;
 insert into orders( order_num,
                     order_date,
                     cust_id)
 values( ordernum,
         tmp_date,
         custid)
 where orders.order_date = orderdate_new;
 when no_data_found then
 raise exception;
 when my_exception then
 raise my_exception;
end add_order_to_customer;
