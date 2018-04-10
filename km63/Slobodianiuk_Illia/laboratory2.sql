-- LABORATORY WORK 2
-- BY Slobodianiuk_Illia
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ постачальника, за умови, що постачальник не продавав жодного продукту цьому покупцю.
---------------------------------------------------------------------------*/
--Код відповідь:
SELECT CUST_ID,
  VEND_ID
FROM CUSTOMERS, VENDORS
(VENDORS
  (SELECT CUST_ID
  FROM CUSTOMERS,
    ORDERS
  JOIN CUSTOMERS,
    ORDERS
  ON CUSTOMERS.CUST_ID=ORDERS.CUST_ID
  WHERE (SELECT CUST_ID
    FROM ORDERS,
      ORDERITEMS
    JOIN ORDERS,
      ORDERITEMS
    ON ORDERS.ORDER_NUM=ORDERITEMS.ORDERNUM
    WHERE (SELECT PROD_ID
      FROM ORDERITEMS,
        PRODUCTS
      JOIN ORDERITEMS,
        PRODUCTS
      ON ORDERITEMS.PROD_ID=PRODUCTS.PROD_ID
      WHERE (SELECT VEND_ID
        FROM PRODUCTS,
          VENDORS
        JOIN PRODUCTS,
          VENDORS
        ON PRODUCTS.VEND_ID=VENDORS.VEND_ID
        WHERE ))))
        
        
        
/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що купляв по 4 різних товари в рамках одного замовлення.
---------------------------------------------------------------------------*/
--Код відповідь:
      SELECT CUST_ID
        (SELECT CUST_ID,
          QUANTITY
        FROM ORDERS,
          ORDERITEMS
        JOIN
        ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
        WHERE QUANTITY    >= 4
        ) AS CUSTQUANT
      FROM CUSTOMERS,
        CUSTQUANT
      JOIN CUSTQUANT,
        CUSTOMERS
      ON CUSTOMERS.CUST_ID      =CUSTQUANT.CUST_ID
      WHERE CUSTCUANT.QUANTITY >= 4
