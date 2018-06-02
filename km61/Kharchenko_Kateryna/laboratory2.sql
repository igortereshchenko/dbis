-- LABORATORY WORK 2
-- BY Kharchenko_Katery
/*1.ивести назву продукту, ускількох замовленнях даний продукт продавався та 
скільки постачальників продають даний продукт */

SELECT
PROD_NAME, 
COUN(ORDER_NUM),
COUN(VEND_ID)
FROM ORDERITEMS JOIN PRODUCTS
ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
WHERE 
PRODUCTS.PROD_ID;

/*2 Вивести ключ постачальника, що мая три продуктиж, кожний з яких продався 
більше ніж трьома покупцями*/

SELECT
  PROD_ID
FROM ORDERS JOIN
          (SELECT
            PROD_ID
            VEND_ID
            ORDER_NUM
          FROM ORDERITEMS LEFT JOIN PRODUCTS
            ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
          WHERE COUN(PROD_ID) = 3) 
        ON ORDERS.ORDER_NUM = ORDER_NUM
WHERE COUN(CUSR_ID) > 3 
