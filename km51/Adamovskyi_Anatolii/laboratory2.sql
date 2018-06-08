-- LABORATORY WORK 2
-- BY Adamovskyi_Anatolii
/*---------------------------------------------------------------------------
1. Вивести ключ постачальника, кількість його продуктів та загальну вартість проданих ним продуктів.

---------------------------------------------------------------------------*/

SELECT 
  PRODUCTS.vend_id,
  COUNT(DISTINCT(PRODUCTS.prod_id)) prod_count,
  NVL(SUM(ORDERITEMS.quantity * ORDERITEMS.item_price),0) sum_all_orders
FROM 
  PRODUCTS LEFT JOIN ORDERITEMS
    ON PRODUCTS.prod_id = ORDERITEMS.prod_id
GROUP BY
  PRODUCTS.vend_id;

/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, замовлення якого містить найдешевший продукт.

---------------------------------------------------------------------------*/

SELECT 
  DISTINCT(ORDERS.CUST_ID)
FROM
  ORDERS JOIN ORDERITEMS
    ON ORDERS.order_num = ORDERITEMS.order_num
  JOIN PRODUCTS
    ON PRODUCTS.prod_id = ORDERITEMS.prod_id
WHERE 
  PRODUCTS.prod_price = (
    SELECT 
      MIN(prod_price)
    FROM
      PRODUCTS
  );
