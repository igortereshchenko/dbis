-- LABORATORY WORK 5
-- BY Pits_Vadym
create function null_order

select orders.order_num 
from orders join customers
on cutomers.cust_id = orders.cust_id
where orders.order_num is null

create procedure prod_value
in 
declare prod_price

create view view1
select products.prod_name from products

create view view2
select products.prod_id from products
