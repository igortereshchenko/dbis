-- LABORATORY WORK 3
-- BY Buchynska_Kateryna
/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/

set serveroutput on
declare
vendor_id vendors.vend_id%TYPE := 'BRS01' ;
begin










/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/


set serveroutput on
declare
vendor_id vendors.vend_id%TYPE := 'DLL01' ;
vendor_name vendors.vend_name%TYPE ;
status VARCHAR2 (10) ;
number_of_prods int ;
begin
SELECT vend_name INTO vendor_name FROM Vendors 
dbms_output.put_line ('Vendor name - ' || vendor_name ) 
SELECT COUNT (prod) INTO number_of_prods FROM Vendors 

if (number_of_prods =2) then
{
  status:= 'yes' 
}

elsif (number_of_prods > 2) then
{
  status:= 'no' 
}
elsif (number_of_prods = 0 ) then
{
  status:= 'unknown' 
}
end if;
dbms_output.put_line ('Vendor status - ' || status ) ; 
end;







/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень було зроблено покупцями з Англії.
3.2. На яку загальну суму продали постачальники товари покупцям з Англії.
6 балів.*/

CREATE view as  view1 

select customers.cust_id, count(orders.order_num) AS customers_order , customers.cust_country
from customers  join orders ON Customers.cust_id = Orders.cust_id
join OrderItems ON  OrderItems.order_num = Orders.order_num 
group by customers.cust_id ,  customers.cust_country ;

SELECT sum(customers_order), customers.cust_country
FROM view1
where customers.cust_country = 'USA'
group by  customers.cust_country ;


SELECT SUM(OrderItems.) customers.cust_country
FROM view1
where customers.cust_country = 'USA'
group by  customers.cust_country ;







