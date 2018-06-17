/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 7. Ключі постачальників v1….vn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/
DECLARE 
    vend_count NUMBER(1);
    vend_name vendors.vend_name%TYPE;
    ins_ord_count NUMBER(1);
    vend_id customers.cust_id%TYPE := 1000000001
BEGIN 
    select count(*) into vend_count from VENDORS where vend_id = vend_id;
    select vend_name into from VENDORS where vend_id = 'BRS01';
    ins_ord_count := 7 - vend_count; 
    IF vend_count < 7 THEN
        FOR vend_id IN 1..ins_ord_count LOOP
            INSERT INTO VENDORS VALUES(vend_id, vend_name);
        END LOOP;    
    END IF;
END;

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ключ та визначає  його статус.
Якщо він зробив 3 замовлення - статус  = "3"
Якщо він не зробив 3 замовлення - статус  = "no 3"
Якщо він немає замовлення - статус  = "unknown*/



/*3. Створити представлення та використати його у двох запитах:

3.1. Скільки замовлень було зроблено покупцями з Германії.
3.2. Вивести назву продукту, що продавався більше ніж у 3 різних замовленнях.
6 балів.*/

CREATE VIEW orders_view as 
    SELECT PRODUCTS.PROD_NAME, ORDERS.ORDER_NUM, CUSTOMERS.CUST_COUNTRY FROM ORDERS JOIN CUSTOMERS ON ORDERS.CUST_ID = CUSTOMERS.CUST_ID
    JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
    JOIN PRODUCTS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID;

SELECT COUNT(*) FROM orders_view WHERE CUST_COUNTRY = 'Германія';

SELECT PROD_NAME FROM(
    SELECT PROD_NAME, COUNT(ORDER_NUM) as order_count FROM orders_view GROUP BY PROD_NAME)
    WHERE order_count > 2;



