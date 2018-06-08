/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що не продав більше 2 продуктів різним покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:

Select distinct info.vend_id from 
    (Select vendors.vend_id, orders.cust_id, count(orderitems.prod_id) from 
            vendors join products on vendors.vend_id = products.vend_id 
                    join orderitems on products.prod_id = orderitems.prod_id
                    join orders on orderitems.order_num = orders.order_num
            group by vendors.vend_id,orders.cust_id
             having count(distinct orderitems.prod_id) <= 2)info;




/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має найдешевше замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:


select distinct info.vend_id from (

select  vendors.vend_id,orderitems.order_num, sum(orderitems.item_price) from 
        vendors join products on vendors.vend_id = products.vend_id 
                join orderitems on products.prod_id = orderitems.prod_id
            group by vendors.vend_id, orderitems.order_num
                having orderitems.item_price in ( )
                ) info;

