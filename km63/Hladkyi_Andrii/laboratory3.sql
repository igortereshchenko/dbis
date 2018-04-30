-- LABORATORY WORK 3
-- BY Hladkyi_Andrii

/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників
була 10. Ключі замовників test1….testn. 
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/





/*2. Написати PL/SQL код, що по вказаному ключу постачальника
виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/

declare
      vend_id char(10) :='';
      vend_name char(50) :='';
      prod_price number(10) :=0;
      
BEGIN
  DBMS_OUTPUT.PUT_LINE(vend_name);
  if prod_price = min(prod_price) 
  then
  DBMS_OUTPUT.PUT_LINE('yes');
  if prod_price = max(prod_price)
  then
  dbms_output.put_line('NO');
  if prod_price = NULL
  then
  dbms_output_putline('unknown');
  end if;
  
end;
  
  
    
/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають
в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/

create view vendors_customers as
  select
  Customers.cust_name
