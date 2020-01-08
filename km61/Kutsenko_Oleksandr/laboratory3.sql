-- LABORATORY WORK 3
-- BY Kutsenko_Oleksandr
/*1.Написати PL/SQL код, що по вказаному ключу покупцЯ додає в його замовленнЯ,
що було зроблено першим будь-який продукт 10 разів, змінюючи order_item у циклі.
Операція виконується, якщо у даному замовленні вже є хоча б один товар. 10 балґв*/

declare
 order_num_const number constant := 20005;
 begin
 for i in 1..10
 insert into orderitems (order_num = order_num_const ; order_item = i ; prod_id = 'BRO1')

/*2. Написати PL/SQL код, що по вказаному ключу продукту виводить у консоль його назму та изначає його статус.
Якщо продукт не продаєтьсЯ  - статус  = "poor"
Якщо продукт продано до 2 різних замовлень включно - статус  = "common"
Якщо продукт продано більше ніж у 2 замовлення - статус  = "rich" 4 бали*/

DECLARE
vendr_id VARCHAR(10):=";
vendr_name VARCHAR(10):=";
items_count INT :=0;
BEGIN 
SELECT vend_id,
prod_name,
COUNT(DISTINCT PROD_NAME);
INTO vend_name,
vendr_name,
items_count;
FROM VENDORS
LEFT JOIN PRODUCTS 
ON VENDORS.PROD.ID=PRODUCTS.PROD.ID
GROUP BY VEND_ID
vend_name
if ITEMS_COUNT=0 THEN
DBMS_OUTPUT PRINT LINE ("poor")
elsif items_count<=2 THEN

DBMS_OUTPUT PRINT LINE ("common")
elsif items_count>=2 THEN
DBMS_OUTPUT PRINT LINE ("rich")
END;



/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести ім'я постачальника та номер замовлення, куди не продає постачальник свої продукти.
3.2. Вивести ім'я постачальника та загальну кількість замовлень, куди постачальник продав свої продукти 6 балів.*/
create view cust_vend as
select
customers.cust_name,
vendors.vend_name,
vendors.vend_id,
products.prod_id,
products.prod_name;
from CUSTOMERS 
join ORDERS
on CUSTOMERS.CUST_ID=ORDERS.CUST_ID
join ORDERITEMS
on ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
join PRODUCTS
on ORDERS.PROD_ID=PRODUCTS.PROD_ID
join VENDORS
on PRODUCTS.VEND_ID=VENDORS.VEND_ID
/*first query*/
select 
vend_id,order_num
from cust_vend
where VEND_ID=PROD_ID
/*second query*/
select vend_name
count(distinct prod_id)
from cust_vend
where VEND_ID=PROD_ID
