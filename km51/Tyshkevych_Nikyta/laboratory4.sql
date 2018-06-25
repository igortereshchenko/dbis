-- LABORATORY WORK 4
-- BY Tyshkevych_Nikyta
--1
create FUNCTION get_prod_amount_by_name(order_key orderitems.order_num%TYPE) RETURN int as
 is
  amount int:=0;
  begin
    select count(orderitems.quantity) into amount from orderitems
    where orderitems.order_num=order_key;
    return amount;
  
  end get_prod_amount_by_name;


--2
create procedure get_cust_key_name_by_prod_name
(
  cust_key out VARCHAR2,
  cust_name out VARCHAR2,
  prod_name in VARSHAR2
  
  
) AS
begin
  
  select cust_id,cust_name into cust_key, cust_name from products 
  join orderitems on products.prod_id=orderitems.prod_id
  join orders on orderitems.order_num=orders.order_num
  join customers on orders.cust_id = customers.cust_id
  where produsts.prod_name = prod_name;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE ('Invalid Column: ' || emp_column);
    
end get_cust_key_name_by_prod_name;

--3
create procedure set_new_prod
(
  prod_id in varchar2,
  vend_id in varchar2,
  prod_name in varchar2,
  prod_price in number(5,2),
  counts number
) as
begin
  select count(prod_id) into counts from products where products.prod_id=prod_id;
  if counts=0 then
     INSERT INTO products VALUES (prod_id,vend_id,prod_name,prod_price) ;
  end if;
end set_new_prod;
  
