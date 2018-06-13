-- LABORATORY WORK 5
-- BY Buchynska_Kateryna
-------------1--------------
create function key_return
return Vendors.vend_id%type 
is  
varchar2(15) key = Vendors.vend_id%type

create cursor c1
in select Vendors.vend_id, Products.prod_id
from Vendors join products 
on Vendors.vend_id = Products.prod_id;
-----------------2---------------
Create procedure proc_rename
in
declare prod_name = "King doll"

create view  view1
select products.prod_id from Products

create view view2
select prod_id from OrderItems;

if ( prod_name in view1) and ( prod_name not in view2)
update table Products set prod_name = "new_prod_name" 

else raise exeption
error_application ("Product does not exist or was never bought")
select proc_rename from dual;
--------------------------3----------------

create procedure proc_add
in 
(
 v_prod_id Products.prod_id%type
 v_vend_id Products.vend_id%type
 v_prod_name Products.prod_name%type
 )
 
 declare 
 
 if (Products.prod_name%notfound)
 {
    raise exeption 
    error_application ("error") 
 } ;
  



 
