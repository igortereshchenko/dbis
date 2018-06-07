-- LABORATORY WORK 2
-- BY Pidhainyi_Anton

/*---------------------------------------------------------------------------
1. Вивести номер замовлення та ключ постачальника, вказавши скільки товарів даного постачальника є у даному замовленні.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT DISTINCT order_num, vend_id , quantity FROM orderitems JOIN products ON orderitems.prod_id=products.prod_id;









  

/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має замовлення, що містять продукти лише від 3 постачальників.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT orderitems.order_num ,cust_id, prod_id FROM orders JOIN orderitems ON orders.order_num=orderitems.order_num GROUP BY orderitems.ORDER_NUM;









