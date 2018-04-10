-- LABORATORY WORK 2
-- BY Chernetskyi_Valentyn
/*---------------------------------------------------------------------------
1. Вивести постачальників, що не продали жодного продукту та живуть в Америці.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT 
  DISTINCT 
  VENDORS.VEND_NAME,
  ORDERITEMS.PROD_ID,
  VENDORS.VEND_ID
FROM ( VENDORS JOIN PRODUCTS
  ON VENDORS.VEND_ID=PRODUCTS.PROD_ID 
  JOIN ORDERITEMS 
  ON PRODUCTS.PROD_ID=ORDERITEMS.PROD_ID )
WHERE ORDERITEMS.QUANTITY='0'
AND VENDORS.VEND_COUNTRY='USA'

/*---------------------------------------------------------------------------
2.  Вивести номер найдешевшого замовлення та кількість товарів у ньому.
---------------------------------------------------------------------------*/

--Код відповідь:

SELECT VENDORS.VEND_ID, 
  MIN(ORDERITEMS.ITEM_PRICE), 
  ORDERITEMS.QUANTITY
FROM VENDORS JOIN ORDERITEMS
  ON VENDORS.VEND_ID=ORDERITEMS.ORDER_NUM
GROUP BY VEND_ID
    
    
