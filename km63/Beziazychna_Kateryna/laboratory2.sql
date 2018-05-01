-- LABORATORY WORK 2
-- BY Beziazychna_Kateryna
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ постачальника, за умови, що постачальник не продавав жодного продукту цьому покупцю.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT vendors.vend_id,customers.cust_id
FROM CUSTOMERS JOIN ORDERS
ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
WHERE VENDORS.VEND_ID = IN
(SELECT vendors.vend_id
FROM VENDORS
WHERE vendors.vend_id = products.vend_id
MINUS
SELECT vendors.vend_id
FROM VENDORS JOIN PRODUCTS
ON vendors.vend_id = products.vend_id
JOIN ORDERITEMS
ON orderitems.prod_id=products.prod_id);

/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що купляв по 4 різних товари в рамках одного замовлення.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT CUSTOMERS_CUST_ID
FROM CUSTOMERS JOIN ORDERS
ON CUTOMERS.CUST_ID=ORDERS.CUST_ID
JOIN ORDERITEMS
ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
JOIN ORDERITEMS
ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
JOIN PRODUCTS
ON ORDERITEMS.PROD_ID=PRODUCTS.PROD_ID
JOIN VENDORS 
ON PRODUCTS.VEND_ID=VENDORS.VEND_ID
WHERE COUNT(ORDERITEMS.ORDER_ITEM)=4;






