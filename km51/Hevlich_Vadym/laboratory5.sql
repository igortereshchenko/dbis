-- LABORATORY WORK 5
-- BY Hevlich_Vadym

create function get_not_empty_orders(customer_id in varchar2)
    return number
    is
        orders_count number;
    begin
        select count(*) from Orders
        join OrderItems on ORDERS.ORDER_NUM = OrderItems.ORDER_NUM
        join Customers on Customers.CUST_ID = Orders.CUST_ID
        where Orders.CUST_ID = customer_id;
    
    return orders_count;
end;


create procedure get_customer_name_by_id(customer_name in varchar2, customer_id out varchr2)
    is
    begin
        select cust_id into customer_id from Customers
        where cust_name = customer_name;
        
        if cust_id = '' then
            raise_application_error('Operation is not possible');
        end if;
end;


create procedure update_order_date(in_order_num in varchar2, in_order_date in date)
    is
        order_count number;
        order_item_count number;
    begin
        select count(*) into order_count
        from Orders
        where order_num = in_order_num;
        
        if order_item_count = 0 then
            raise_application_error('Operation is not possible');
        end if;     
    
        select count(*) into order_item_count
        from Orders
        join OrderItems on OrderItems.ORDER_NUM = Orders.ORDER_NUM
        where order_num = in_order_num;
        
        if order_item_count > 0 then
            raise_application_error('Operation is not possible');
        end if;
        
        update orders
        set order_date = input_order_date
        where order_num = in_order_num;
end;
