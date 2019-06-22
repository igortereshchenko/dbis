-- LABORATORY WORK 3
-- BY Hrydko_Oleksandr
/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників була 10. Ключі замовників test1….testn. 
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/

/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/
declare 
vendors_id vendors.vend_id%TYPE;
vendors_name VENDORS.VEND_NAME%TYPE;
vendors_status NVARCHAR2(20);
count_ INTEGER(5):=0;
min_ INTEGER(5);

begin
vendors_id :='DDL01';


select min(products.prod_price) into min_
from products;


select vendors.vend_id,VENDORS.VEND_NAME,min(products.prod_price) into 
vendors_id,vendors_name,count_
from vendors left join products on 
vendors.vend_id = products.VEND_ID
where vendors.vend_id = vendors_id
group by vendors.vend_id,VENDORS.VEND_NAME;

if count_=min_ then 
vendors_status:='yes';
elsif count_=0 then 
vendors_status:='no';
else vendors_status:='unknown';
end if;
dbms_output.put_line(trim(vendors_name)||vendors_status);
end;

/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/

create view customers_vendors_all as 
select 
customers.cust_id,
customers.cust_name,
products.prod_id,
vendors.vend_id,
vendors.vend_country 
from customers join orders on 
customers.cust_id = orders.CUST_ID 
join orderitems on 
orders.order_num = orderitems.ORDER_NUM 
join products on 
orderitems.prod_id = products.PROD_ID 
join vendors on 
products.VEND_ID = vendors.VEND_ID;

select vend_id,count(distinct prod_id)
from customers_vendors_all
where VEND_COUNTRY='Germany'
group by VEND_ID;

select cust_name,count_
from(
select cust_id,cust_name,count(distinct prod_id) as count_
from customers_vendors_all
group by cust_id,cust_name);
