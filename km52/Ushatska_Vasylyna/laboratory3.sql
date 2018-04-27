-- LABORATORY WORK 3
-- BY Ushatska_Vasylyna
/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 10. Ключі постачальників vvv1….vvvn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/

/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/
DECLARE VENDORID VENDORS.VEND_ID%TYPE
VENDORNAME VENDORS.VEND_NAME%TYPE
ORDERITEMTYPE VARCHAR(15)
BEGIN
VENDORS.VEND_ID='BRS01'
SELECT VENDORS.VEND_ID,VENDORS.VEND_NAME INTO VENDORID ,VENDORNAME 
FROM VERDORS JOIN PRODUCTS
ON VERDORS.VEND_ID=PRODUCTS.VEND_ID
JOIN ORDERITEMS
ON PRODUCTS.PROD_ID=ORDERITEMS.PROD_ID
IF ORDERITEMS.ITEM_PRICE=(SELECT MIN(ITEM_PRICE)FROM ORDERITEMS)
THAN ORDERITEMTYPE:=('yes');
ELSIF  ORDERITEMS.ITEM_PRICE=(SELECT ITEM_PRICE FROM ORDERITEMS
                              MINUS  
                              SELECT MIN(ITEM_PRICE)FROM ORDERITEMS)
THEN ORDERITEMTYPE:=('no');
ELSE ORDERITEMS.ITEM_PRICE=''
THEN ORDERITEMTYPE:=('unknown');
END IF;
DBMS_OUTPUT.PUT_LINE(VENDORNAME ||ORDERITEMTYPE)
END;



/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/
CREATE VIEW VENDORS_CUSTOMERS_PRODUCTS
AS
SELECT Count( ORDERITEMS.ORDER_ITEM*QUANTITY)AS SUM_QUANTITY
FROM CUSTOMERS JOIN ORDERS 
ON CUSTOMERS.CUST_ID=ORDERS.CUST_ID
JOIN ORDERITEMS
ON ORDERS.ORDER_NUM=ORDERITEMS.ORDER_NUM
JOIN PRODUCTS
ON ORDERITEMS.PROD_ID=PRODUCTS.PROD_ID
WHERE VENDORS_COUNTRY='Germany';
SELECT CUST_NAME,COUNT( ORDERITEMS.ORDER_ITEM*QUANTITY)AS SUM_PROD
FROM  VENDORS_CUSTOMERS_PRODUCTS;

             
