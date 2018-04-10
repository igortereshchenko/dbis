-- LABORATORY WORK 2
-- BY Mitrokhin_Oleksii
/*---------------------------------------------------------------------------
1. Вивести постачальників, що не продали жодного продукту та живуть в Америці.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT
VENDORS.VEND_ID
FROM
VENDORS
WHERE VENDORS.VEND_COUNTRY = 'USA'
MINUS
SELECT DISTINCT
VENDORS.VEND_ID
FROM
VENDORS JOIN PRODUCTS
ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
JOIN ORDERITEMS
ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID











/*---------------------------------------------------------------------------
2.  Вивести номер найдешевшого замовлення та кількість товарів у ньому.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT 
ORDERITEMS.ORDER_NUM,
SUM(ORDERITEMS.QUANTITY) AS TOTAL_ORDER_ITEMS_QUANTITY
FROM
ORDERITEMS
GROUP BY ORDERITEMS.ORDER_NUM
HAVING MIN(TOTAL_QUANTITY) IN
(SELECT
ORDERITEMS.ORDER_NUM,
SUM(ORDERITEMS.QUANTITY*ORDERITEMS.ITEM_PRICE) AS TOTAL_QUANTITY
FROM
ORDERITEMS
GROUP BY ORDERITEMS.ORDER_NUM))





