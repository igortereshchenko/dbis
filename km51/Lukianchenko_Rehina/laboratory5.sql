-- LABORATORY WORK 5
-- BY Lukianchenko_Rehina
create or replace function countPoducts(vendor_name vendors.vend_name%Type) RETURN number
is 

prod_count number;
begin 
    select count(prod_id) into prod_count
    from products join vendors
    on products.vend_id = vendors.vend_id
    where vend_name = vendor_name;
    RETURN  prod_count;
    end countPoducts;


create or replace procedure vendKey (vendor_address in vendors.vend_address%Type, key out vendors.vend_id%Type ) 
is 
    begin 
        select vendors.vend_id into key
        from vendors
        where vend_address = vendor_address;
    EXCEPTION
    when no_data_found then 
    RAISE_application_error (-20555, 'No found vendor`s key');
end vendKey;




create or replace procedure updateProductName (oldProdName in products.prod_name%Type,newProdName in products.prod_name%Type ) 
is 

count3 exception;
order_count number;
    begin 
    
    select count(distinct order_num) into  order_count
    from products join orderitems
    on products.prod_id = orderitems.prod_id
    where products.prod_name = oldProdName;
    
    if (order_count = 3 )then 
      raise  count3 ;
    ELSE
      update products SET prod_name = newProdName
      where prod_name = oldProdName;
    end if;
EXCEPTION
    when no_data_found then 
      RAISE_application_error (-20555, 'No found product');
    when count3 then 
      RAISE_application_error (-20556, 'Order count = 3');

end updateProductName;
