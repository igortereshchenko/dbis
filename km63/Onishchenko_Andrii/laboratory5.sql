-- LABORATORY WORK 5

create  function count_prod(vend_name_id in varchar2)
return number
is 
count_ord_num number;
begin
select count(prod_id) from OrderItems
join vendors 
on vendors.vend_id = products.prod_id
join products 
on products.prod_id=orderitems.order_num
where vendors.vend_id=prod_id;
return count_ord_num;

end;

create procedure vend_id (vendor_name in varchar2; vendor_id out varchar2)
is 
begin
select vend_id into vendor_id from vendors;
where vend_name=vendor_name;
if vend_id=''then
raise_application_error('exception');
end if;
        
end;

-- BY Onishchenko_Andrii
