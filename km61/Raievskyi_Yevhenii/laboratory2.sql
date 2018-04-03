
/*---------------------------------------------------------------------------
1. Вивести номер замовлення та ключ постачальника, вказавши скільки товарів даного постачальника є у даному замовленні.

---------------------------------------------------------------------------*/
--Код відповідь:





SELECT
  order_num, vend_id, SUM(quantity)
FROM(
  SELECT orderitems.order_num, SUM(orderitems.quantity) as quantity
    FROM
      orderitems
    GROUP BY
      orderitems.order_num, orderitems.prod_id
  ) INNER JOIN products
      ON
      prod_id = products.prod_id
GROUP BY
 order_num;




  

/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має замовлення, що містять тільки по одному товару.

---------------------------------------------------------------------------*/

--Код відповідь:





SELECT 
  cust_id
FROM
  orders INNER JOIN
  (
    SELECT
      orderitems.order_num, SUM(quantity) as quantity
    FROM
      orderitems
    GROUP BY
      orderitems.order_num
  ) mytable
ON
  orders.order_num = mytable.order_num
WHERE
  quantity = 1;
