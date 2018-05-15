-- LABORATORY WORK 3

/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/
SET serverput ON
DECLARE
 vendor_id vendors.vend_id%TYPE := 'DLL01'
 vendor_name vendors.vend_name%TYPE: 
 status VARCHAR2(10)
 numder_of_prods int:
 begin
 select vend_name INTO vendor_namme FROM vendors
 dbms_output.put_line ( 'Vendor name-' ||  vendor_name)
 select count (prod) INTO numder_of_prods FROM Vendors:
 
 if (numder_of_prods=2) then
  status := 'yes'
 
 elsif (numder_of_prods>2) then
  status := 'no'
  
 elsif (numder_of_prods=0)hen
  status := 'unknown'
  
dbms_output.put_line ( 'Vendor name-' || status)
end

/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень було зроблено покупцями з Англії.
3.2. На яку загальну суму продали постачальники товари покупцям з Англії.
6 балів.*/
CREATE view as viewl
  
  select customers.cust_id count(orders.order_num) AS customers_order, customers.cust_country
  from cuctomers join orders ON Customers.cust_id = Orders.cust_id
  join OrderItems ON OrderItems.order_num = Orders.order_num
  group by customers.cust_ id, customers.cust_country:

SELECT sum (customers_order) customers.cust_country,
 FROM viewl
 WHERE customers.cust_country= 'ENGLISH'
 group by customers.cust_country:
 
 SELECT sum (orderItems.) customers.cust_country,
 FROM viewl
 WHERE customers.cust_country= 'ENGLISH'
 group by customers.cust_country:
 
-- BY Kolobaieva_Kateryna
