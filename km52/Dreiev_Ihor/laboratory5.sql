-- LABORATORY WORK 5
-- BY Dreiev_Ihor
create or replace Function Prods_by_vend_id(v_id in Vendors.Vend_Id%TYPE) 
   Return Number Is
   result Integer;
Begin 
    select count(*) into result
    from Vendors join Products
    on Vendors.vend_id = Products.vend_id
    where Vendors.vend_id = v_id;
  Return result;
End Prods_by_vend_id;








create or replace procedure Vend_name_by_id(v_id out Vendors.Vend_Id%TYPE, v_name in Vendors.Vend_Name%TYPE)
is
NO_VENDOR Exception;
res Vendors.Vend_id%TYPE;
Begin 
select distinct Vendors.vend_id into res from Vendors
where Vendors.vend_name = v_name;
if res is Null Then
Raise NO_VENDOR;
else
    v_id := res;
end if;


EXCEPTION
when NO_VENDOR then
    Dbms_Output.Put_Line('vendor nema');


end Vend_name_by_id;









create or replace procedure upt_prod(pr_id in Products.Prod_Id%TYPE, new_price in Products.Prod_Price%TYPE)
is
no_prod exception;
sell_prod exception;
pr_c Integer;
oi_c integer;
begin
select count(*) into pr_c from Products
where Products.prod_id = pr_id;

select count(*) into oi_c 
from Products join Orderitems
on Products.prod_id = Orderitems.prod_id
where Products.prod_id = pr_id;

if pr_c = 0 then
raise no_prod;
elsif oi_c != 0 then
raise sell_prod;
end if;


update table Products
set
    Prod_Price = new_price
where
    Products.prod_id = pr_id;
    
    
EXCEPTION
when no_prod then
    Dbms_Output.Put_Line('no prod');
when sell_prod then
    Dbms_Output.Put_Line('prod is sell');
end upt_prod;
