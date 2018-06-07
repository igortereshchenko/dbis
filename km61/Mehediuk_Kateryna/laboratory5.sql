-- LABORATORY WORK 5
-- BY Mehediuk_Kateryna
1
create function count_order(cust_id in number, order_num in number)
return number
is
count_order_num
begin

where counter = 'notnull'
select 
customers.cust_id;
oredrs.order_num;
from customers join orders
customers.cust_id=orders.cust_id
join orderitems
orders.order_num=oredritems.order_num
group by customers.cust_id,oredrs.order_num 
return count_order_num
end count_order;

3
create procedure update_order_date(order_num in number, order_date in number)
is
begin
select count(order_num) in counter from orders
if counter = '0' then
raise_application_error
elsif if counter = 'null' then
raise_application_error
else 
select count(order_date) in counter from orders
where order_date='old.oredr_date'
update orders
set order_date ='new.order_date'
where order_date='old.oredr_date'
end if;
end;

2
create procedure return_cust_id(cust_name in varchar, cust_id in number)
is
begin
select 
customers.cust_id;
customers.cust_name;
from customers
join customers.cust_name=customers.cust_id
return cust_id
end;
