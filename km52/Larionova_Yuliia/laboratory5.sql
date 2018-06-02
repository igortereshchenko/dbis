-- LABORATORY WORK 5
-- BY Larionova_Yuliia

1. Написати функцію, що повертає назву найдорожчого продукту у замовленні, за ключем замовлення.
create or replace function product_name(order_number IN number, prod_name OUT varchar2)
return varchar2
IS
    prod_name varchar2;
begin 
    select prod_name
    from products
    join orderitems on products.prod_id = orderitems.prod_id
    where orderitems.order_num = order_number
    and orderitems.item_price = (select max(item_price) 
                                from orderitems 
                                where order_num = order_number);
    return prod_name;
end;



2. Написати процедуру, що за назвою продукту повертає ім'я йогопостачальника, якщо операція неможлива процедура кидає exception.
create or replace procedure vendor_name(prod_name IN varchar2, vend_name OUT varchar2)
IS 
    vend_name varchar2;
begin
    select vend_name 
    from vendors
    join products on vendors.vend_id = products.vend_id
    where products.prod_name = prod_name;
    return vend_name
exception
    ;
end;
