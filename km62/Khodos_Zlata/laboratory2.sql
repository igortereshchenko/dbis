-- LABORATORY WORK 2
-- BY Khodos_Zlata
/*---------------------------------------------------------------------------
1. Вивести номери замовлення, кількість продуктів у замовленнях та кількість постачальників, що продавали продукт у замовлення.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT ORDERITEMS.ORDER_NUM, COUNT(ORDER_ITEM), COUNT(DISTINCT VENDORS.VEND_ID)
FROM ORDERITEMS JOIN PRODUCTS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
JOIN VENDORS ON PRODUCTS.VEND_ID = VENDORS.VEND_ID
GROUP BY ORDERITEMS.ORDER_NUM
ORDER BY ORDERITEMS.ORDER_NUM;
/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, продукти якого містяться кільки у найдешевших замовленнях.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT MIN(INFO.MINIMUM_PRICE) AS MINIMUM_ORDER_PRICE
FROM
      (
      SELECT ORDER_NUM, MIN(PRICE) AS MINIMUM_PRICE
      FROM (
            SELECT ORDER_NUM, SUM(QUANTITY*ITEM_PRICE) AS PRICE
            FROM ORDERITEMS
            GROUP BY ORDER_NUM)
      GROUP BY ORDER_NUM
      ) INFO
;
