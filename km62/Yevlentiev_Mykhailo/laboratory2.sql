-- LABORATORY WORK 2
-- BY Yevlentiev_Mykhailo

/*---------------------------------------------------------------------------
1. Вивести vend_name постачальника, що продав більше 2 одиниць продуктів 2 різним покупцям.

---------------------------------------------------------------------------*/
--Код відповідь:

SELECT vend_name
	FROM(
		Venders
		JOIN Products ON venders.vend_id = products.prod_id
		JOIN Orders ON orders.cust_id = venders.vend_id  
		
)
WHERE COUNT(products.prod_id > 2 AND orders.cust_id > 2)







/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що має замовлення з найдешевшим товаром.

---------------------------------------------------------------------------*/

--Код відповідь:


SELECT cust_id
	FROM(

		Customers
		JOIN OrderItem ON 

)
WHERE MIN(Prod_price)


