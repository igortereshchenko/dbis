-- LABORATORY WORK 5
CREATE OR REPLACE FUNCTION get_vendor_info_by_product_key( prod PRODUCTS.prod_id%TYPE)
RETURN string
AS
vend_name_data Vendors.vend_name%TYPE;
vend_id_data Vendors.vend_id%TYPE;
output string(250);
BEGIN
SELECT Vendors.vend_name,Vendors.vend_id into vend_name_data,vend_id_data
FROM Products
LEFT JOIN Vendors on Vendors.vend_id=Vendors.vend_name 
WHERE Products.prod_id=prod;
EXCEPTION 
 WHEN NO_DATA_FOUND THEN;
 RETURN ' ':
 output :=  Vendors.vend_id_data
 RETURN output:
 END get_vendor_info_by_product_key;














CREATE OR REPLACE PROCEDURE update.prod_name prod PRODUCTS.prod_id%TYPE)
AS
prod_name_data PRODUCTS.prod_id%TYPE;
prod_id_data PRODUCTS.prod_id%TYPE;
BEGIN
SELECT Products.prod_name,Products.prod_id into prod_name_data,prod_id_data
FROM Products
LEFT JOIN Products on roducts.prod_id=Products.prod_name 
WHERE Products.prod_id=prod;
EXCEPTION 
END;
-- BY Kolobaieva_Kateryna
