/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників була 10. Ключі замовників test1….testn. 
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/









/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/








/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/
create view myview as
select 
     vendors.vend_id,
     vendors.vend_country,
     customers.cust_name,
     orderitems.quantity
     from
     customers
     join orders on customers.cust_id=orders.cust_id
     join orderitems on orders.order_num=orderitems.order_num
     join products on orderitems.prod_id=products.prod_id
     join vendors on products.vend_id=vendors.vend_id;
     
     
     select sum(quantity) as sum_quantity from 
     (select count(quantity) as c_quantity,
     vend_id from myview
     where vend_country='Germany');
     
     select 
     cust_name, sum(quantity)
     from myview;
