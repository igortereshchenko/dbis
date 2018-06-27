-- LABORATORY WORK 2
-- BY Biedukhin_Tymur

/*---------------------------------------------------------------------------
1. Вивести постачальників, що не продали жодного продукту та живуть в Америці.

---------------------------------------------------------------------------*/
--Код відповідь:










/*---------------------------------------------------------------------------
2.  Вивести номер найдешевшого замовлення та кількість товарів у ньому.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT info.order_num, info.quantity 
FROM SELECT info.order_num, info.quantity, MIN(info.order_price)
    FROM SELECT order_num, quantity, MIN(quantity*item_price) AS "order_price"
        FROM OrderItems OI1, OrderItems OI2
        WHERE OI1.order_num = OI2.order_num
        GROUP BY order_num 
        info;
