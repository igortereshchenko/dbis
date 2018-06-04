-- LABORATORY WORK 5
-- BY Chala_Hanna
create function prod_price (int temp,
order_nums := Orders.order_num%type)
begin
select order_num,
count(quantity*itemprice) as price_sum
from
OrderItems
group by order_num;

if temp != 0 then
stdb = (order_nums = "order_num", temp = "price_sum")
end if;
end;


create procedure order_date(prod_name = Products.prod_name%type,
int temp)
begin
select count(prod_id) as temp
from Products left join OrderItems
on Products.prod_id = Orderitems.prod_id;

if temp != 0 then
update (prod_name) on Products
end if;
end;
