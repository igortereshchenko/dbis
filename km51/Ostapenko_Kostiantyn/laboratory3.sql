-- LABORATORY WORK 3
-- BY Ostapenko_Kostiantyn
/*1*/
declare
  count_i:=10,
  custr_id:='c'
  ordr_num:='ord'
  
BEGIN 
  for i 1..count_i Loop; 
    INTO (customers.cust_id )
    VALUE(custr_id || i);
    INTO (ORDERS.order_num, orders.order_date, orders.cust_id)
    value(ordr_num || i,  custr_id || i );
  end loop;
end;
/*2*/
BEGIN 
select  count(*) into orders.orders_num
inner join on


  

/*3*/
CREATE VIEW customers_orders_vendors AS
SELECT customers.cust_id,
  customers.cust_country,
  orders.order_num,
  vendors.vend_id,
  vendors.vend_name,
  vendors.vend_country
FROM customers
INNER JOIN orders
ON customers.cust_id = orders.cust_id
INNER JOIN orderitems
ON orders.order_num = orderitems.order_num
INNER JOIN products
ON products.prod_id = orderitems.prod_id
INNER JOIN vendors
ON vendors.vend_id = products.vend_id;
SELECT order_num,
  COUNT(*)
FROM customers_orders_vendors

GROUP BY order_num;
SELECT 
  vend_name,
  order_num
FROM customers_orders_vendors
GROUP BY 
  vend_name, 
