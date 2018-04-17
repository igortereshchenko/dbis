/*1. Написати PL/SQL код, що по вказаному ключу замовлення додає в його будь-який продукт 10 разів, змінюючи order_item у циклі.
Операція виконується, якщо у даному замовленні вже є хоча б один товар. 10 балів*/

set SERVEROUTPUT ON;

DECLARE
    order_num int := 20005;
    prev_order_item int := 1;
    has_order boolean := false;
    items orderitems.order_num%TYPE;
BEGIN
    SELECT DISTINCT orderitems.order_num INTO items FROM orderitems WHERE orderitems.order_num = order_num;
    
    IF (has_order) THEN
        FOR i IN prev_order_item..prev_order_item + 9 LOOP
            INSERT INTO orderitems VALUES(order_num, i, 'BR01', 1, 5.49);
        END LOOP;
    END IF;
END;

/*2. Написати PL/SQL код, що по вказаному ключу замовлення виводить у консоль його дату та изначає  його статус.
Якщо воно має 0 товарів у середині - статус  = "poor"
Якщо воно має до 2 товарів включно - статус  = "common"
Якщо воно має більше 2 товарів - статус  = "rich" 4 бали*/

DECLARE
    order_num orders.order_num%TYPE := 20005;
BEGIN
    
END;

/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ключ постачальника та номер замовлення, куди продає постачальник свої продукти.
3.2. Вивести ім'я постачальника та загальну кількість проданих ним товарів 6 балів.*/
