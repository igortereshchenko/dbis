create or replace procedure update_name(name in PRODUCTS.PROD_NAME%type)
as
prod_sell_count int;
check_prod_exist int;
my_exception exception;
begin
select count(*) into check_prod_exist from products where prod_name = name;
if check_prod_exist = 0 then
    raise my_exception;
end if;
select count(*) into prod_sell_count from products jeft join orderitems using(prod_id) join orders using(order_num) where prod_name = name;
if prod_sell_count = 3 then
    raise my_exception;
end if;
update products
set prod_name = name
where prod_name = name;
exception
when my_exception then
raise_application_error(-20001,'Don`t exist product or sold 3 orders');
when others then
raise_application_error(-20002,'error');
end update_name;

create or replace procedure find_key(key out VENDORS.VEND_ID%type, adress in VENDORS.VEND_ADDRESS%type)
as
my_exception exception;
check_vend_exist int;
begin
select count(*) into check_vend_exist from vendors where vend_address = adress;
if check_vend_exist = 0 then
    raise my_exception;
end if;
select vend_id into key from vendors where vend_address = adress;
exception
when my_exception then
raise_application_error(-20001,'Vendor don`t exist');
when others then
raise_application_error(-20002,'error');
end find_key;




create or replace function products_count(vendor_name in vendors.vend_name%type)
    return int
    as
    all_products_count int;
    begin
    select count(*) into all_products_count from vendors left join products using(vend_id) where vend_name = vendor_name;
    return all_products_count;
    end products_count;
