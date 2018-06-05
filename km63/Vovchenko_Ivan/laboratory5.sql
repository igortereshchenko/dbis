-- LABORATORY WORK 5
-- BY Vovchenko_Ivan
1.
create  function count_product (vend_name_id in varchar2)
return number
is 
count_order_number number;
begin
select count(prod_id ) from OrderItems
join vendors on vendors.vend_id = products.prod_id
join products on products.prod_id=Orderitems.Order_Num
where Vendors.Vend_Id=Prod_id;
return count_order_numbe;
end;
2.
create procedure print_key(parameters)
is
customers.cust_id
begin
select  customers.cust_email
from customers
if cust_email = 'null' then
Exception
end if;
end;
