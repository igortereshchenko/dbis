-- LABORATORY WORK 4
-- BY Mashnenkova_Ellina
3.1
create view countorders as
SELECT customers.cust_name, count(orders.order_num )as c
From customers inner join orders
on customers.cust_id = orders.cust_id
where customers.cust_country='USA'
group by customers.cust_name

select sum(c)
from countorders

3.2
SELECT trim(products.prod_name), count(orderitems.order_num)
From orderitems inner join products
on orderitems.prod_id  = products.prod_id
group by products.prod_name
having  count( distinct orderitems.order_num) >3




cursor curs is
 select cust_name
 from customers;
 
open curs;
loop
fetch curs into name;
dbms_output.put_line ( 'name:' || name );

exit when curs%notfound;
end loop;
close curs;
 
 
 
 
 
2
set serveroutput on;
declare
 name_ products.prod_name%type;
 id_  vendors.vend_id%type:='BRS01';
 status integer;
begin
select count( products.vend_id) into status
from products inner join  vendors
on products.vend_id=vendors.vend_id
group by  vendors.vend_id, vendors.vend_name
having vendors.vend_id= id_;


if status>= 10
then dbms_output.put_line ( '>10' );
else dbms_output.put_line ( 'count:' || status );
end if;
end;

