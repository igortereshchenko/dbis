-- LABORATORY WORK 5
-- BY Patrushev_Yevhenii
create or replace Function count_products(num orders.order_num%type)
return int
as count_prod number(3);
begin
    select count(distinct(prod_id)) into count_prod
    from Orderitems
    where order_num = num;
    return count_prod;
end count_products;


create or replace PROCEDURE insert_cust(insert_id in customers.cust_id%type, insert_name in customers.cust_name%type)
is 
    count_cust number(3);
    my_error exception;
begin

    select count(*) into count_cust
    from customers
    where cust_name = insert_name;
    
    if (count_cust = 0) then
        insert into customers(cust_id, cust_name) values (insert_id, insert_name);
    else 
        raise my_error;
    end if;
end  insert_cust;

create or replace procedure insert_product(product_id in products.prod_id%type, vendors_id in vendors.vend_id%type, product_name in products.prod_name%type)
is 
    count_vend number(3);
    count_prod_name number(3);
    my_error exception;
begin
    select count(*) into count_vend
    from vendors
    where vend_id = vendors_id;
    
    select count(*) into count_prod_name
    from orderitems join products
    on products.prod_id = oredritems.prod_id
    where products.prod_name = product_name;
    
    if (count_vend != 0 and count_prod_name = 0) then
        insert into products(prod_id, vend_id, prod_name) VALUES (vendors_id, product_id, product_name);
    else
        raise my_error;
    end if;
end insert_product;
