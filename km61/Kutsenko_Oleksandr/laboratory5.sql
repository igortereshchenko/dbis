-- LABORATORY WORK 5
-- BY Kutsenko_Oleksandr
create or replace function count_prod (num customers.cust_id%type)
return int 
is count_pruduct number(3);
  begin
    select count(distinct(cust_id)) into count_product
    from orders join orderitems 
      on orders.order_num=orderitems.order_num;
    return count_products;
    end count_prod;
    
create or replace procedure count_cust(prod_name in products.prod_name%type)
is count_cust  num(3);
begin 
select count(distinct(prod_id)) into cust_count
from products join orderitems
on products.prod_id=orderitems.prod_id
where (select order_num from orederitems join orders on orders.order_num=orderitems.order_num where cust_id)
if  (cust_count=0) then
EXCEPTION 
end if;
end count_cust;


create or replace procedure delete_order (order_date in orders.order_date%type, cust in orders.cust_id%type)
is del_order num(3)
begin 
select count(order_num) into count_del from orders

if (count_del = 0 )
then 
DELETE FROM orders WHERE order_num
else 
EXception
end if;
end delete_order;
