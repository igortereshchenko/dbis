-- LABORATORY WORK 2
-- BY Trishyna_Anna
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що не продав більше 2 продуктів різним покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:


SELECT DISTINICT INFO.VEND_ID
FROM PRODUCTS
JOIN ORDERITEMS ON PRODUCTS.PROD_ID=PRODUCTS.VEND_ID
JOIN ORDERITEMS ON PRODUCTS.ITEM_PRICE=PRODUCTS.PROD_PRICE
WHERE PRODUCTS.PROD_ID
 








/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має найдешевше замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT DISTINICT MIN(INFO.PROD_PRICE)
FROM ORDERITEMS
JOIN PRODUCTS ON ORDERITEMS.PROD_ID=ORDERITEMS.VEND_ID
JOIN PRODUCTS ON ORDERITEMS.ITEM_PRICE=ORDERITEMS.PROD_PRICE
