-- LABORATORY WORK 3
-- BY Kovtun_Artem

/*1. Ќаписати PL/SQL код, що по вказаному ключу замовленнЯ дода№ в його будь-Який продукт 10 разґв, змґнюючи order_item у циклґ.
ЋперацґЯ викону№тьсЯ, Якщо у даному замовленнґ вже № хочаб один товар. 10 балґв*/

DECLARE 
    order_key ORDERS.ORDER_NUM%TYPE := 20005;
    product_key PRODUCTS.PROD_ID%TYPE := 'RYL02';
    products_quantity int;
    iterator int := 1;
BEGIN
    SELECT MAX(order_item) INTO products_quantity FROM orderitems WHERE ORDER_NUM = order_key ;
    
    IF (products_quantity > 0) THEN
        WHILE(iterator <= 10) 
            LOOP                 
                INSERT INTO orderitems (order_num, order_item, prod_id,quantity, item_price) VALUES (order_key, products_quantity + iterator, product_key, 0, 0); 
                iterator := iterator + 1;
            END LOOP;
    END IF;
END;




/*2. Ќаписати PL/SQL код, що по вказаному ключу замовленнЯ виводить у консоль його дату та изнача№  його статус.
џкщо воно ма№ 0 товарґв у серединґ - статус  = "poor"
џкщо воно ма№ до 2 товарґв включно - статус  = "common"
џкщо воно ма№ бґльше 2 товарґв - статус  = "rich" 4 бали*/

DECLARE 

  ORDER_ID ORDERS.ORDER_NUM%TYPE;
  STATUS CHAR(10);
  PRODUCTS_QUANTITY INT := 0;
  
BEGIN 

  ORDER_ID := 20005;

  SELECT  COUNT(ORDERITEMS.ORDER_ITEM)
    INTO PRODUCTS_QUANTITY
      FROM ORDERS JOIN ORDERITEMS ON ORDERS.ORDER_NUM = ORDERITEMS.ORDER_NUM
        WHERE ORDERS.ORDER_NUM = ORDER_ID 
          GROUP BY  ORDERS.ORDER_NUM;
     
      
  IF (PRODUCTS_QUANTITY = 0)  THEN 
        STATUS := 'POOR';
  ELSIF (PRODUCTS_QUANTITY > 0 AND PRODUCTS_QUANTITY <=2) 
    THEN STATUS := 'COMMON';
  ELSE 
    STATUS := 'RICH';
  END IF;
  
  DBMS_OUTPUT.put_line(STATUS);

END;


/*3. ‘творити предсавленнЯ та використати його у двох запитах:
3.1. ‚ивести ключ постачальника та номер замовленнЯ, куди прода№ постачальник сво» продукти.
3.2. ‚ивести ґм'Я постачальника та загальну кґлькґсть проданих ним товарґв 6 балґв.*/



CREATE VIEW VENDORSORDERS AS 
  SELECT VENDORS.VEND_ID, 
         VENDORS.VEND_NAME,
         ORDERITEMS.ORDER_NUM,
         ORDERITEMS.ORDER_ITEM
  FROM VENDORS JOIN PRODUCTS ON VENDORS.VEND_ID = PRODUCTS.VEND_ID
    JOIN ORDERITEMS ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID;
    


SELECT DISTINCT VEND_ID, ORDER_NUM
 FROM VENDORSORDERS;
  

SELECT VEND_NAME, SUM(ORDER_ITEM)
  FROM VENDORSORDERS
    GROUP BY VEND_ID, VEND_NAME;
