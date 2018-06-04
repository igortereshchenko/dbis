-- LABORATORY WORK 5
-- BY Mehediuk_Kateryna
create function prod_id(vend_name_id in varchar2)
return vend_id
is
begin
select from Products
join products
on products.prod_id=products.vend_id
select from Vendors
join vendors
on vendors.vend_id=vendors.vend_name
return vend_name
end;

create procedure delete_prod(parameters)
is
products.prod_id
products.vend_id
vendors.vend_name
begin
select from Products
join products
on products.prod_id=products.vend_id
select from Vendors
join vendors
on vendors.vend_id=vendors.vend_name
if vend_name='unique'then
Exception
else if prod_id='null' then
Exception
end if;
end;
