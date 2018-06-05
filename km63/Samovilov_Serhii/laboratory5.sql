-- LABORATORY WORK 5
Create function cust_name_key 
 (def_id in number, customer_name in vchar2)
 
return  customer_name vchar2,
def_id number

is

begin 
select cust_name into customer_name
from CUSTOMERS
where cust_id = def_id

return def_id, customer_name

end;




create procedure deleter 
(def_name in vchar2)
is
exception is_distinct 
exception no_data

begin 

select cust_id 
from Orders, Customers

where 
delete order_num from orders 
when cust_name = def_name 

select order_num 
from Orders  



-- BY Samovilov_Serhii
