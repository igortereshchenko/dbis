-- LABORATORY WORK 5
-- BY Haleta_Maksym
-- Написати функцію, що повертає  кількість різних продуктів у замовленні, за ключем замовлення.
create or replace function count_products(orderNum Orders.order_num%TYPE)
RETURN INTEGER
is
  countProducts INTEGER;
BEGIN
  SELECT
    count(distinct Products.prod_name)
  INTO countProducts
  FROM
    Orders JOIN OrderItems
    ON Orders.order_num = OrderItems.order_num
    JOIN Products
    ON OrderItems.prod_id = Products.prod_id
  WHERE
    Orders.order_num = orderNum;
    
  RETURN countProducts;
END count_products;


-- Написати процедуру, що за назвою продукту повертає його ключ, якщо операція неможлива процедура кидає exception
CREATE OR REPLACE PROCEDURE get_prod_id_by_prod_name(prodName IN Products.prod_name%TYPE)
is
prodId Products.prod_id%TYPE;
invalid_prodName EXCEPTION%
BEGIN
  IF prodName NOT IN (SELECT prod_name FROM Products) THEN
    RAISE invalid_prodName;
  ELSE
    SELECT
      prod_id
    INTO prodId
    FROM
      Products
    WHERE
      Products.prod_name = prodName;
    
    DBMS_OUTPUT.putline(prodId);
  END IF;
  
  EXCEPTION
    WHEN invalid_prodName THEN
      DBMS_OUTPUT.putline("There isn't such a product name in the table");

END get_prod_id_by_prod_name;
