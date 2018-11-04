-- LABORATORY WORK 3
-- BY Kurshakov_Mykhailo
/*1. Написати PL/SQL код, що додає продукт постачальнику з ключем BRS01, щоб сумарна кількість його продуктів була 4.
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/
SET SERVEROUTPUT ON
DECLARE
  vendor_id vendors.vend_id%TYPE;
  vendor_name vendors.vend_name%TYPE;
  product_id products.prod_id%TYPE;
  product_name products.prod_name%TYPE;
  product_price products.prod_price%TYPE;
  items_count INTEGER ;
BEGIN
  vendor_id    := 'BRS01';
  product_id   := 'prod';
  product_name := 'PROD';
  SELECT COUNT(PRODUCTS.PROD_ID) into ITEMS_COUNT
  FROM vendors
  LEFT JOIN products
  ON vendors.vend_id    = products.vend_id
  WHERE vendors.vend_id = 'BRS01';

  ITEMS_COUNT:=4-ITEMS_COUNT;
  FOR i IN 1..items_count
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
        || items_count,
        vendor_id,
        TRIM(product_name)
        || items_count,
        10
      );
  END LOOP;
END;

/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив найдорожчий продукт - статус  = "yes"
Якщо він не купив найдорожчий продукт- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

 
DECLARE
    v_cust_id CUSTOMERS.CUST_ID%TYPE := &empno;
    v_cust_name CUSTOMERS.CUST_NAME%TYPE;
    v_price ORDERITEMS.item_price%TYPE;
    max_price  ORDERITEMS.item_price%TYPE;
BEGIN
SELECT max(item_price)
    INTO   max_prise
    FROM   ORDERITEMS;

SELECT v_cust_name, V_PRICE
FROM customers_ven
JOIN orders
ON orders.cust_id = customers_ven.cust_id
JOIN orderitems
ON orders.order_num = orderitems.order_num;
IF V_PRICE=max_price THEN
     DBMS_OUTPUT.PUT_LINE(v_cust_name||'yes')
    END IF;
IF V_PRICE<max_price THEN
     DBMS_OUTPUT.PUT_LINE(v_cust_name||'no')
    END IF;
IF V_PRICE is NULL THEN
     DBMS_OUTPUT.PUT_LINE(v_cust_name||'unknow')
    END IF;
 
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести назву продукту та загальну кількість його продаж.
3.2. Яка сумарна кількість товарів була куплена покупцями, що проживають в Америці.
6 балів.*/
CREATE VIEW customers_ven AS
SELECT customers.cust_id,
  customers.cust_name,
  vendors.vend_id,
  vendors.vend_name,
  PRODUCTS.PROD_NAME,
  CUSTOMERS.CUST_COUNTRY
FROM customers
JOIN orders
ON orders.cust_id = customers.cust_id
JOIN orderitems
ON orders.order_num = orderitems.order_num
JOIN products
ON products.prod_id = orderitems.prod_id
JOIN vendors
ON vendors.vend_id = products.vend_id;
SELECT prod_name, COUNT(prod_name) FROM customers_ven GROUP BY prod_name;
SELECT COUNT(CUST_COUNTRY) FROM customers_ven WHERE CUST_COUNTRY LIKE '%USA%';
