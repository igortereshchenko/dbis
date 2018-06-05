-- LABORATORY WORK 5
-- BY Kizim_Yevhenii

 --- 1 ---
CREATE OR REPLACE FUNCTION f11 (key_ IN ORDERITEMS.ORDER_NUM%TYPE)
RETURN INT
IS
sum_ INT;
begin
select sum(quantity * item_price) into sum_ from ORDERITEMS
where order_num = key_
group by order_num;
Return sum_;
end;

--- 2 ---
CREATE OR REPLACE PROCEDURE p2 (descript IN PRODUCTS.PROD_DESC%TYPE, key_ out PRODUCTS.PROD_ID%TYPE)
IS
quant INT;
impossible EXCEPTION;
begin
select count(*) into quant from products where products.PROD_DESC = descript;
if quant = 1
then 
select prod_id into key_ from products where products.PROD_DESC = descript;
else raise impossible; 
end if;
end;


-- 3 --
CREATE OR REPLACE PROCEDURE p3 (prod_key IN PRODUCTS.PROD_ID%TYPE, 
    order_key IN ORDERS.ORDER_NUM%TYPE, quant IN ORDERITEMS.QUANTITY%TYPE)
IS
no_product EXCEPTION;
no_order EXCEPTION;
temp INT;
temp1 INT;
begin
select count(*) into temp from PRODUCTS where prod_id = prod_key;
select count(*) into temp1 from ORDERS where order_num = order_key;
if temp != 1
then raise no_product;
elsif temp1 != 1
then raise no_order;
else
update orderitems 
    set ORDERITEMS.QUANTITY = quant
where ORDERITEMS.ORDER_NUM = order_key and ORDERITEMS.PROD_ID = prod_key;
end if;
end;
