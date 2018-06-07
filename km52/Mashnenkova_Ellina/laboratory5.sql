-- LABORATORY WORK 5
-- BY Mashnenkova_Ellina
create or replace function not_empty_orders( customer_id IN varchar2 )
return number
is
  orders_count number;
begin
  select count(*)
  into orders_count
  from orders
    inner join orderitems on orderitems.order_num = orders.order_num
    inner join customers on customers.cust_id = orders.cust_id
  where orders.cust_id = customer_id;

  return orders_count;
end;

create or replace procedure find_customer_id_by_name(customer_name in varchar2, customer_id out varchar2)
is
begin
  select cust_id
  into customer_id
  from customers
  where cust_name = customer_name;
end;

create or replace procedure update_order_date(in_order_num in varchar2, in_order_date in date)
is
  orders_count number;
  orderitems_count number;
begin
  select count(*)
  into orders_count
  from orders
  where order_num = in_order_num;
  
  if orders_count = 0 then
    raise_application_error('Order not found');
  end;

  select count(*)
  into orderitems_count
  from orders
  inner join orderitems on orderitems.order_num = orders.order_num
  where order_num = in_order_num;
  
  if orderitems_count > 0 then
    raise_application_error('Order has orderitems');
  end;
  
  update orders
  set order_data = input_order_date
  where order_num = in_order_num;
end;
