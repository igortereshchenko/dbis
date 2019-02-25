-- LABORATORY WORK 5
-- BY Mykhailenko_Yeva
--1
create or replace function quantity_from_name
(vendor_name vendors.vend_name%TYPE)
return orderitems.quantity%TYPE
as quantity_sum orderitems.quantity%TYPE;
begin
select sum(quantity) 
into quantity_sum
from orderitems 
join products on orderitems.prod_id=products.prod_id 
right join vendors on products.vend_id=vendors.vend_id
where vendors.vend_name=vendor_name
return (quantity_sum);
end;

--2
create or replace procedure id_from_address
(vendor_address vendors.vend_address%TYPE)
is vendor_id vendors.vend_id%TYPE;
begin
select vend_id into vendor_id
from vendors
where vend_address=vendor_address;
exception
when data_not_found then
dbms_output.put_line('error');
end;

--3
create or replace procedure update_prod_name
(new_prod_name products.prod_name%TYPE,
 old_prod_name products.prod_name%TYPE)
is old_prod_id products.prod_id%TYPE,
order_count number,
my_exception exception;
begin

select prod_id into old_prod_id
from products
where prod_name=old_prod_name;

select count(order_num) into order_count
from orderitems
where prod_id=old_prod_id;

if old_prod_name NOT IN (
select prod_name
from products)
or
order_count:=3
then raise my_exception
else 
update products
set old_prod_name:=new_prod_name
end if;

exception
when my_exception then
dbms_output.put_line('error');

end;
