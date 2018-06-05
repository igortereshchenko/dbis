--------------------1-------------------
declare customer_id, customers.cust_id%TYPE;
        customer_zip, customers.cust_zip%TYPE;
        order_number, orders.order_num%TYPE;
        order_date, orders.order_date%TYPE;
        customers_count INTEGER := 10;
        
begin
        customer_id := 'c1';
        customer_zip := 'ord1';
        order_date := '01.05.2004';
        for i in 1..customers_count LOOP
        
insert into customers (
cust_id
cust_zip
order_num
order_date)

--------------------2--------------------
declare
count_of_products INTEGER := 0;
begin
select 
count(*) into count_of_products 
from 
VENDORS join PRODUCTS
on VENDORS.VEND_ID = PRODUCTS.VEND_ID
join ORDERITEMS
on PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID

if (count_of_products > 10) 
then DBMS_OUTPUT.PUT_LINE ('БІЛЬШЕ 10');
else DBMS_OUTPUT.PUT_LINE ('count of costumers:' || count_of_products);
end if;
end;


--------------------3---------------------
create view view1 as
select ORDERS.ORDER_NUM,
       PRODUCTS.PROD_ID,
       VENDORS.VEND_NAME,
       CUSTOMERS.CUST_CITY
       
from customers join orders
on customers.cust_id = orders.cust_id
join orderitems 
on orders.order_num = orderitems.order_num
join products
on orderitems.prod_id = products.prod_id
join vendors
on products.vend_id = vendors.vend_id

select ORDER_NUM,
       QUANTITY
count(distinct prod_id)
from view1
group by ORDER_NUM,
         QUANTITY;
         
select VEND_NAME,
       ORDER_NUM
from view1
where customers.cust_city = not null;
       
       
       
