-- LABORATORY WORK 5
-- BY Bilenko_Vladyslav
1.
Create or replace function ten_products count(orderitems.order_num)
return number(3)
as
orderitems.order_num%type
output number(3)
begin
select count(orderitems.order_num) into orderitems.order_num
from
orders join orderitems 
on orders.order_num = orderitems.order_num
where count(orderitems.order_num) = 10
exception 
 WHEN NO_DATA THEN;
 RETURN ' ':
 output :=  orderitems.order_num
 RETURN output:
 END ten_products;


2.
CREATE OR REPLACE PROCEDURE is_product (prod PRODUCTS.prod_id%TYPE)
IS
prod_name_inf PRODUCTS.prod_id%TYPE;
prod_id_inf PRODUCTS.prod_id%TYPE;
BEGIN
if (prod_name = 1) then
SELECT products.prod_name, products.prod_id into prod_name_inf, prod_id_inf
FROM 
Products 
WHERE Products.prod_id=prod
else if
EXCEPTION
END is_product;


3. 
create or replace procedure delete_inf (order_num orders.order_num%type)
is 
orders.order_date%type
orders.order_num%type
begin
if (orders.order_date is not null and orders.order_num = 1) then
delete orders (order_num)
else if
exception
declare "operation can't be done" 
end delete_inf;
