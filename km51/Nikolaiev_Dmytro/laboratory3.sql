-- LABORATORY WORK 3
-- BY Nikolaiev_Dmytro
set serveroutput on;

/*1. Написати PL/SQL код, що додає замовлення покупцю з ключем 1000000001, щоб сумарна кількість його замовлень була 4. 
Ключі нових замовлень  - ord1….ordn. Дата цих замовлень відповідає даті замовлення з номером 20005.
10 балів*/

DECLARE
    cust_id       customers.cust_id%TYPE;
    cust_name     customers.customers_name%TYPE;
    order_num      orders.order_num%TYPE;
    order_date    orders_order_date%TYPE;
    items_count     INTEGER := 0;
BEGIN
    cust_id := '1000000001';
    order_num := '20005';
    product_name := 'PROD';
    
   FOR items_count in 1..4 LOOP
   if items_count = 4
      THEN EXIT;
    END IF;
        INSERT INTO orders (
            order_num,
            order_date,
            cust_id
          
        ) VALUES (
            order_num,
            (SELECT orders.order_date from orders where order_num=orders.order_num),
            cust_id);
            
 
    END LOOP;
 
END;
/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав більше 10 продуктів - статус  = "yes"
Якщо він продав менше 10 продуктів - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/

DECLARE
    vendor_id     vendors.vend_id%TYPE;
    vendor_name   vendors.vend_name%TYPE;
    vendor_status   VARCHAR2(14);
    items_count   INT := 0;
BEGIN
    vendor_id := 'BRS01';
    SELECT
        vendors.vend_id,
        vendors.vend_name,
        COUNT(products.prod_id)
    INTO
        vendor_id,vendor_name,items_count
    FROM
        vendors
        LEFT JOIN products ON vendors.vend_id = products.vend_id
    WHERE
        vendors.vend_id = vendor_id
    GROUP BY
        vendors.vend_id,
        vendors.vend_name;
 
    IF
        items_count >= 10
    THEN
        vendor_status := ' yes';
    ELSIF items_count <10 AND items_count>0 THEN
        vendor_status := ' no';
    ELSIF items_count=0 THEN
        vendor_type := 'unknown';
    END IF;
 
    dbms_output.put_line(trim(vendor_name) || vendor_type);
END;
 



/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести номери замовлення та кількість постачальників, що продавали свої товари у кожне з замовлень.
3.2. Вивести ім'я постачальника за кількість його покупців.
6 балів.*/


Create view myview as
select
 customers.cust_id,
        orders.order_num,
        vendors.vend_id,
        vendors.vend_name
    FROM
        customers
        JOIN orders ON orders.cust_id = customers.cust_id
        JOIN orderitems ON orders.order_num = orderitems.order_num
        JOIN products ON products.prod_id = orderitems.prod_id
        JOIN vendors ON vendors.vend_id = products.vend_id;
        
Select order_num, count(vend_id)
from myview
group by order_num;

Select vend_name, count(cust_id)
from myview
group by vend_name;


