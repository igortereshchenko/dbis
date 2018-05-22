-- LABORATORY WORK 2
-- BY Chechel_Dmytrii
/*---------------------------------------------------------------------------
1. Вивести номери замовлення, кількість продуктів у замовленнях та кількість постачальників, що продавали продукт у замовлення.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT o.ORDER_NUM, SUM(o.QUANTITY), COUNT(p.VEND_ID) 
FROM Orderitems o 
INNER JOIN Products p ON o.PROD_ID = p.PROD_ID
GROUP BY o.ORDER_NUM;





/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, продукти якого містяться кільки у найдешевших замовленнях.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT v.VEND_ID 
FROM Vendors v 
INNER JOIN Products p 
ON v.VEND_ID = p.VEND_ID
INNER JOIN Orderitems o
ON p.PROD_ID = o.PROD_ID
WHERE
o.ITEM_PRICE*o.QUANTITY = (SELECT MIN(QUANTITY * ITEM_PRICE) FROM Orderitems);
