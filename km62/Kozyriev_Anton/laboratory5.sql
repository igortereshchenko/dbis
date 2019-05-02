-- LABORATORY WORK 5
-- BY Kozyriev_Anton

-- 1

CREATE OR REPLACE FUNCTION get_vend_id_and_name 
(param_prod_id Products.prod_id%TYPE)
RETURN varchar2
IS
    v_required_vend_id Vendors.vend_id%TYPE;
    v_required_vend_name Vendors.vend_name%TYPE;
BEGIN
    SELECT Vendors.vend_id, Vendors.vend_name INTO v_required_vend_id, v_required_vend_name
    FROM Vendors JOIN Products ON Vendors.vend_id = Products.vend_id
    WHERE Products.prod_id = param_prod_id;
    
    RETURN v_required_vend_id || v_required_vend_name;
END get_vend_id_and_name; 

--2

CREATE OR REPLACE PROCEDURE delete_useless_products
(param_prod_name IN PRODUCTS.PROD_NAME%TYPE)
IS
    v_exist_product INT := 0;
    v_current_product_sales INT := 0;
BEGIN 
    SELECT COUNT(Products.prod_id) INTO v_exist_product
    FROM Products
    WHERE Products.PROD_NAME = param_prod_name;
    
    IF (v_exist_product = 0) THEN
        RAISE PRODUCT_DOESNT_EXIST;
        
    ELSE
        BEGIN
            SELECT COUNT(Products.prod_id) INTO v_current_product_sales
            FROM Products JOIN OrderItems
            ON Products.prod_id = OrderItems.prod_id
            WHERE Products.PROD_NAME = param_prod_name;
        END;
        
    IF (v_current_product_sales = 0) THEN
        DELETE ROW Products WHERE Products.PROD_NAME = param_prod_name;       

EXCEPTION;

END delete_useless_products;
