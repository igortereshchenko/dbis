-- LABORATORY WORK 3
-- BY Biedukhin_Tymur

/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх 
постачальників була 7. Ключі постачальників v1….vn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/
DECLARE
  vendorsCount := 0  
  ;
BEGIN 
  WHILE (vendorsCount =< 7) loop
    vandorsCount := SELECT COUNT(vend_id) FROM Vendors;
    INSERT INTO Vendors (vend_id, vend_name)
    VALUES(v||(vendorsCount+1), SELECT vend_name FROM Vendors WHERE vend_id = "BRS01")
    end loop;
;


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його
ім'я та визначає  його статус.
Якщо він купив більше 10 продуктів - статус  = "yes"
Якщо він купив менше 10 продуктів - статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/

DECLARE 
  status := "unknown"
  customerKey := 0
;
BEGIN 
  SELECT cust_name, status
  FROM(
      SELECT cust_name, quantity
      FROM( Customers JOIN Orders 
      ON Customers.cust_id = Orders.cust_id = customerKey
      JOIN OrderItems 
      ON Orders.order_num = OrderItems.order_num
      )
      START IF
      IF ( quantity > 10 ) THEN status := "yes"
      ELSE IF( quantity < 10 ) THEN status := "no"
      ELSE status := "unknown"
      END IF;
  )
;
/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести ім’я покупця та загальну кількість купленим ним товарів.
3.2. Вивести ім'я постачальника за загальну суму, на яку він продав своїх товарів.
6 балів.*/

CREATE VIEW bestViewEver AS 
  SELECT cust_name FROM (
    SELECT cust_name, quantity
    FROM Customers JOIN Orders 
    ON Customers.cust_id = Orders.cust_id
    JOIN OrderItems 
    ON Orders.order_num = OrderItems.order_num...
  )
