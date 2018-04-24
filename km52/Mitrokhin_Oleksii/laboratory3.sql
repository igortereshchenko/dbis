-- LABORATORY WORK 3
-- BY Mitrokhin_Oleksii
/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 7. Ключі постачальників v1….vn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив більше 10 продуктів - статус  = "yes"
Якщо він купив менше 10 продуктів - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/
DISTINCT
customer_id int(15),
customer_name %customers.cust_name,
customer_status char(10)
begin
customer_id := '1000000001'
select
cust_id,
customer_name := cust_name,
sum (quantity) as cust_items
from
customers left join orders
on customers.cust_id = orders.cust_id
join orderitems
on orders.order_num = ordritems.order_num
group by customets.cust_id, customers.cust_name
where cust_id = customer_id
if (cust_items > 10) then
customer_status := 'yes'
else if (cust_items < 10) then
customer_status := 'no'
else if (cust_items == NULL) then 
customer_status := 'unknown'
end if
DBSN(customer_id,customer_name, customer_status)
end
/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести ім’я покупця та загальну кількість купленим ним товарів.
3.2. Вивести ім'я постачальника за загальну суму, на яку він продав своїх товарів.
6 балів.*/
VIEW CUST_ITEMS
(select 
cust_name,
cust_id,
vend_id,
vend_name,
sum(quantity) as cust_items,
sum(orderitems.quantity*orderitems.item_price) as vendor_debet
from
customers join orders
on customers.cust_id = orders.cust_id
join orderitems
on orders.order_num = orderitems.order_num
join products
on orderitems.prod_id = products.prod_id
join vendors
on products.vend_id = vendors.vend_id
group by customers.cust_id, customers.cust_name, vendors.vend_id, vendors.vend_name);

select
cust_name,
cust_items
from cust_items;

select
vend_name,
vend_name
from cust_items;
