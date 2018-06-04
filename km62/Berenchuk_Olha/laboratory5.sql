-- LABORATORY WORK 5
-- BY Berenchuk_Olha
CREATE FUNCTION coun_order(numb_prod integer) 
RETURN INT
AS
    product_count INT;
begin
    select 
    count(product.prod_id) into product_count
    from
    Products right join orderitems on
    Products.prod_id = orderitems.prod_id 
    right join orders on
    orderitems.Order_num = ORDERS.Order_num
    right join customers on
    orders.cust_id=customers.cust_id
    where distance(product.prod_id);
    
    return numb_prod;
end coun_order;

CREATE procedure count_cust(name_product in products.prod_name, cust_order out orders.cust_id)
is 
name_product products.prod_name.%type,
cust_order orders.cust_id.%type
begin
select products.prod_name into name_product
from

exception when NO_data_found then dbms_output.put_line('can not procedure');
end count_cust;

declare
begin  exception count_cust(prod_name => name_product, cust_id => cust_order ) 
end;
