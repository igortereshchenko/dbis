-- LABORATORY WORK 3
-- BY Lukianenko_Anastasiia
/*1. Написати PL/SQL код, що додає продукт постачальнику з ключем BRS01, щоб сумарна кількість його продуктів була 4. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/
SET SERVEROUTPUT ON
DECLARE
  NEEDED_ID VENDORS.VEND_ID%TYPE;
  V_ID VENDORS.VEND_ID%TYPE;
  NEW_KEY PRODUCTS.PROD_ID%TYPE;
  NEW_NAME PRODUCTS.PROD_NAME%TYPE;
  NEW_PRICE PRODUCTS.PROD_PRICE%TYPE;
  ALREADY_HAVE INT;
  LOOP_INT INT;
BEGIN
  NEEDED_ID := 'BRS01';
  NEW_KEY := 'prod';
  
  SELECT
    PROD_NAME, PROD_PRICE INTO NEW_NAME, NEW_PRICE
  FROM PRODUCTS
  WHERE PROD_ID = 'BR01';
  SELECT
    PRODUCTS.VEND_ID,
    COUNT(PROD_ID)
    INTO V_ID, ALREADY_HAVE
  FROM PRODUCTS
  WHERE VEND_ID = NEEDED_ID
  GROUP BY PRODUCTS.VEND_ID;
  LOOP_INT := 4 - ALREADY_HAVE;
  FOR I IN 1..LOOP_INT LOOP
    INSERT INTO PRODUCTS(PROD_ID, VEND_ID, PROD_NAME, PROD_PRICE)
    VALUES(
      TRIM(NEW_KEY) || I,
      NEEDED_ID,
      NEW_NAME,
      NEW_PRICE
      );
  END LOOP;
END;
/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив найдорожчий продукт - статус  = "yes"
Якщо він не купив найдорожчий продукт- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/
SET SERVEROUTPUT ON
DECLARE
  C_NAME  CUSTOMERS.CUST_NAME%TYPE;
  C_STATUS  NVARCHAR2(10);
  PROD_MAX  PRODUCTS.PROD_ID%TYPE;
  C_ID  CUSTOMERS.CUST_ID%TYPE;
  C_COUNT INT:=0;
  NEEDED_ID CUSTOMERS.CUST_ID%TYPE;
BEGIN
  NEEDED_ID := '1000000001';
  C_COUNT := 0;
  SELECT
    PROD_ID
      INTO PROD_MAX
    FROM PRODUCTS
    WHERE PROD_PRICE IN
    (SELECT
      MAX(PROD_PRICE)
     FROM PRODUCTS);
  
  SELECT
    CUSTOMERS.CUST_NAME,
    CUSTOMERS.CUST_ID,
    COUNT(ORDERITEMS.PROD_ID)
    INTO C_NAME, C_ID, C_COUNT
    FROM CUSTOMERS
      LEFT JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
      LEFT JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
      WHERE CUSTOMERS.CUST_ID = NEEDED_ID AND ORDERITEMS.PROD_ID IN PROD_MAX
      GROUP BY  CUSTOMERS.CUST_ID, CUSTOMERS.CUST_NAME;
  
  IF C_COUNT >= 1 THEN C_STATUS := 'yes';
  else C_STATUS := 'no';
  end if;
  DBMS_OUTPUT.PUT_LINE(C_NAME || ' ' || C_STATUS);
  
  EXCEPTION WHEN NO_DATA_FOUND THEN
  SELECT
    CUSTOMERS.CUST_NAME,
    CUSTOMERS.CUST_ID into C_NAME, C_ID
  from customers 
  where cust_id not in (select cust_id from orders);
  DBMS_OUTPUT.PUT_LINE(C_NAME || ' ' || 'UNKNOWN');
END;
/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести назву продукту та загальну кількість його продаж.
3.2. Яка сумарна кількість товарів була куплена покупцями, що проживають в Америці.
6 балів.*/
CREATE VIEW CUSTOMERS_PRODUCTS AS
  SELECT
    PRODUCTS.PROD_NAME,
    PRODUCTS.PROD_ID,
    CUSTOMERS.CUST_ID,
    CUSTOMERS.CUST_COUNTRY,
    ORDERITEMS.ORDER_ITEM
  FROM CUSTOMERS
    LEFT JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
    LEFT JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
    RIGHT JOIN PRODUCTS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID;
    
--3.1. Вивести назву продукту та загальну кількість його продаж.
SELECT
PRODUCTS.PROD_ID,
  PRODUCTS.PROD_NAME,
  
  COUNT(ORDERITEMS.ORDER_ITEM)
  FROM CUSTOMERS_PRODUCTS
  GROUP BY PRODUCTS.PROD_ID, PRODUCTS.PROD_NAME;
