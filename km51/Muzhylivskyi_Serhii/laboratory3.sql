-- LABORATORY WORK 3
-- BY Muzhylivskyi_Serhii
/*1. Написати PL/SQL код, що додає замовлення покупцю з ключем 1000000001, щоб сумарна кількість його замовлень була 4. 
Ключі нових замовлень  - ord1….ordn. Дата цих замовлень відповідає даті замовлення з номером 20005.
10 балів*/


DECLARE
  V_DATE ORDERS.ORDER_DATE%TYPE;
  AMOUNT INT;
  V_NUM ORDERS.ORDER_NUM%TYPE;
BEGIN
  SELECT 
    COUNT(ORDER_NUM)
    INTO AMOUNT
  FROM ORDERS
  WHERE CUST_ID = '1000000001';
  SELECT 
    MAX(ORDER_NUM)
    INTO V_NUM
  FROM ORDERS;
  SELECT 
    ORDER_DATE
  INTO V_DATE
  FROM ORDERS WHERE ORDER_NUM = '20005';

  
  FOR I IN AMOUNT..4 LOOP
    INSERT INTO ORDERS(ORDER_NUM, ORDER_DATE, CUST_ID)
    VALUES(V_NUM + I, V_DATE, '1000000001');
  END LOOP;
END;

/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав більше 10 продуктів - статус  = "yes"
Якщо він продав менше 10 продуктів - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/
set SERVEROUTPUT ON
DECLARE
  V_STATUS VARCHAR2(30 CHAR);
  
  AMOUNT INTEGER;
BEGIN
  SELECT 
    QUANTITY
    INTO AMOUNT
    FROM ORDERITEMS JOIN PRODUCTS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
    JOIN VENDORS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID;
    
    IF (AMOUNT >= 10) THEN 
    V_STATUS := 'YES';
    ELSIF (AMOUNT < 10) THEN
    V_STATUS := 'NO';
    ELSE
    V_STATUS := 'unknown';
END;





/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести номери замовлення та кількість постачальників, що продавали свої товари у кожне з замовлень.
3.2. Вивести ім'я постачальника за кількість його покупців.
6 балів.*/

CREATE VIEW GLOBAL AS
