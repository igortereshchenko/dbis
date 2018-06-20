-- LABORATORY WORK 2
-- BY Haleta_Maksym
/*---------------------------------------------------------------------------
1. Вивести ключ продукту, у скількох замовленнях даний продукт продавався та скільком покупцям

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT
  PRODUCTS.prod_id,
  COUNT(DISTINCT ORDERITEMS.order_num) AS count_order_num,
  COUNT(DISTINCT CUSTOMERS.cust_name) AS count_cust_name
FROM
  PRODUCTS JOIN ORDERITEMS
  ON PRODUCTS.prod_id = ORDERITEMS.prod_id
  JOIN ORDERS
  ON ORDERITEMS.order_num = ORDERS.order_num
  JOIN CUSTOMERS
  ON ORDERS.cust_id = CUSTOMERS.cust_id
GROUP BY PRODUCTS.prod_id;


/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, продукти якого містяться тільки у 4 замовленнях.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT
  info.vend_id
FROM
(
  SELECT
    VENDORS.vend_id,
    COUNT(DISTINCT ORDERITEMS.order_num) AS count_order_num
  FROM
    VENDORS JOIN PRODUCTS
    ON VENDORS.vend_id = PRODUCTS.vend_id
    JOIN ORDERITEMS
    ON PRODUCTS.prod_id = ORDERITEMS.prod_id
  GROUP BY VENDORS.vend_id
  HAVING COUNT(DISTINCT ORDERITEMS.order_num) = 4
)info
