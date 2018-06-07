-- LABORATORY WORK 3
-- BY Mashnenkova_Ellina
1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 10. Ключі постачальників vvv1….vvvn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/

/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/
set SERVEROUTPUT ON;

declare
vendor_name vendors.vend_name%type;
min_price products.prod_price%type;
vendor_id vendors.vend_id%type; 
vendor_type char(10) := '';

begin
vendor_id := 'BRS01';
min_price := 0;
select vendors.vend_name, min(orderitems.item_price) into vendor_name, min_price
from orderitems join products on orderitems.prod_id = products.prod_id
right join vendors on products.vend_id = vendors.vend_id
where vendors.vend_id = vendor_id
group by vendors.vend_name;


if min_price > 0 then vendor_type := 'yes';
elsif min_price = 0 then vendor_type := 'unknown';
else vendor_type := 'no';
end if;

dbms_output.put_line(vendor_name || vendor_type);

end;


/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/

create view customers_vendors as
select customers.cust_id, customers.cust_name, products.prod_id, vendors.vend_id, vendors.vend_name, orderitems.quantity, vendors.vend_country
from customers
left join orders on customers.cust_id = orders.cust_id
join orderitems on orders.order_num = orderitems.order_num
join products on orderitems.prod_id = products.prod_id
right join vendors on products.vend_id = vendors.vend_id;

select vend_id, vend_name, sum(quantity)
from customers_vendors
where vend_country = 'Germany'
group by vend_id, vend_name;

select cust_id, cust_name, sum(quantity)
from customers_vendors
group by cust_id, cust_name;
