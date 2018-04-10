-- LABORATORY WORK 2
-- BY Horodniuk_Serhii

/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, кількість його продуктів та загальну вартість проданих ним продуктів.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT vendors.vend_id, products.prod_id, products.prod_price
FROM PRODUCTS JOIN VENDORS
  ON PRODUCTS.VEND_ID = VENDORS.VEND_ID
GROUP BY VENDORS.VEND_ID, PRODUCTS.PROD_ID, PRODUCTS.PROD_PRICE
HAVING PRODUCTS.PROD_ID = COUNT(PRODUCTS.PROD_ID) AND
PRODUCTS.PROD_PRICE = SUM(PRODUCTS.PROD_PRICE);



/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого містить найдешевший продукт.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT CUSTOMERS.CUST_ID
FROM CUSTOMERS JOIN ORDERS
  ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
  JOIN ORDERITEMS 
  ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
  JOIN PRODUCTS
  ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
WHERE PRODUSTS.PROD_PRICE = MIN(PRODUCTS.PROD_PRICE);
