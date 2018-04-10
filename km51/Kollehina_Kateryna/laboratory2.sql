-- LABORATORY WORK 2
-- BY Kollehina_Kateryna
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, кількість його продуктів та загальну вартість проданих ним продуктів.

---------------------------------------------------------------------------*/
--Код відповідь:
 select vendors.vend_id,
        count( DISTINCT products.prod_id),
        sum(orderitems.order_price*orderitems.quantity)
        from orderitems
        join products
        on orderitems.prod_id=products.prod_id
         join vendors
        on vendors.vend_id=products.vend_id
        group by vendors.vend_id;










/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого містить найдешевший продукт.

---------------------------------------------------------------------------*/

--Код відповідь:
select customers.cust_id,
       orders.order_num
       from customers
        join orders
        on customers.cust_id=orders.cust_id
        join orderitems
        on orderitems.order_num=products.order_num
       group by customers.cust_id
       where orderitems.order_num
in( select
       min(item_price)
       from orderitems));
