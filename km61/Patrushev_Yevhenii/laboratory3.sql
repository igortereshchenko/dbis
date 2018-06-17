-- LABORATORY WORK 3
-- BY Patrushev_Yevhenii
/*1. Ќаписати PL/SQL код, що по вказаному ключу покупцЯ дода№ в його замовленнЯ, що було зроблено першим будь-Який продукт 10 разґв, змґнюючи order_item у циклґ.
ЋперацґЯ викону№тьсЯ, Якщо у даному замовленнґ вже № хочаб один товар. 10 балґв*/

declare
    cust_id customers.cust_id%TYPE;
    order_num ORDERS.ORDER_NUM%type;
    count_loop integer := 10;
    last_orderitem  orderitems.order_item%type;
begin
    cust_id := '1000000001';
    
    select orders.order_num
    into order_num
    from orders join customers
    on orders.cust_id = customers.cust_id
    where customers.cust_id = cust_id
    order by orders.order_date;
    
    select max(orderitems.order_item)
    into last_orderitem
    from orderitems
    where orderitems.order_num = order_num
    group by orderitems.order_num;
    
    if last_orderitem is not Null then
    
    for i in 1..count_loop loop
        insert into orderitems (orderitems.order_num,orderitems.order_item,orderitems.prod_id,orderitems.quantity,item_price)
        values (order_num,last_orderitem + i, 'BR01' , 1, 1);
    end loop;
    end if;
    
end;


/*2. Ќаписати PL/SQL код, що по вказаному ключу продукту виводить у консоль його назму та изнача№  його статус.
џкщо продукт не прода№тьсЯ  - статус  = "poor"
џкщо продукт продано до 2 рґзних замовлень включно - статус  = "common"
џкщо продукт продано бґльше нґж у 2 замовленнЯ - статус  = "rich" 4 бали*/

/*3. ‘творити предсавленнЯ та використати його у двох запитах:
3.1. ‚ивести ґм'Я постачальника та номер замовленнЯ, куди не прода№ постачальник сво» продукти.
3.2. ‚ивести ґм'Я постачальника та загальну кґлькґсть замовлень, куди постачальник продавам сво» продукти 6 балґв.*/

create view vend_orders as
select orderitems.order_num, products.prod_id, vendors.vend_id, vendors.vend_name
from orderitems join products
on orderitems.prod_id = products.prod_id
join vendors
on vendors.vend_id = products.vend_id;

select vendors.vend_name, orderitems.order_num
from vendors,orderitems,products
where products.vend_id = vendors.vend_id
minus
select vend_orders.vend_name, vend_orders.order_num
from vend_orders;


select vend_orders.vend_name, vend_orders.order_num
from vend_orders
group by vend_orders.vend_name, vend_orders.order_num;
