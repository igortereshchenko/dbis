-- LABORATORY WORK 3
-- BY Chernetskyi_Valentyn
/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 10. 
Ключі постачальників vvv1….vvvn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/

declare
vend_id   VENDORS.VEND_ID%type
vend_name vendors.vend_name%type

begin
end;


/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/

DECLARE
vendor_id    VENDORS.VEND_ID%TYPE;
vendor_name  vendors.vend_name%TYPE;
vendor_type  nvarchar2(14);
item_count   integer := 0;
prod_price   products.prod_price%type;

BEGIN

vendor_id := 'BRS01';

SELECT 
VENDORS.VEND_ID
VENDORS.VEND_NAME
count(products.prod_id)
into vendor_id, vendor_name, item_count

FROM
vendors

left join products on vendors.vend_name=vendor_id

group by
vendors.vend_id,
vendors.vend_name;

if
item_count = 0 then vendor_type := 'unknown';
elsif
prod_price := 3.49 then vendor_type := 'yes';
else vendor_type := 'no';
end if;

dbms_output.put_line(trim(vendor_name)||vendor_type;
end;


/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/

create view orderitems_customers as

select

customers.customer_name,
orderitems.quantity,
vendors.vend_name

from customers
join orders on ORDERS.CUST_ID=CUSTOMERS.CUST_ID
join orderitems on orders.order_num=orderitems.order_num
join products on products.prod_id=orderitems.prod_id
join vendors on vendors.vend_id=products.prod_id

select

customer_name,
quantity

from orderitems_customers

group by
customer_name,
quantity;

select 

quantity,
vend_name

from orderitems_customers
where vend_country='GERMANY';




