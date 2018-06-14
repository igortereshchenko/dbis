-- LABORATORY WORK 2
-- BY Riasyk_Ihor
/*---------------------------------------------------------------------------
1. Вивести ключ покупця та ключ продукту, за умови, що покупець ніколи не купляв даний продукт.

---------------------------------------------------------------------------*/
--Код відповідь:
SELECT cust_id,  prod_id
FROM Customers
FULL OUTER JOIN TABLE (Products)
ON  cust_id=prod_id 
WHERE prod_id IS NULL;

/*---------------------------------------------------------------------------
2.  Вивести ключ постачальника, що працював з покупцем, що має найдорожче замовлення.

---------------------------------------------------------------------------*/

--Код відповідь:
SELECT Vendors.Vend_id
FROM (SELECT Customers.cust_id, Orders.MAX(cust_id), Vendors.Vend_id
      FROM TABLE (Customers)
      LEFT JOIN TABLE (Orders) ON Customers.cust_id=Orders.MAX(cust_id)
      GROUP BY (cust_id, vend_id));
