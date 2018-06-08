-- LABORATORY WORK 5
-- BY Pochta_Ivan
___________________________________________________________________________________________________________________
CREATE OR REPLACE PROCEDURE DELETE_PRODUCT_BY_NAME (PRODUCT_NAME IN PRODUCTS.PROD_NAME%TYPE) AS 
  PRODUCT_ID PRODUCTS.PROD_ID%type;
BEGIN
  select products.PROD_ID INTO PRODUCT_ID FROM products
  minus
  (select products.PROD_ID
  FROM
    PRODUCTS join ORDERITEMS ON PRODUCTS.PROD_ID = orderitems.prod_id
    where PROD_NAME != PRODUCT_NAME);
  delete from products where PRODUCT_ID = products.PROD_ID;
  NULL;
END DELETE_PRODUCT_BY_NAME;
--------------------------------------------------------------------------------------------------------------------
create or replace FUNCTION get_vendor_info_by_product_key(prod PRODUCTS.prod_id%type)
RETURN string
AS
  vend_name_data  Vendors.vend_name%type;
  vend_id_data Vendors.vend_id%type;
  output string(250);
BEGIN
  SELECT Vendors.vend_name, Vendors.vend_id into vend_name_data, vend_id_data
    FROM Products
    LEFT JOIN Vendors ON Vendors.vend_id = products.prod_id
    WHERE PRODUCTS.prod_id = prod;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN ' ';
  output := vend_id_data || ' ' || vend_name_data;

  RETURN output;
END get_vendor_info_by_product_key;
--------------------------------------------------------------------------------------------------------------------
