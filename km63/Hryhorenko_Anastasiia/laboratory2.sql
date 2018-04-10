-- LABORATORY WORK 2
-- BY Hryhorenko_Anastasiia
/*---------------------------------------------------------------------------
1. Вивести постачальників, що не продали жодного продукту та живуть в Америці.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT VEND_ID
FROM(
    (SELECT VEND_ID
    FROM Vendors
    WHERE (VEND_COUNTRY ='USA')
    
    MINUS
    
    (SELECT VEND_ID
    FROM Vendors RIGHT JOIN Products 
        ON (Vendors.VEND_ID = Products.VEND_ID)
        RIGHT JOIN OrderItems
        ON (Products.PROD_ID = OrderItems.PROD_ID)
    GROUP BY VEND_ID)
    );


/*---------------------------------------------------------------------------
2.  Вивести номер найдешевшого замовлення та кількість товарів у ньому.

---------------------------------------------------------------------------*/

--Код відповідь:

SELECT ORDER_NUM, SUM(QUANTITY)
FROM
    (SELECT ORDER_NUM, SUM(QUANTITY), SUM(ITEM_PRICE))
    FROM OrderItems
    GROUP BY ORDER_NUM
    )
WHERE (SUM(ITEM_PRICE) = MIN(SUM(ITEM_PRICE)));
