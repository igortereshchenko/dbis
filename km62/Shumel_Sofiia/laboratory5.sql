-- LABORATORY WORK 5
-- BY Shumel_Sofiia

-----------------------------------
create or replace function count_ord (id cust_id%type)
Return int;

is
count int;

begin
  select count (order_num) into count 
  FRom (
    SELECT  order_num, cust_id
    FROM customers natural join orders 
    join Orderitems on orders.order_num = orderitems.order_num
    Group By order_num, cust_id
    Having cust_id = id 
    and
    count (prod_id)=1;)
    
Return count
end;


--------------------------------------------------------------------------

Create or replace procedure foo(input_name in prod_name%type, count out int) is
begin
    select count_order into count from
      (select prod_id, prod_name, count(order_num) count_order
      from products natural join orderitems
      join Orders on orderitems.order_num = orders.order_num
      group by prod_id, prod_name
      having prod_name = input_name)
  exception
    when data_no_found then 
    dbms_output.output_line("error!");
end;


--------------------------------------------------------------------------
Create or replace procedure new (new_order_num in order_num%type, new_order_date in order_date%type, new_cust_id in cust_id%type) is
ex exception;
begin

  if select order_num from (
        (select order_num, order_date, cust_id, count(prod_id) as count_prod
        from 
        orders join orderitems
        group by order_num, order_date, cust_id
        having cust_id = new_cust_id and order_date = new_order_date and count_prod = 3))
    is not null
  then raise ex exception 
  end if;
  
  UPDATE orders(order_num, order_date, cust_id) 
  set (new_order_num, new_order_date, new_cust_id);
  
  exception
    when ex then 
      dbms_output.output_line("error!");
end;

