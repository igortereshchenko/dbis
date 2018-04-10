-- LABORATORY WORK 2
-- BY Buts_Oleksandr
/*---------------------------------------------------------------------------
1. Вивести постачальників, що не продали жодного продукту та живуть в Америці.

---------------------------------------------------------------------------*/
--Код відповідь:
select VEND_NAME
from Vendors left join Products
on Vendors.VEND_ID=Products.VEND_ID
where Products.VEND_ID is null and Vendors.VEND_COUNTRY=USA;









/*---------------------------------------------------------------------------
2.  Вивести номер найдешевшого замовлення та кількість товарів у ньому.

---------------------------------------------------------------------------*/

--Код відповідь:
select Orders.ORDER_NUM,count(Products.PROD_ID)
from Orders join Orderitems
on Orders.ORDER_NUM=Orderitems.ORDER_NUM
join Products
on Products.PROD_ID=Orderitems.PROD_ID
group by Orders.ORDER_NUM
having Orderitems.ORDER_NUM in (select ORDER_NUM from Orderitems where QUANTITY*ITEM_PRICE IN (SELECT MIN(QUANTITY*ITEM_PRICE) FROM orderitems group by ORDER_NUM));
