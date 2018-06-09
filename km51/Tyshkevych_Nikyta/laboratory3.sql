-- LABORATORY WORK 3
-- BY Tyshkevych_Nikyta

/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/

DECLARE
	PRODUCT_ID  PRODUCTS.PROD_ID%TYPE;
	PRODUCT_NAME  VARCHAR(30) := '8 inch teddy bear';
	VENDOR_ID VARCHAR(5) := 'BRS01';
	PRODUCT_PRICE INTEGER := 10;
	

BEGIN
	DECLARE VEND_PROD_PRICE_COUNT
	SELECT COUNT(PROD_PRICE) FROM PRODUCTS
	WHERE VEND_ID = VENDOR_ID
	INTO VEND_PROD_PRICE_COUNT
	FOR I IN 1..40 LOOP
	PRODUCT_ID := 'PROD' || I;
		INSERT INTO PRODUCTS (PROD_ID,VEND_ID,PROD_NAME,PROD_PRICE) 
		VALUES (

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

DECLARE 
	CUST_NAME CUSTOMERS.CUST_NAME%TYPE;
	CUSTOMER_ID CUSTOMERS.CUST_ID%TYPE;
	CUST_TYPE VARCHAR2(7);
	ITEMS_COUNT iNTEGER:=0;
BEGIN
	CUSTOMER_ID:='1000000001'
	SELECT CUSTOMERS.CUST_ID, CUSTOMERS.CUST_NAME, COUNT(ORDERITEMS.ORDER_NUM) INTO
		CUST_ID, CUST_NAME, ITEMS_COUNT
	FROM CUSTOMERS LEFT JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID
	JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
	WHERE CUSTOMERS.CUST_ID = CUSTOMER_ID

	IF ITEMS_COUNT > 2 THEN
		CUST_TYPE := 'NO'
	ELSIF ITEMS_COUNT == 2
		CUST_TYPE := 'YES'
	ELSIF ITEMS_COUNT == 0
		CUST_TYPE := 'UNKNOWN'
	END IF
	
	DBMS_OUTPUT.PUT_LINE(TRIM(CUST_NAME) || '  ' ||CUST_TYPE)
	
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки продуктів було замовлено покупцями з Германії.
3.2. Вивести назву продукту та у скількох замовленнях його купляли.
6 балів.*/

CREATE VIEW prod_view as
	SELECT  CUSTOMER.CUST_COUNTRY, ORDERITEMS.QUANTITY, ORDERITEMS.PROD_ID PRODUCTS.PROD_NAME FROM 
		CUSTOMERS JOIN ORDERS ON CUSTOMER.CUST_ID = ORDERS.CUST_ID
		JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
		FOIN PRODUCTS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID


3.1
SELECT COUNT(QUANTITY) FROM
	PROD_VIEW
	WHERE CUST_COUNTRY = 'GERMANY'

3.2

SELECT PROD_NAME, COUNT(PROD_ID) FROM 
	PROD_VIEW
	

		
