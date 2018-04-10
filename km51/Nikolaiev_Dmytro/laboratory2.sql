-- LABORATORY WORK 2
-- BY Nikolaiev_Dmytro
/*---------------------------------------------------------------------------
1. Вивести ключ покупця, кількість його замовлень та загальну вартість куплених ним товарів.

---------------------------------------------------------------------------*/
--Код відповідь:


Select cust_id, Count(order_num), sum(quantity*item_price)
FROM ORDERS JOIN ORDERITEMS
ON ORDERITEMS.ORDER_NUM=ORDERS.ORDER_NUM
JOIN CUSTOMERS ON ORDERS.CUST_ID=CUSTOMERS.CUST_ID
JOIN PRODUCTS ON PRODUCTS.prod_id=ORDERITEMS.PROD_ID;
GROUP BY cust_id








/*---------------------------------------------------------------------------
2.  Вивести ключ продукту, що міститься у найдешевших замовленнях покупців, що проживають в Америці.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT prod_id 
FROM PRODUCTS JOIN ORDERS
ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
JOIN ORDERITEMS ON PRODUCTS.PROD_ID=ORDERITEMS.PROD_ID
JOIN CUSTOMERS ON CUSTOMERS.CUST_ID=ORDERITEMS.CUST_ID
GROUP BY prod_id;
HAVING ORDERITEMS.ITEM_PRICE=min(ORDERITEMS.ITEM_PRICE) AND CUSTOMERS.CUST_COUNTRY='USA';
