-- LABORATORY WORK 3
-- BY Kizim_Yevhenii
/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 7. Ключі постачальників v1….vn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/
DECLARE
VNAME VENDORS.VEND_NAME%TYPE;
VADDR VENDORS.VEND_ADDRESS%TYPE;
VCITY VENDORS.VEND_CITY%TYPE;
VSTATE VENDORS.VEND_STATE%TYPE;
VZIP VENDORS.VEND_ZIP%TYPE;
VCOUNTRY VENDORS.VEND_COUNTRY%TYPE;

BEGIN
SELECT VEND_NAME, VEND_ADDRESS, VEND_CITY, VEND_STATE, VEND_ZIP, VEND_COUNTRY INTO
VNAME, VADDR, VCITY, VSTATE, VZIP, VCOUNTRY
FROM VENDORS
WHERE VEND_ID = 'BRS01';
FOR i IN 1..7 LOOP
  INSERT INTO VENDORS (VEND_ID, VEND_NAME, VEND_ADDRESS, VEND_CITY, VEND_STATE, VEND_ZIP, VEND_COUNTRY)
  VALUES ('v'||i, VNAME, VADDR, VCITY, VSTATE, VZIP, VCOUNTRY);
END LOOP;
END;

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив більше 10 продуктів - статус  = "yes"
Якщо він купив менше 10 продуктів - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

DECLARE
Cid CUSTOMERS.CUST_ID%TYPE := '1000000001';
Cname CUSTOMERS.CUST_NAME%TYPE;
Cquantity INTEGER;
status varchar(50);
BEGIN
SELECT CUSTOMERS.CUST_NAME, COUNT(ORDERS.ORDER_NUM) 
INTO Cname, Cquantity
FROM CUSTOMERS JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
WHERE CUSTOMERS.CUST_ID = Cid
GROUP BY CUSTOMERS.CUST_NAME;
IF Cquantity > 10 THEN status:='yes';
ELSIF Cquantity < 10 THEN status:='no';
ELSIF Cquantity != 10 THEN status:='unknown';
END IF;

SYS.DBMS_OUTPUT.PUT_LINE(TRIM(Cname) || ': ' || status);
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести ім’я покупця та загальну кількість купленим ним товарів.
3.2. Вивести ім'я постачальника за загальну суму, на яку він продав своїх товарів.
6 балів.*/

CREATE OR REPLACE VIEW data_view AS 
SELECT CUSTOMERS.CUST_ID, CUSTOMERS.CUST_NAME, ORDERS.ORDER_NUM, 
ORDERITEMS.QUANTITY, ORDERITEMS.ITEM_PRICE, PRODUCTS.PROD_ID, VENDORS.VEND_ID, 
VENDORS.VEND_NAME 
FROM CUSTOMERS FULL OUTER JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
  FULL OUTER JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
  FULL OUTER JOIN PRODUCTS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
  FULL OUTER JOIN VENDORS ON PRODUCTS.VEND_ID = VENDORS.VEND_ID;
-- 1 --
SELECT  CUST_NAME, NVL(SUM(QUANTITY),0) AS "Quantity of bought products" 
FROM data_view
WHERE CUST_NAME IS NOT NULL
GROUP BY CUST_ID, CUST_NAME;

-- 2 --
SELECT  VEND_NAME, NVL(SUM(QUANTITY * ITEM_PRICE), 0) AS "Selled sum"
FROM data_view
WHERE VEND_NAME IS NOT NULL
GROUP BY VEND_ID, VEND_NAME;
