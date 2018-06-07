-- LABORATORY WORK 3
-- BY Pidhainyi_Anton
SET SERVEROUTPUT ON;
/*1. Написати PL/SQL код, що по вказаному ключу постачальника додає йому продукти з ключами 1,....n, 
щоб сумарна кількість його продуктів була 10. Назви продуктів = кллюч продукту. Ціна кожного продукту = 1.
Операція виконується, якщо у постачальника є хоча б один продукт. 10 балів*/


/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він має 0 продуктів - статус  = "poor"
Якщо він має до 2 продуктів включно - статус  = "common"
Якщо він має більше 2 продуктів - статус  = "rich" 4 бали*/
DECLARE
    vend_key vendors.vend_id%TYPE;
    prod_count INT := 0;
    vendor_name vendors.vend_name%TYPE;
    status char(20);
BEGIN
    vend_key := 'BRS01';
    SELECT count(DISTINCT Products.PROD_ID) , vend_name INTO prod_count,vendor_name 
    FROM Products JOIN Vendors ON PRODUCTS.VEND_ID=Vendors.VEND_ID 
    WHERE Products.vend_id=vend_key; 
    IF (prod_count=0) THEN 
        status:='poor';
    ELSIF (prod_count<=2) THEN
        status:='common';
    ELSIF (prod_count>2) THEN
        status:='rich';
    END IF;
    dbms_output.put_line(TRIM(vendor_name)||': '||TRIM(status));    
END;

/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ключ покупця та ім'я постачальника, що не співпрацювали.
3.2. Вивести ім'я постачальника та загальну кількість проданих ним продуктів 6 балів.*/

