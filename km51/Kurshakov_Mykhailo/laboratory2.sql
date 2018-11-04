-- LABORATORY WORK 2
-- BY Kurshakov_Mykhailo
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, кількість його продуктів та загальну вартість проданих ним продуктів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT info.Vend_id,
info.count_o,
info.count_price
FROM
(
SELECT VENDORS.vend_id,
  count(orderitems.order_num) as count_o,
  sum(Orderitems.ORDER_ITEM*Orderitems.ITEM_PRICE) as count_price
        
FROM  Orderitems JOIN Products
 on Products.prod_id = Orderitems.prod_id
 JOIN VENDORS
 on VENDORS.vend_id = Products.vend_id 
 group by VENDORS.vend_id
) info;




/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого містить найдешевший продукт.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT info.cust_id
FROM
(
SELECT
      customers.cust_id,
      Orderitems.ITEM_PRICE
        
FROM  Orders JOIN customers
 on customers.cust_id = Orders.cust_id
 JOIN Orderitems
 on Orderitems.ORDER_num = Orders.order_num
 GROUP BY customers.cust_id,Orderitems.ITEM_PRICE
 HAVING Orderitems.ITEM_PRICE = MIN(Orderitems.ITEM_PRICE)
 ) info;
