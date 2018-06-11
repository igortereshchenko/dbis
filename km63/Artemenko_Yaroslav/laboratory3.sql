-- LABORATORY WORK 3
-- BY Artemenko_Yaroslav

/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

set serveroutput on
Declare 
  custID customers.cust_id%TYPE;
  custName customers.cust_name%TYPE;
  custstatus varchar2(10):='';
  ccount int:=0;
BEGIN
  custID := '1000000001';
  --select customers.cust_id, customers.cust_name, count(products.prod_id) into custID, custName, ccount
  --from customers join orders on customers.cust_id=orders.cust_id
  --  join orderitems on orders.order_num = orderitems.order_num
  --  join products on orderitems.prod_id=products.prod_id;
  select count(prod_id) into ccount
  from products;
  select cust_name into custName
  from customers
  group by cust_name;
  
  if (ccount=2) then custstatus:='yes';
  elsif (ccount > 2) then custstatus:='no';
  else custstatus:='unknown';
  end if;
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень було зроблено покупцями з Англії.
3.2. На яку загальну суму продали постачальники товари покупцям з Англії.
6 балів.*/

CREATE view number_sum_1 as 
SELECT customers.cust_id, vendors.vend_country, vendors.vend_id
From customers join orders on customers.cust_id=orders.cust_id
join orderitems on orders.order_num=orderitems.order_num
join products on orderitems.prod_id = products.prod_id
join vendors on products.vend_id = vendors.vend_id;

select count(vend_id)
from vendors
where VEND_COUNTRY='England';

select sum(prod_price)
from products, customers
where customers.cust_country='England';
