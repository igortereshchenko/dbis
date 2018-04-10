-- LABORATORY WORK 2
-- BY Dreiev_Ihor
/*---------------------------------------------------------------------------
1. Вивести номер замовлення та ключ постачальника, за умови, що жодного з продуктів цього постачальника у 
замовленні нема.

---------------------------------------------------------------------------*/
--Код відповідь:

select distinct ORDER_NUM, VEND_ID from
OrderItems full outer join Products
on  OrderItems.PROD_ID = Products.PROD_ID
minus
select distinct ORDER_NUM, VEND_ID from
OrderItems join Products
on  OrderItems.PROD_ID = Products.PROD_ID;








/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що працював з постачальником, що продає найменшу кількість продуктів.

---------------------------------------------------------------------------*/

--Код відповідь:

select CUST_ID, min(QUANTITY) from(
SELECT VEND_ID, sum(QUANTITY) QUANTITY, CUST_ID
FROM (((Vendors join Products
on Vendors.VEND_ID = Products.VEND_ID) join OrderItems 
on Products.PROD_ID = OrderItems.PROD_ID) join Orders
on OrderItems.ORDER_NUM = Orders.ORDER_NUM)
group by VEND_ID, CUST_ID);

