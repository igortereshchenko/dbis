-- LABORATORY WORK 3
-- BY Milevska_Olha

/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

declare
 cust_id varchar(20) :=";
 cust_name varchar(50) :=";
 items_count int :=0;
begin
 select cust_id,cust_name,
 count(distinct cust_id)
 into cust_id,cust_name,items_count
 from customers
 left join orders
 on customers.cust_id = orders.cust_id;
 group by cust_id, cust_name;
 if items_count:=2 then 
  dbms_output.print_line("yes");
 elsif items_count>2 then 
  dbms_output.print_line("no");
 elsif items_count:=0 then 
  dbms_output.print_line("unknown");
 else
  dbms_output.print_line("error");
 end if;
  dbms_output.print_line("cust_id");
end;

 


/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки продуктів було замовлено покупцями з Германії.
3.2. Вивести назву продукту та у скількох замовленнях його купляли.
6 балів.*/

create view cust_prod as 

select count(prod_id),
customers.cust_id,customers.cust_country
from customers join orders on customers.cust_id = orders.cust_id
where cust_country = 'germany'
group by prod_id;

select prod_name,
count(orderitems.prod_id)
from products join orderitems on products.prod_id = orderitems.prod_id
group by products.prod_name;

