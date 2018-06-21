-- LABORATORY WORK 2
-- BY Antiushyn_Yaroslav
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту, за умови, що покупець ніколи не купляв даний продукт.

---------------------------------------------------------------------------*/
--Код відповідь:


  








/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, що працював з покупцем, що має найдорожче замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT info.cust_id
FROM
(
SELECT
      customers.cust_id
   
FROM Orders JOIN customers
 ON customers.cust_id = Orders.cust_id
 JOIN Orderitems
 ON Orderitems.ORDER_num = Orders.order_num
 GROUP BY customers.cust_id,Orderitems.ITEM_PRICE
 HAVING Orderitems.ITEM_PRICE = MIN(Orderitems.ITEM_PRICE)
 ) info
