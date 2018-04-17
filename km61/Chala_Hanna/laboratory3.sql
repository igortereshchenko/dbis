-- LABORATORY WORK 3
-- BY Chala_Hanna
/*1. Написати PL/SQL код, що по вказаному ключу покупця додає в його замовлення, що було зроблено першим будь-який продукт 10 разів, змінюючи order_item у циклі.
Операція виконується, якщо у даному замовленнґ вже є хочаб один товар. 10 балґв*/


/*2. Написати PL/SQL код, що по вказаному ключу продукту виводить у консоль його назву та визначає  його статус.
якщо продукт не продається  - статус  = "poor"
якщо продукт продано до 2 різних замовлень включно - статус  = "common"
якщо продукт продано більше ніж у 2 замовлення - статус  = "rich" 4 бали*/

DECLARE
PRODUCT_ID PRODUCTS.PROD_ID%TYPE;
PRODUCT_NAME PRODUCTS.PROD_NAME%TYPE;
PROD_TYPE VARCHAR2(10);
ORDER_COUNT := 0;
BEGIN
PRODUCT_ID := 'BR01' 
SELECT
PROD_ID,
COUNT(ORDER_NUM)
INTO
PRODUCT_ID,
ORDER_COUNT
FROM
(SELECT
PROD_ID,
ORDER_NUM
FROM
PRODUCTS RIGHT JOIN ORDERITEMS
ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID)
GROUP BY PROD_ID

IF (ORDER_COUNT = 0) THEN
PROD_COUNT := 'POOR';
ELSIF (ORDER_COUNT < 2) THEN
PROD_COUNT := 'COMMON';
ELSE 
PROD_COUNT := 'RICH';
END IF;

DBMS_OUTPUT_PUT_LINE(PROD_COUNT));

END;



/*3. ‘творити предсавленнЯ та використати його у двох запитах:
3.1. ‚ивести ґм'Я постачальника та номер замовленнЯ, куди не прода№ постачальник сво» продукти.
3.2. ‚ивести ґм'Я постачальника та загальну кґлькґсть замовлень, куди постачальник продавам сво» продукти 6 балґв.*/
