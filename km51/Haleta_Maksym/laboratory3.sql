-- LABORATORY WORK 3
-- BY Haleta_Maksym
/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/
DECLARE
    vendId Products.vend_id%TYPE := 'BRS01';
    prodId Products.prod_id%TYPE := 'BR01';
    max_sum INTEGER := 400;
    current_sum INTEGER := 0;
    prodPrice Products.prod_price%TYPE := 10;
    prodName Products.prod_name%TYPE;
BEGIN
    SELECT
        sum(Products.prod_price)
    INTO current_sum
    FROM
        Products
    WHERE
        Products.vend_id = vendId;
        
    SELECT
        prod_name
    INTO prodName
    FROM
        Products
    WHERE
        prod_id = prodId;
    IF current_sum < max_sum THEN
        max_sum := floor(max_sum-current_sum);
        FOR i IN 1..max_sum LOOP
            INSERT INTO Products (prod_id, vend_id, prod_name, prod_price)
            VALUES('prod' || i, vendId, prodName, prodPrice);
        END LOOP;
    END IF;
END;
/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/
SET SERVEROUTPUT ON

DECLARE
    custID Customers.cust_id%TYPE := '1000000001';
    custName Customers.cust_name%TYPE;
    countProducts INTEGER := 0;
    status VARCHAR2(10);
BEGIN
    SELECT
        Customers.cust_id,
        Customers.cust_name,
        Count(Distinct Orders.order_num)
    INTO
        custId,
        custName,
        countProducts
    FROM
        Customers LEFT JOIN ORDERS
        ON Customers.cust_id = Orders.cust_id
    WHERE
        Customers.cust_id = custId
    GROUP BY
        Customers.cust_id,
        Customers.cust_name;
    
    IF countProducts = 0 THEN
        status := 'unknown';
    ELSIF countProducts = 2 THEN
        status := 'yes';
    ELSIF countProducts > 2 THEN
        status := 'no';
    END IF;
    
    DBMS_OUTPUT.put_line(TRIM(custName) || ' ' || status);
END;

/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки продуктів було замовлено покупцями з Германії.
3.2. Вивести назву продукту та у скількох замовленнях його купляли.
6 балів.*/
CREATE OR REPLACE VIEW Info AS
    SELECT
        Customers.cust_id,
        Customers.cust_country,
        Products.prod_id,
        Products.prod_name,
        Orders.order_num
    FROM
        Customers FULL OUTER JOIN Orders
            ON Customers.cust_id = Orders.cust_id
        FULL OUTER JOIN OrderItems
            ON Orders.order_num = OrderItems.order_num
        FULL OUTER JOIN Products
            ON OrderItems.prod_id = Products.prod_id;

SELECT
    Count(DISTINCT cust_id)
FROM
    Info
WHERE
    cust_country = 'USA';
    
SELECT
    prod_name,
    Count(DISTINCT order_num) AS count_order_num
FROM
    Info
WHERE prod_name IS NOT NULL
GROUP BY
    prod_name;
