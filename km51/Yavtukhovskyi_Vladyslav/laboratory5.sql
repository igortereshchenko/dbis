 CREATE OR REPLACE PROCEDURE chcol(
  tovar IN product.prod_id%type,
  zamov IN orders.order_id%type,
  newcolvo IN orderitems.quantity%type,
  forut OUT number
  )
  IS
  prov number;
  BEGIN
  SELECT COUNT(*)
  INTO prov
  FROM OrderItems
  WHERE 
  Order_Num=zamov
  AND
  prod_id=tovar;
  IF(prov!=0) THEN
      BEGIN
        UPDATE orderitems
        SET(quantity) VALUES (newkolvo)
        WHERE 
        order_num=zamov AND prod_id=tovar;
        forut:=1;
      END;
      ELSE
        forut:=0;
        END IF;
  END;
 
 
 
 
 
 
 
  CREATE OR REPLACE PROCEDURE komentar(
    tutwtuka IN products.prod_desc%type,
    keyorkolvo OUT products.prod_id%type
  )
  IS
  prov number;
  BEGIN
  SELECT COUNT(*)
  INTO prov
  FROM products
  WHERE tutwtuka= prod_desc;
  IF (prov!=0) 
    THEN
      SELECT prod_id
      INTO keyorkolvo
      FROM products
      WHERE tutwtuka=prod_desc;
    ELSE
      keyorkolvo:='exception';
      
  END IF;
END;

CREATE OR REPLACE FUNCTION funczamov(
  onum IN OrderItems.order_num%type
  )
  RETURN NUMBER
  AS
  cursor pozamov is
    SELECT QUANTITY, ITEM_PRICE 
    FROM OrderItems
    WHERE ORDER_NUM=onum;
  wtuka pozamov%rowtype;
  summ number;
  BEGIN
    summ:=0;
    FOR wtuka IN pozamov 
      LOOP
      summ:=summ+wtuka.quantity*wtuka.item_price;
      END LOOP;
      return summ;
  END funczamov;
  
  
  set serveroutput on;
  DECLARE
  prov products.prod_desc%type;
  BEGIN
  komentar('8 inch teddy bear, comes with cap and jack1et', prov);
  dbms_output.put_line(prov);
  END;
  
  
  CREATE OR REPLACE PROCEDURE komentar(
    tutwtuka IN products.prod_desc%type,
    keyorkolvo OUT products.prod_id%type
  )
  IS
  prov number;
  BEGIN
  SELECT COUNT(*)
  INTO prov
  FROM products
  WHERE tutwtuka= prod_desc;
  IF prov!=0 
    THEN
      SELECT prod_id
      INTO keyorkolvo
      FROM products
      WHERE tutwtuka=prod_desc;
    ELSE
      keyorkolvo:='exception';
      
  END;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  