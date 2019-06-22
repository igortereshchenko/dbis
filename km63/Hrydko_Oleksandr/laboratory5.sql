-- LABORATORY WORK 5
-- BY Hrydko_Oleksandr
create or replace function name_(custId customers.cust_id%type) 
return int 
as 

count_ INTEGER(5):=0;
begin 

select count(order_num) into count_
from(
select orders.order_num
from orders,orderitems

minus 

select orders.order_num
from  orderitems,orders 
where  orders.order_num = orderitems.ORDER_NUM
),customers
where custId = customers.cust_id
;
return count_;

end name_;

select  name_('1000000001')
from customers;



