-- LABORATORY WORK 5
-- BY Kuzina_Anna
CREATE OR REPLACE FUNCTION get_prod_count(
    vendid vendors.vend_id%TYPE)
  RETURN INT
AS
  prodcount INT;
BEGIN
  SELECT COUNT(DISTINCT products.prod_id)
  INTO prodcount
  FROM products
  JOIN vendors
  ON products.vend_id   = vendors.vend_id
  WHERE vendors.vend_id = vendid;
  RETURN prodcount;
END get_prod_count;


CREATE OR REPLACE PROCEDURE get_vend_id(
      vendname IN vendors.vend_name%TYPE,
      vendid OUT vendors.vend_id%TYPE)
  IS
  BEGIN
    SELECT vendors.vend_id
    INTO vendid
    FROM vendors
    WHERE vendors.vend_name = vendname;
  EXCEPTION
  WHEN no_data_found THEN
    dbms_output.put_line('no vend with this name');
  END get_vend_id;
  
  
CREATE OR REPLACE PROCEDURE updata_prod_price(
      prodid       IN products.prod_id%TYPE,
      updata_price IN products.prod_price%TYPE)
  IS
    upp_price products.prod_price%TYPE;
    rec_exception EXCEPTION;
    PRAGMA rec_exception_rec(rec_exception, 1000);
  BEGIN
    SELECT products.prod_price INTO upp_price WHERE products.prod_id = prodid;
    UPDATE products
    SET products.prod_price = updata_price
    WHERE products.prod_id  = prodid;
  EXCEPTION
  WHEN no_data_found THEN
    dbms_output.put_line('no prod with prod price ');
  WHEN rec_exception THEN
    dbms_output.put_line('prod is not empty');
  END updata_prod_price;
