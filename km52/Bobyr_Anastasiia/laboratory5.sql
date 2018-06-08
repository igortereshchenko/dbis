-- LABORATORY WORK 5
-- BY Bobyr_Anastasiia\


-- 1. Написати функцію, що повертає кількість не порожніх замовлень покупця за ключем покупця.

create or replace function get_orders_count(custid customers.cust_id%type)
return int
as
        orderscount int;
begin
        select count(distinct orders.order_num) into orderscount from orders join orderitems on orders.order_num = orderitems.order_num where orders.cust_id=custid ;
        return orderscount;
        
end get_orders_count;




-- 2. Написати процедуру, що за ім'ям покупця повертає його ключ, якщо операція неможлива - процедура кидає exception.

create or replace procedure get_cust_id(custname IN customers.cust_name%type, custid OUT customers.cust_id%type)
is

begin 

select customers.cust_id into custid from customers where customers.cust_name = custname;

exception 
when no_data_found then
 dbms_output.put_line ('there is no customer with this name'); 
 
end get_cust_id;





-- 3. Написати процеруру, що оновлює дату замовлення. Визначити усі необхідні параметри. Якщо замовлення не існує, або замовлення не порожнє -  процедура кидає exception

create or replace procedure update_order_date(ordernum IN orders.order_num%type, orderdateupdated IN orders.order_date%type) 
is
    tmp_date orders.order_date%type;  
    
  Child_rec_exception EXCEPTION; 
  PRAGMA 
   EXCEPTION_INIT (Child_rec_exception, -2292);
   
begin 
    select orders.order_date into tmp_date where orders.order_num = ordernum; 
    update orders set orders.order_date = orderdateupdated where orders.order_num = ordernum;
    exception 
when no_data_found then
 dbms_output.put_line ('there is no order with this order number'); 

when Child_rec_exception 
then Dbms_output.put_line('order is not empty'); 

end update_order_date;

