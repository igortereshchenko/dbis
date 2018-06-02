-- LABORATORY WORK 5
-- BY Ostapenko_Kostiantyn
Create  function count_prodect (vend_name_id in varchar2)
    return number
    is 
        count_order_number number;
    begin
        select count(prod_id ) from OrderItems
        join vendors on vendors.vend_id = products.prod_id
        join products on products.prod_id=Orderitems.Order_Num
        where Vendors.Vend_Id=Prod_id;
    return count_order_numbe;

end;
    
    
    
create procedure get_vendors_name_by_id (vendor_name in varchar2; vendor_id out varchar2)
    is 
    begin
        select vend_id into vendor_id from Vendors;
        where vend_name=vendor_name;
        
        if vend_id=''then
            raise_application_error('exception');
        end if;
        
end;

create procedure update_price_prod (in_prod_num in varchar2, in_order_price in decimal(8,2)
    is 
        cou

    
