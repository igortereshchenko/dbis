-- LABORATORY WORK 5
-- BY Sedinin_Yehor


CREATE OR REPLACE FUNCTION get_count( ord_num number );
RETURN number
IN item_count number
BEGIN
 SELECT count(quantity.OrderItems) INTO item_count
 FROM OrderItems 
 WHERE order_num.OrderItems = ord_num
 
 RETURN item_count
END;

-----------------------------------------
CREATE OR REPLACE PROCEDURE get_id_name( p_name IN char, c_id OUT char, c_name OUT char );

BEGIN
  SELECT cust_id.Customers INTO c_id, cust_name.Customers INTO c_name
  FROM Customers JOIN Orders ON cust_it.Customers = cust_id.Orders
  JOIN OrderItems ON order_num.Orders = order_num.OrderItems
  JOIN Products ON prod_id.OrderItems = prod_id.Products 
  WHERE prod_name.Products = p_name
  
  EXCEPTION
  WHEN NO_DATA_FOUND
  ----
END;

-----------------------------------------
CREATE OR REPLACE PROCEDURE add_product( p_id IN char, v_id IN char, p_name IN char, p_price IN number);

BEGIN
  IF p_name NOT IN (SELECT prod_name FROM Products)
  THEN 
    INSERT INTO Products (prod_id, vend_id, prod_name, prod_price)
    VALUES (p_id, v_id, p_name, p_price);
  ELSE
    EXCEPTION
    ----
END;      
  
  
  
  
  
  
  
  


  
  
