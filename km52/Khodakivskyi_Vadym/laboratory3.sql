-- LABORATORY WORK 3
-- BY Khodakivskyi_Vadym
/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 7. Ключі постачальників v1….vn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/

set serveroutput on;
DECLARE
vend_n VENDORS.VEND_NAME%Type := "Bears R Us";
vend_idn VENDORS.VEND_id%Type := "v";
iter integer;
vend_count integer;
begin
  for iter in 1..7
  loop
  select COUNT(*) into vend_count FROM VENDORS;
  if (vend_count = 7) then exit;
  else
    insert into vendors (VEND_id, VEND_NAME)
    values (vend_idn, vend_n||iter);
  end if;
  end loop;
end;


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ключ та визначає  його статус.
Якщо він зробив 3 замовлення - статус  = "3"
Якщо він не зробив 3 замовлення - статус  = "no 3"
Якщо він немає замовлення - статус  = "unknown*/


--declare
--begin

--end;

/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень було зроблено покупцями з Германії.
3.2. Вивести назву продукту, що продавався більше ніж у 3 різних замовленнях.
6 балів.*/

create view orders_prods as select
  products.prod_name,
  orderitems.order_num,
  orders.CUST_ID
  from orders left join orderitems
  on orderitems.order_num = orders.ORDER_NUM
  join products
  on products.prod_id = orderitems.PROD_ID;


select customers.cust_id, count(order_num)
from customers left join orders_prod
on customers.cust_id = cust_id
where customers.CUST_COUNTRY = 'germany'
group by customers.cust_id;

select trim(prod_name), count(order_num)
from orders_prods
group by prod_name
having count(order_num)>3;
