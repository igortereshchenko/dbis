-- LABORATORY WORK 2
-- BY Serpokryl_Andrii
/*---------------------------------------------------------------------------
1. Вивести номер замовлення та ключ постачальника, за умови, що жодного з продуктів цього постачальника у 
замовленні нема.
---------------------------------------------------------------------------*/
--Код відповідь:



select orderitems.order_num,vendors.vend_id
from orderitems,products,vendors
minus
select orderitems.order_num,vendors.vend_id
from orderitems join products on
    orderitems.prod_id = products.prod_id join vendors on
    products.vend_id = vendors.vend_id;


/*---------------------------------------------------------------------------
2.  Вивести ключ покупця, що працював з постачальником, що продає найменшу кількість продуктів.
---------------------------------------------------------------------------*/

--Код відповідь:

select cust_id from(
select  id_vend
from(   
    SELECT VENDORS.VEND_ID as id_vend, COUNT(PRODUCTS.PROD_ID) amount_of_products
    FROM VENDORS inner JOIN PRODUCTS ON
         VENDORS.VEND_ID = PRODUCTS.VEND_ID 
    GROUP BY VENDORS.VEND_ID)
    WHERE amount_of_products = (select min(product_amount) as product_amount
                            from( SELECT VENDORS.VEND_ID , COUNT(PRODUCTS.PROD_ID) AS PRODUCT_AMOUNT
                                    FROM VENDORS  JOIN PRODUCTS ON
                                    vENDORS.VEND_ID = PRODUCTS.VEND_ID 
                            GROUP BY VENDORS.VEND_ID)))  lower_vendor
                            join Products on lower_vendor.id_vend = Products.vend_id
  join Orderitems on Products.prod_id = Orderitems.prod_id
  join Orders on Orderitems.order_num = orders.order_num;
