-- LABORATORY WORK 2
-- BY Serpokryl_Andrii
/*---------------------------------------------------------------------------
1. Вивести постачальників, що не продали жодного продукту та живуть в Америці.

---------------------------------------------------------------------------*/
--Код відповідь:
select Vendors.vend_id, Vendors.VEND_NAME ,Vendors.vend_country
from Vendors 
    Left outer join Products 
    ON vendors.vend_id = Products.VEND_ID
where Vendors.VEND_COUNTRY = 'USA' 
      and Products.VEND_ID is NULL;








/*---------------------------------------------------------------------------
2.  Вивести номер найдешевшого замовлення та кількість товарів у ньому.

---------------------------------------------------------------------------*/

--Код відповідь:

select OrderItems.order_num, OrderItems.Quantity
from OrderItems
where (orderItems.item_price*orderItems.quantity) in (
  select min(orderItems.item_price*orderItems.quantity)
  from ORDERITEMS);
