-- LABORATORY WORK 5
-- BY Pototska_Iryna
/*1. Написать ф-цию, которая возвращает кол-во покупателей,
у которых пустые заказы и живут в стране , которая передается, как параметр*/
create or replace function count_of_customers
(c_country IN varchar2,  o_num IN number, count_of_customers OUT number) 
return number 
as
begin
select count(orders.order_num) into count_of_customers
from customers join orders 
on customers.cust_id=orders.cust_id
where customers.cust_country=c_country
and orders.order_num is NULL;

return count_of_customers;
END;

/*2. Написать процедуру, которая по e-mail и имени покупателя возвращает ключ, 
если операция невозможна, - exception */
create or replace procedure id_by_email_and_name 
(c_email IN customers.cust_email%type, c_name IN customers.cust_name%type,
c_id OUT customers.cust_id%type)
is
my_ex exception 
begin 
select customers.cust_id into c_id
from customers 
where customers.cust_email=c_email
and
customers.cust_name=c_name;

raise my_ex
when no_data_found
then
dbms_output.put_line ('Sorry, operation is impossible');
ENd;

/*3. Написать процедуру, которая добавляет покупателю новый заказ. */
create or replace procedure add_new_order (o_num in number, o_date in number, c_id in number)
is
my_ex exception 
begin 
insert into orders (order_num, order_date, cust_id)
values (o_num, o_date, c_id);
raise my_ex
when no_data_found
then 
dbms_output.put_line ('Sorry, operation is impossible. There is not such customer');
ENd;
