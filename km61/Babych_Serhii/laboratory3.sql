-- LABORATORY WORK 3
-- BY Babych_Serhii
/*1. Ќаписати PL/SQL код, що по вказаному ключу замовленнЯ дода№ в його будь-Який продукт 10 разґв, змґнюючи order_item у циклґ.
ЋперацґЯ викону№тьсЯ, Якщо у даному замовленнґ вже № хочаб один товар. 10 балґв*/



/*2. Ќаписати PL/SQL код, що по вказаному ключу замовленнЯ виводить у консоль його дату та изнача№  його статус.
џкщо воно ма№ 0 товарґв у серединґ - статус  = "poor"
џкщо воно ма№ до 2 товарґв включно - статус  = "common"
џкщо воно ма№ бґльше 2 товарґв - статус  = "rich" 4 бали*/
DECLARE
    order_key  ORDERITEMS.ORDER_NUM%TYPE := 'DBS34';
    order_date CHARACTER;
    order_status CHARACTER;
    order_count INTEGER(5);

BEGIN
    SELECT ORDER_NUM, ORDER_DATE ,SUM(ORDER_ITEMS)
    INTO order_num, order_date, order_count
    FROM ORDERITEMS
    WHERE ORDERITEMS.ORDER_NUM = ORDERS.ORDER_NUM;
    IF (order_count = 0) THEN
    order_status := "poor";
    ELSIF order_count <= 2 THEN
    order_status := "common";
    ELSE
    order_status := "rich";
    END IF;

END;

/*3. ‘творити предсавленнЯ та використати його у двох запитах:
3.1. ‚ивести ключ постачальника та номер замовленнЯ, куди прода№ постачальник сво» продукти.
3.2. ‚ивести ґм'Я постачальника та загальну кґлькґсть проданих ним товарґв 6 балґв.*/
CREATE VIEW MY_VIEW AS
   SELECT VEND_NAME
   FROM VENDORS;
   
   SELECT
