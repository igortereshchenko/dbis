-- LABORATORY WORK 5
-- BY Bondar_Liliia

create function not_empty_orders(customer_id in varchar2)
    return number
is
    order_count number;
begin
    select count(*) from Orders
    join OrderItems on Orders.ORDER_NUM = OrderItems.ORDER_NUM
    join Customers on Customers.CUST_ID = Orders.CUST_ID
    where Orders.CUST_ID = customer_id;

    return order_count;
end;


create procedure customer_name_by_id(customer_name in varchar2, customer_id out varchr2)
is
begin
    select cust_id into customer_id from Customers
    where cust_name = customer_name;

    if cust_id = '' then
        raise_application_error('Error');
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
    

    select count(*) into order_item_count
    from Orders
    join OrderItems on OrderItems.ORDER_NUM = Orders.ORDER_NUM
    where order_num = in_order_num;
    
    if order_count = 0 or order_item_count > 0 then
        raise_application_error('Error');
    end if;
    
    update orders
    set order_date = input_order_date
    where order_num = in_order_num;
end;
