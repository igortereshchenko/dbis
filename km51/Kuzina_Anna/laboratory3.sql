-- LABORATORY WORK 3
-- BY Kuzina_Anna
/*1. Ќаписати PL/SQL код, що дода№ продукт з цґною 10 постачальнику з ключем BRS01, щоб сумарна кґлькґсть його продуктґв була менша = 10.
Љлючґ нових продуктґв   - prod1Йprodn. ђешта обовХЯзкових полґв беретьсЯ на вґбґр студента.
10 балґв*/
SET SERVEROUTPUT ON
DECLARE
  vendor_id vendors.vend_id%TYPE;
  vendor_name vendors.vend_name%TYPE;
  product_id products.prod_id%TYPE;
  product_name products.prod_name%TYPE;
  product_price products.prod_price%TYPE;
  items_count INTEGER ;
BEGIN
  vendor_id    :='BRS01';
  product_id   :='prod';
  product_name :='PROD';
  SELECT COUNT(PRODUCTS.PROD_ID)
  INTO ITEMS_COUNT
  FROM vendors
  LEFT JOIN products
  ON vendors.vend_id   =products.vend_id
  WHERE vendors.vend_id='BRS01';
  ITEMS_COUNT         :=10-ITEMS_COUNT;
  FOR i                  IN 1..items_count
  LOOP
    INSERT
    INTO products
      (
        prod_id,
        vend_id,
        prod_name,
        prod_price
      )
      VALUES
      (
        TRIM(product_id)
        ||items_count,
        vendor_id,
        TRIM(product_name)
        ||items_count,
        10
      );
  END LOOP;
END;
/*2. Ќаписати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ґм'Я та визнача№  його статус.
џкщо вґн купив два рґзних продукти - статус  = "yes"
џкщо вґн купив бґльше двох рґзних продуктґв- статус  = "no"
џкщо вґн нема№ замовленнЯ - статус  = "unknown*/
SET SERVEROUTPUT ON;
DECLARE
  custId Customers.CUST_ID%TYPE :=&empno;
  custName Customers.CUST_NAME%TYPE;
  prodAmount INTEGER := 0;
  custStatus VARCHAR2(40);
BEGIN
  SELECT Customers.CUST_ID,
    Customers.CUST_NAME,
    COUNT(DISTINCT PRODUCTS.PROD_ID)
  INTO custId,
    custName,
    prodAmount
  FROM Customers
  JOIN Orders
  ON Customers.CUST_ID = Orders.CUST_ID
  JOIN ORDERITEMS
  ON ORDERS.ORDER_NUM = orderitems.order_num
  JOIN PRODUCTS
  ON orderitems.prod_id   = PRODUCTS.PROD_ID
  WHERE Customers.CUST_ID = custId
  GROUP BY Customers.CUST_ID,
    Customers.CUST_NAME;
  IF prodAmount     = 0 THEN
    custStatus     := 'unknown';
  ELSIF prodAmount  < 2 THEN
    custStatus     := 'no';
  ELSIF prodAmount >= 2 THEN
    custStatus     := 'yes';
  END IF;
  DBMS_OUTPUT.PUT_LINE(TRIM(custName) || ' ' || custStatus);
END;
/*3. ‘творити представленнЯ та використати його у двох запитах:
3.1. ‘кґльки товарґв було куплено покупцЯми з Ђнглґ».
3.2. Ќа Яку загальну суму купили покупцґ товари з Ђнглґ».
6 балґв.*/
CREATE VIEW CUST_VEND_SV AS
SELECT CUSTOMERS.CUST_ID,
  CUSTOMERS.CUST_COUNTRY,
  VENDORS.VEND_ID,
  ORDERITEMS.ITEM_PRICE,
  ORDERITEMS.QUANTITY
FROM CUSTOMERS
LEFT JOIN ORDERS
ON ORDERS.CUST_ID=CUSTOMERS.CUST_ID
LEFT JOIN ORDERITEMS
ON ORDERITEMS.ORDER_NUM=ORDERS.ORDER_NUM
LEFT JOIN PRODUCTS
ON PRODUCTS.PROD_ID=ORDERITEMS.PROD_ID
LEFT JOIN VENDORS
ON VENDORS.VEND_ID=PRODUCTS.VEND_ID;

SELECT COUNT(DISTINCT CUST_ID)

FROM CUST_VEND_SV
WHERE CUST_COUNTRY ='England';

SELECT SUM(QUANTITY * ITEM_PRICE)
FROM CUST_VEND_SV
WHERE CUST_COUNTRY ='England';
