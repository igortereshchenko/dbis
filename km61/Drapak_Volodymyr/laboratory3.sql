/*1. Ќаписати PL/SQL код, що по вказаному ключу замовленнЯ дода№ в його будь-Який продукт 10 разґв, змґнюючи order_item у циклґ.
ЋперацґЯ викону№тьсЯ, Якщо у даному замовленнґ вже № хочаб один товар. 10 балґв*/

DECLARE
    order_number orderitems.order_num%type := 1000000005;
    v_prod_sum orderitems.quantity%type := 0;
BEGIN
    SELECT order_num
    FROM orderitems
    WHERE order_num = order_number
    GROUP BY order_num
    HAVING SUM(quantity) > 0;
    
    FOR i IN 1..10 LOOP
        INSERT INTO orderitems (prod_id)
        VALUES (5447);
        
    END LOOP;
END;


/*2. Ќаписати PL/SQL код, що по вказаному ключу замовленнЯ виводить у консоль його дату та изнача№  його статус.
џкщо воно ма№ 0 товарґв у серединґ - статус  = "poor"
џкщо воно ма№ до 2 товарґв включно - статус  = "common"
џкщо воно ма№ бґльше 2 товарґв - статус  = "rich" 4 бали*/

DECLARE
    order_number orderitems.order_num%type := 100000001;
    v_order_date orderitems.order_date%type;
    v_order_item orderitems.order_item%type;
    v_prod_count products.prod_count%type;
    v_ord_status VARCHAR(20);
BEGIN
    SELECT ORDER_NUM, ORDER_DATE, SUM(ORDER_ITEM)
    INTO order_number, v_order_date, v_prod_count
    FROM ORDERITEMS
    WHERE ORDERITEMS.order_num = order_number
    GROUP BY ORDER_NUM, ORDER_DATE;
    
    IF v_prod_count = 0 THEN
        v_ord_status := 'poor';
    ELSIF v_prod_count <= 2 THEN
        v_ord_status := 'common';
    ELSE
        v_ord_status := 'rich';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(v_ord_status);
    
END;


/*3. ‘творити предсавленнЯ та використати його у двох запитах:
3.1. ‚ивести ключ постачальника та номер замовленнЯ, куди прода№ постачальник сво» продукти.
3.2. ‚ивести ґм'Я постачальника та загальну кґлькґсть проданих ним товарґв 6 балґв.*/

CREATE VIEW vendors_products AS(
    SELECT vendors.vend_id, vendors.vend_name, orderitems.order_num, orderitems.quantity
    FROM vendors
    JOIN products ON vendors.vend_id = products.vend_id
    LEFT JOIN orderitems ON orderitems.prod_id = products.prod_id
);

SELECT DISTINCT vend_id, order_num
FROM vendors_products
WHERE quantity IS NOT NULL;

SELECT DISTINCT vend_name, prod_sum
FROM (
    SELECT vend_id, vend_name, sum(quantity) prod_sum
    FROM vendors_products
    GROUP BY vend_id, vend_name
);
