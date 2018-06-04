-- LABORATORY WORK 5
-- BY Dmytrenko_Hryhorii
CREATE OR REPLACE FUNCTION get_prod_id (ID_OF_VENDOR vendors.vend_id%type)
RETURN INTEGER 
    AS THIS_RESULT INTEGER;
BEGIN
SELECT (VENDORS.VEND_ID || VENDORS.VEND_NAME) INTO THIS_RESULT
    FROM PRODUCTS JOIN VENDORS ON PRODUCTS.VEND_ID = VENDORS.VEND_ID
    WHERE VENDORS.VEND_ID = ID_OF_VENDOR;
    RETURN THIS_RESULT;
END get_prod_id;
-------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE delete_prod (name_of_product in PRODUCTS.PROD_NAME%TYPE);
BEGIN
IF (PRODUCTS.PROD_ID != NULL AND (
    select products.prod_id 
        from orderitems right join products 
        on orderitems.prod_id = products.prod_id
    minus
    select orderitems.prod_id
        from orderitems join products 
        on orderitems.prod_id = products.prod_id) != 0 THEN 
    DELETE name_of_product FROM PRODUCTS
    ELSE EXCEPTION 
    DBMS_OUTPUT.PUT_LINE("orderInsertException raised");
END;
-------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE delete_prod (id_of_product in 
