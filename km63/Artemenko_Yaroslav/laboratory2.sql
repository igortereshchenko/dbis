-- LABORATORY WORK 2
-- BY Artemenko_Yaroslav

/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту, за умови, що покупець ніколи не купляв даний продукт.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT Customers.cust_id, Products.prod_id
FROM Customers, Products

MINUS 

SELECT Customers.cust_id, Products.prod_id
FROM Customers 
JOIN Orders 
ON (Customers .cust_id = Orders .cust_id)
JOIN ORDERITEMS
ON (Orders.order_num = ORDERITEMS.order_num)
JOIN Products
ON (ORDERITEMS.prod_id = Products.prod_id);










/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, що працював з покупцем, що має найдорожче замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:                                                      

SELECT vendors.vend_id, max(OrderItems.quantity*OrderItems.item_price) as max_price 
FROM OrderItems
JOIN Products 
ON (OrderItems.prod_id = Products.prod_id)
JOIN Vendors
ON (Products.vend_id = Vendors.vend_id)
group by vendors.vend_id;



