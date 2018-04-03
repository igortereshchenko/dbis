-- LABORATORY WORK 2
-- BY Servatmand_Mariam

/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що не продав більше 2 продуктів різним покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT 
vendors.vend_id
minus 
select(
vendors.vend_id
join vendors 
join products
on vendors.vend_id=products.vend_id and products.prod_id=OrderItems.prod_id
having count(orderItems.order_item)>=2
)






/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має найдешевше замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT 
customers.cust_id,

JOIN ORDERS 
IN orders.cust_id=customers_cust_id 
JOIN OrderItems 
orders.order_num=orderItems.order_num 
JOIN CUSTOMERS
where customers.cust_id=orders.cust_id
and item_price=min







