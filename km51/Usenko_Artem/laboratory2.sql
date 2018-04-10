-- LABORATORY WORK 2
-- BY Usenko_Artem
/*---------------------------------------------------------------------------
1. Вивести ключ покупця, кількість його замовлень та загальну вартість куплених ним товарів.

---------------------------------------------------------------------------*/
--Код відповідь:


Select CUSTOMERS.CUST_ID, COUNT(ORDERITEMS.ORDER_NUM) ,nvl(SUM(ORDERITEMS.item_price*ORDERITEMS.quantity),0)

FROM 
    ORDERS    RIGHT JOIN CUSTOMERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
              LEFT JOIN ORDERITEMS ON ORDERS.order_num = ORDERITEMS.ORDER_NUM
 GROUP BY  CUSTOMERS.CUST_ID;



/*---------------------------------------------------------------------------
2.  Вивести ключ продукту, що міститься у найдешевших замовленнях покупців, що проживають в Америці.

---------------------------------------------------------------------------*/

--Код відповідь:

Select ORDERITEMS.prod_id ,  SUM(ORDERITEMS.item_price*ORDERITEMS.quantity) 
FROM 
      ORDERITEMS  JOIN ORDERS ON ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM
                  JOIN CUSTOMERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID AND CUSTOMERS.CUST_COUNTRY = 'USA'
GROUP BY ORDERITEMS.prod_id;
    
