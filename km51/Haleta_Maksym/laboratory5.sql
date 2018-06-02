-- LABORATORY WORK 5
-- BY Haleta_Maksym
-- Написати функцію, що повертає  кількість різних продуктів у замовленні, за ключем замовлення.
create or 
-- Написати процедуру, що за назвою продукту повертає його ключ, якщо операція неможлива процедура кидає exception
CREATE OR REPLACE PROCEDURE get_prod_id_by_prod_name(prodName IN Products.prod_name%TYPE)
is
prodId Products.prod_id%TYPE;
invalid_prodName EXCEPTION%
BEGIN
  SELECT
    prod_id
  INTO prodId
  FROM
    Products
  WHERE
    Products.prod_name = prodName;
    
  IF prodName NOT IN (SELECT
    prod_name
  FROM
    Products) THEN:
    RAISE invalid_prodName;
  END If
END get_prod_id_by_prod_name
