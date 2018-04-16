/*1. Написати PL/SQL код, що по вказаному ключу постачальника додає йому продукти з ключами 111,....111+n, 
щоб сумарна кількість його продуктів була 10. Назви продуктів - будь-яка ностанта. Ціна кожного продукту наступного продукту на одиницю більша ніж попередній, починати з 1.
 10 балів*/

/*2. Написати PL/SQL код, що по вказаному ключу постачальникавиводить у консоль його ім'я та изначає  його статус.
Якщо він має до 2 продуктів включно - статус  = "common"
Якщо він має більше 2 продуктів - статус  = "rich"
інакше він має статус "o status" 4 бали*/

DECLARE
status varchar2(10);
vendors_name Vendors.VEND_NAME%TYPE;
order_items OrderItems.ORDER_ITEM%TYPE;
BEGIN
SELECT Vendors.VEND_NAME, OrderItems.ORDER_ITEM
INTO vendors_name, order_items
FROM Vendors
JOIN Products ON Products.VEND_ID=Vendors.VEND_ID
JOIN OrderItems ON Products.PROD_ID=OrderItems.PROD_ID
GROUP BY Vendors.VEND_NAME, OrderItems.ORDER_ITEM;

IF order_items <= 2 THEN status:= "common";
ELSE IF order_items > 2 THEN status:= "rich";
ELSE status:= "o status";
END IF;

DBMS_OUTPUT.PUT_LINE("Vendors name: " || vendors_name || "status:" || status);
END;
/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ім'я покупця та ім'я постачальника, що не співпрацювали.
3.2. Вивести ключ постачальника та загальну кількість проданих ним продуктів 6 балів.*/
/*CREATING VIEW */
CREATE VIEW important_view AS
SELECT *
FROM Customers
NATURAL JOIN Oders
NATURAL JOIN OrderItems
NATURAL JOIN Products
NATURAL JOIN Vendors
GROUP BY CUSTOMERS.CUST_NAME, VENDORS.VEND_NAME, VENDORS.VEND_ID;

/*FIRST QUERY */

SELECT CUSTOMERS.CUST_NAME, VENDORS.VEND_NAME
FROM important_view
WHERE ORDERS.ORDER_NUM = NULL;

/*SECOND QUERY */

SELECT VENDORS.VEND_ID, COUNT(OrderItems.ORDER_ITEM) item_quantity
FROM important_view
GROUP BY VENDORS.VEND_ID;
