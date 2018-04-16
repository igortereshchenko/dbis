-- LABORATORY WORK 3
-- BY Kupar_Kristina

/*1. Написати PL/SQL код, що по вказаному ключу постачальника додає йому продукти з ключами 111,....111+n, 
щоб сумарна кількість його продуктів була 10. Назви продуктів - будь-яка ностанта. Ціна кожного продукту наступного продукту на одиницю більша ніж попередній, починати з 1.
 10 балів*/
DECLARE
   vendor_id char(15);
   product_id INTEGER;
   COUNT_PRODUCT INTEGER;
BEGIN
    PRODUCT_ID := 111;
    SELECT VEND_ID INTO vendor_ID FROM vendors;
    IF VENDOR_ID = 'BRS01'
    THEN 
        FOR I IN 1..10 LOOP
            PRODUCT_ID := 111+I
            Dbms_Output.Put_Line(vendor_ID || ' ' PRODUCT_ID);
        END LOOP;
    END IF;
END

/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та изначає  його статус.
Якщо він має до 2 продуктів включно - статус  = "common"
Якщо він має більше 2 продуктів - статус  = "rich"
інакше він має статус "o status" 4 бали*/
DECLARE
    vendor_id char(15);
    vendor_name char(50);
    vendor_status char (50);
    vend-products char(50);
BEGIN
    vend_id := 'BRS01';
    SELECT VEND_NAME INTO vendor_name FROM vendors;
    SELECT Count(PROD_ID) INTO VEND_PRODUCTS FROM PRODUCTS WHERE VEND_ID = 'BRS01';
    IF vend_products > 0 AND vend_products < 2
        THEN vendor_status := 'common'
    ELSIF (vend_products > 2)
        THEN vendor_status := 'rich'
    ELSE vendor_status := 'o status'
    END IF;
    Dbms_Output.Put_Line(vendor_name || ' ' || vendor_status);
END;
/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ім'я покупця та ім'я постачальника, що не співпрацювали.
3.2. Вивести ключ постачальника та загальну кількість проданих ним продуктів 6 балів.*/

