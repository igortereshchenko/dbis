
/*1. Написати PL/SQL код, що дода№ продукт з цґною 10 постачальнику з ключем BRS01, 
щоб сумарна кылькысть його продуктґв була менша = 10. 
Ключи нових продуктґв   - prod1iprodn. Решта обовХЯзкових полґв беретьсЯ на вибыр студента.
10 балґв*/

DECLARE
N_PRODACT_ID VARCHAR(20) := 'prod1iprodn',
N_PROD_NAME VARCHAR(20) := 'HELLO'
BEGIN
SELECT PROD_PRICE VEND_ID
FROM PRODUCTS
WHERE PROD_PRICE = 10,00 AND VEND_ID = 'BRS01'
APPEND PRODUCTS
(N_PRODACT_ID, VEND_ID, N_PROD_NAME, PROD_PRICE)
END

/*2. Ќаписати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ґм'Я та визнача№  його статус.
џкщо вґн купив два рґзних продукти - статус  = "yes"
џкщо вґн купив бґльше двох рґзних продуктґв- статус  = "no"
џкщо вґн нема№ замовленнЯ - статус  = "unknown*/

DECLARE
GET_CUST_ID = &.... /*введення змынної*/
BEGIN
    SELECT CUSTOMERS.CUST_NAME CUSTOMERS.CUST_STATE
    FROM CUSTOMERS
        JOIN ORDERS AS CUST_iD.CUSTOMERS = CUST_ID.ORDERS
        INSERT JOIN ORDRITEMS SA ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
    WHERE CUST_ID = GET_CUST_ID
    IF (SELECT ORDEITEMS.PROD_ID FROM ORDEITEMS WHERE count(ORDERITEMS.PROD_ID) == 2)
        DBMS_OUTPUB.OUTLINE("Name: "|| CUSTOMERS.CUST_NAME ||",Status: yes")
    ELSIF (SELECT ORDEITEMS.PROD_ID FROM ORDEITEMS WHERE count(ORDERITEMS.PROD_ID) >= 2)
         DBMS_OUTPUB.OUTLINE("Name: "||CUSTOMERS.CUST_NAME||",Status: no")
    ELSE
         DBMS_OUTPUB.OUTLINE("Name: "||CUSTOMERS.CUST_NAME||",Status: unknown")
    END IF
END

/*3. Створити представленнЯ та використати його у двох запитах:
3.1. Скыльки товарыв було куплено покупцЯми з Ђнглґ».
3.2. Ќа Яку загальну суму купили покупцґ товари з Ђнглґ».
6 балґв.*/


