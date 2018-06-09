-- LABORATORY WORK 5
-- BY Mitrokhin_Oleksii
Create or replace function func_order (cust_id in CUSTOMERS.CUST_ID %type) RETURN NUMBER
is
order_sum NUMBER
begin
select
orders.order_num
from
customers join orders
in customers.cust_id = orders.cust_id
join orderitems
in orders.order_num = orderitems.order_num
where customers.cust_id = cust_id and orderitem.order_item = null
group by orders.order_num
having count(orders.order_num) into order_sum
RETURN num
end func_order;


create or replace procedure key_order (prod_name in products.prod_name %type, order_id out orders.order_id %type)
is
order_id orders.order_id %type
begin
select
orders.order_id into order_id
from
products join orderitems
in products.prod_id = orderitems.prod_id
where products.prod_name = prod_name
group by orders.order_id
exception
when data not find
end key_order;

create or replace procedure prod_price_up (prod_name in products.prod_name %type)
is
prod_price products.prod_price %type
begin
select
count(products.prod_id) as prod_count
from
products
where products.prod_name = prod_name
if prod_count = 1
update table products
products.prod_price = 132;
where products.prod_name = prod_name
end if;
exception
when prod_count = 0 or prod_count = null
end prod_price_up;
