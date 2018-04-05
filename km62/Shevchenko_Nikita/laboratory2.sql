/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, що продав лише по одному продукту і тільки 3 покупцям.
---------------------------------------------------------------------------*/
--Код відповідь:
/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого не найдорожче.
---------------------------------------------------------------------------*/
--Код відповідь:
--SELECT VENDORS.VEND_ID, ORDERITEMS.ORDER_NUM,
  --MAX(ORDERITEMS.QUANTITY * ORDERITEMS.ITEM_PRICE) AS ORDER_SUM
--FROM ORDERITEMS
--JOIN PRODUCTS
--ON (ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID)
--JOIN VENDORS
--ON (PRODUCTS.VEND_ID = VENDORS.VEND_ID)
--GROUP BY VENDORS.VEND_ID, ORDERITEMS.ORDER_NUM;
SELECT ORDERITEMS.ORDER_NUM,
  SUM(ORDERITEMS.QUANTITY * ORDERITEMS.ITEM_PRICE) AS ORDER_SUM
FROM ORDERITEMS
WHERE ORDER_SUM != (
SELECT
  MAX(ORDER_SUM)
FROM
  (SELECT ORDERITEMS.ORDER_NUM AS ORD_NUM,
    SUM(ORDERITEMS.QUANTITY * ORDERITEMS.ITEM_PRICE) AS ORDER_SUM
  FROM ORDERITEMS
  )) group by ORDERITEMS.ORDER_NUM;
