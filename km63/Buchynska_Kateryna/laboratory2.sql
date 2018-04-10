-- LABORATORY WORK 2
-- BY Buchynska_Kateryna
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ постачальника, за умови, що постачальник не продавав жодного продукту цьому покупцю.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT cust_id, vend_id, COUNT(prod_id)
FROM
(
SELECT cust_id, vend_id, COUNT(prod_id) FROM
Products JOIN OrderItems ON Products.prod_id=OrderItems.prod_id
JOIN Orders ON Orders.order_num = OrderItems.order_num
GROUP BY cust_id, vend_id
HAVING COUNT(prod_id)=0 
);


/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що купляв по 4 різних товари в рамках одного замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:
/*1) 4 різних товари в рамках одного замовлення*/

SELECT order_num, COUNT(DISTINCT prod_id)
FROM OrderItems 
GROUP BY order_num
HAVING COUNT(DISTINCT prod_id) = 4;

/*2) виводимо звідси ключ покупця*/
SELECT INFO.cust_id
FROM
(
SELECT order_num, cust_id, COUNT(prod_id)
FROM OrderItems JOIN Orders ON Orders.order_num= OrderItems.order_num 
GROUP BY order_num, cust_id
HAVING COUNT(prod_id) = 4
) INFO ;





