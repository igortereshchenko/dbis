-- LABORATORY WORK 2
-- BY Dreiev_Ihor
/*---------------------------------------------------------------------------
1. Вивести номер замовлення та ключ постачальника, за умови, що жодного з продуктів цього постачальника у 
замовленні нема.

---------------------------------------------------------------------------*/
--Код відповідь:

select ORDER_NUM, VEND_ID from
OrderItems full outer join Products
on  OrderItems.PROD_ID = Products.PROD_ID 
full outer join Vendors on Products.vend_id = Vendors.vend_id
minus
select ORDER_NUM, VEND_ID from
OrderItems join Products
on  OrderItems.PROD_ID = Products.PROD_ID 
join Vendors on Products.vend_id = Vendors.vend_id;












/*-----------------------------------------------------------------------------
2.  Вивести ключ покупця, що працював з постачальником, що продає найменшу кількість продуктів.

---------------------------------------------------------------------------*/

--Код відповідь:
select cust_id from (select vend_id from (
    select vendors.vend_id, count(*) as count_prod
    from vendors join products
    on vendors.vend_id = products.vend_id
    group by vendors.vend_id)
        where count_prod = (select min(count(*)) from vendors join products
       on vendors.vend_id = products.vend_id
       group by vendors.vend_id))
  tab1 join Products on tab1.vend_id = Products.vend_id
  join Orderitems on Products.prod_id = Orderitems.prod_id
  join Orders on Orderitems.order_num = orders.order_num;


