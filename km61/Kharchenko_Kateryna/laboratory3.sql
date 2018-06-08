-- LABORATORY WORK 3
-- BY Kharchenko_Kateryna
/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/
DECLARE
N_PROD_ID VARCHAR(20) := "prod" || N
BEGIN

APPEND PRODUCTS
 ('BR01', VEND_ID , PROD_NAME , PROD_PRICE )
WHERE PROD_PRICE == 10,00 and VEND_ID == "BRS01"
and SUM(PRODUCTS.PROD_PRICE) < 400
END

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/
DECLARE
BEGIN
    SELECT CUST_NAME CUST_STAT
    FROM (SELECT CUST(ORDER_NUM) as CUST_STAT
                 ORDERS.CUST_ID  as CUST_ID
        FROM CUSTOMERS JOIN ORDERS AS CUSTOMERS.CUST_ID = ORDERS.CUST_ID
        WHERE ORDERS.CUST_ID)
    WHERE 
    IF CUST_STAT == 2 FROM  (SELECT CUST(ORDER_NUM) as CUST_STAT
                 ORDERS.CUST_ID  as CUST_ID
        FROM CUSTOMERS JOIN ORDERS AS CUSTOMERS.CUST_ID = ORDERS.CUST_ID
        WHERE ORDERS.CUST_ID)WHERE OUTLINE(" NAME: "|| CUST_NAME || "yes")
     IF CUST_STAT > 2 FROM  (SELECT CUST(ORDER_NUM) as CUST_STAT
                 ORDERS.CUST_ID  as CUST_ID
        FROM CUSTOMERS JOIN ORDERS AS CUSTOMERS.CUST_ID = ORDERS.CUST_ID
        WHERE ORDERS.CUST_ID)WHERE OUTLINE(" NAME: "|| CUST_NAME || "no")
        ELSE CUST_STAT FROM  (SELECT CUST(ORDER_NUM) as CUST_STAT
                 ORDERS.CUST_ID  as CUST_ID
        FROM CUSTOMERS JOIN ORDERS AS CUSTOMERS.CUST_ID = ORDERS.CUST_ID
        WHERE ORDERS.CUST_ID)
    


/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки продуктів було замовлено покупцями з Германії.
3.2. Вивести назву продукту та у скількох замовленнях його купляли.
6 балів.*/
SELECT CUST(PROD_ID)
FROM (Orderltems JOIN (CUSTOMER JOIN ORDERS AS CUSTOMERS.CUST_ID = ORDERS.CUST_ID) AS ORDER_NUM = ORDER_NUM) 
JOIN Products AS PROD_ID = PROD_ID
WHERE IF CUST_COUNTRY == 'German'

SELECT PROD_NAME,
       CUST(ORDER_ITEM)
FROM (Orderltems JOIN (CUSTOMER JOIN ORDERS AS CUSTOMERS.CUST_ID = ORDERS.CUST_ID) AS ORDER_NUM = ORDER_NUM) 
JOIN Products AS PROD_ID = PROD_ID
WHERE PROD_NAME
