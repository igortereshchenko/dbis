-- LABORATORY WORK 3
-- BY Beziazychna_Kateryna
/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників була 10. Ключі замовників test1….testn. 
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/
Declare
VENDOR_ID VENDORS.VEND_ID%Type;
VENDOR_NAME VENDORS.VEND_NAME%Type;
COUNT_VENDORS INTEGER:=10;

 BEGIN
 VENDOR_ID:='BRSO1';
 VENDOR_KEY:='KEY';
 VENDOR_VALUE:='1000000001';
 FOR I IN 1..N LOOP
 INSERT INTO VENDORS (
 VEND_ID, VEND_NAME)
 VALUES(
 TRIM (VENDOR_KEY)||I,VENDOR_ID,
 TRIM(VENDOR_VALUE)||I,COUNT_VENDORS);
 END LOOP;
 END;

/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/
Declare
VENDOR_ID VENDORS.VEND_ID%Type;
VENDOR_NAME VENDORS.VEND_NAME%Type;
VENDOR_STATUS NVARCHAR2(30);
ITEMS_COUNT INTEGER:=0;
BEGIN
VENDOR_ID:='BRSO1';
SELECT
VENDORS.VENDOR_ID,
VENDORS.VENDOR_NAME,
MIN(PRODUCTS.PROD_PRICE)
INTO
VENDOR_ID,VENDOR_NAME, ITEMS_COUNT
FROM VENDORS
LEFT JOIN PRODUCTS ON VENDORS.VEND_ID=PRODUCTS.VEND_ID
WHERE VENDORS.VEND_ID=VENDORS_ID
GROUP BY VENDORS.VEND_ID,
VENDORS.VEND_NAME;

IF 
ITEMS_COUNT=MIN(PRODUCTS.PROD_PRICE)
THEN VENDOR_STATUS:='= YES';
ELSIF
ITEMS_COUNT<>MIN(PRODUCTS.PROD_PRICE)
THEN VENDOR_STATUS:='= NO';
ELSE
VENDOR_STATUS:='= UNKNOWN';
END IF;
Dbms_Output.Put_Line(TRIM(VENDOR_NAME)||VENDOR_STATUS);
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/

CREATE VIEW PRODUCT_VEND AS
SELECT 
PRODUCTS.PROD_ID, 
VENDORS.VEND_ID,
ORDEITEMS.QUANTITY,
CUSTOMERS.CUST_NAME,
ORDERS.ORDER_NUM
FROM 
    CUSTOMERS 
JOIN ORDERS ON CUSTOMER.CUST_ID=ORDERS.CUST_ID
JOIN ORDERITEMS ON ORDERITEMS.ORDER_NUM=Orders.Order_Num
JOIN PRODUCTS ON Orderitems.Prod_Id=Products.Prod_Id
JOIN VENDORS ON VENDORS.VEND_ID=Products.Vend_Id;


SELECT SUMPRODUCT
FROM PRODUCT_VEND
WHERE SUMPRODUCT=SUM(ORDEITEMS.QUANTITY) AND VENDORS.VEND_COUNTRY='GERMANY';

SELECT  CUSTOMERS.CUST_NAME,QUANTITY
FROM PRODUCT_VEND
WHERE QUANTITY=COUNT(ORDERITEMS.QUANTITY);
