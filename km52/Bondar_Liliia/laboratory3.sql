-- LABORATORY WORK 3
-- BY Bondar_Liliia
/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників була 10. Ключі замовників test1….testn. 
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/
Declare 
  add_count integer := 10;
  
begin

end;


/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/
declare 
    wanted_vendor_id vendors.vend_id%TYPE  &= wanted_vendor_id;
    min_price := select min(products.prod_price)
                  from products left join vendors on
                  products.vend_id = vendors.vend_id;
    wanted_vendor_record := select * 
                            from products left join vendors on
                            products.vend_id = vendors.vend_id
                            where products.vend_id = wanted_vendor_id;
begin
  if wanted_vendor_record.prod_price = min_price
end;



/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/

CREATE VIEW ALIB AS
SELECT customers.CUST_ID CUST_ID,
customers.CUST_NAME CUST_NAME,
customers.CUST_ADDRESS CUST_ADDRESS,
customers.CUST_CITY CUST_CITY,
customers.CUST_STATE CUST_STATE,
customers.CUST_ZIP CUST_ZIP,
customers.CUST_COUNTRY CUST_COUNTRY,
customers.CUST_CONTACT CUST_CONTACT,
customers.CUST_EMAIL CUST_EMAIL,
orders.ORDER_NUM ORDER_NUM,
orders.ORDER_DATE ORDER_DATE,
orders.CUST_ID CUST_ID_0,
orderitems.ORDER_NUM ORDER_NUM_1,
orderitems.ORDER_ITEM ORDER_ITEM,
orderitems.PROD_ID PROD_ID,
orderitems.QUANTITY QUANTITY,
orderitems.ITEM_PRICE ITEM_PRICE,
products.PROD_ID PROD_ID_2,
products.VEND_ID VEND_ID,
products.PROD_NAME PROD_NAME,
products.PROD_PRICE PROD_PRICE,
products.PROD_DESC PROD_DESC,
vendors.VEND_ID VEND_ID_3,
vendors.VEND_NAME VEND_NAME,
vendors.VEND_ADDRESS VEND_ADDRESS,
vendors.VEND_CITY VEND_CITY,
vendors.VEND_STATE VEND_STATE,
vendors.VEND_ZIP VEND_ZIP,
vendors.VEND_COUNTRY VEND_COUNTRY 
FROM customers
inner JOIN orders
ON customers.cust_id = orders.cust_id
inner JOIN orderitems
ON orders.order_num = orderitems.order_num
inner JOIN products
ON orderitems.prod_id = products.prod_id
inner JOIN vendors
ON products.vend_id = vendors.vend_id; 

select sum(count(alib.prod_id))
from alib
where alib.vend_country = 'Germany'
group by (ALIB.vend_name);
select alib.cust_name, sum(alib.quantity), alib.cust_id
from alib
group by (alib.cust_name, alib.cust_id);
