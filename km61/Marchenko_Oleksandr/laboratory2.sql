
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що не продав більше 2 продуктів різним покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:

/*
SELECT
  VENDORS.VEND_ID
FROM
  VENDORS
JOIN ORDERITEMS
ON VENDORS.VEND_ID = PRODUCTS.PROD_ID
*/

/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має найдешевше замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT
  ORDERITEMS.ORDER_NUM,
  ORDERITEMS.QUANTITY,
  ORDERITEMS.ITEM_PRICE
FROM
  ORDERITEMS;
/*
WHERE
  --ORDERITEMS.QUANTITY ORDERITEMS.ITEM_PRISE
AND MIN(ORDERITEMS.QUANTITY * ORDERITEMS.ITEM_PRISE);
*/
