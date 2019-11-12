-- LABORATORY WORK 5
-- BY Lukianenko_Anastasiia
CREATE OR REPLACE FUNCTION max_price(o_id in orders.order_num%type)
    RETURN STRING
    IS
    CURSOR max_products IS
        SELECT
            products.prod_name
        FROM ORDERITEMS JOIN PRODUCTS ON ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
        WHERE ORDER_NUM = o_id AND
            ORDERITEMS.ITEM_PRICE IN (
                SELECT MAX(ORDERITEMS.ITEM_PRICE)
                FROM ORDERITEMS
                WHERE ORDER_NUM = o_id);
    res PRODUCTS.PROD_NAME%TYPE;
    BEGIN 
        FOR I IN MAX_PRODUCTS LOOP
            RES := RES || TRIM(I.PROD_NAME);
            RES := RES || ' ';
        END LOOP;
        RETURN RES;
    END;
/
---------------------------------
CREATE OR REPLACE PROCEDURE vend_name(p_name products.prod_name%type)
    IS
        TYPE VEND_ARR IS TABLE OF VENDORS.VEND_NAME%TYPE;    
        vend_names VEND_ARR;
    BEGIN
        SELECT
            vendors.vend_name into vend_names
        FROM PRODUCTS JOIN VENDORS ON PRODUCTS.VEND_ID = VENDORS.VEND_ID
        WHERE PRODUCTS.PROD_NAME = p_name;
    END;
/
---------------------------
CREATE OR REPLACE PROCEDURE new_prod(v_id vendors.vend_id%type, new_prod_id products.prod_id%type,
    new_prod_name products.prod_name%type, new_prod_price products.prod_price%type)
    IS
        V_COUNT INT;
        P_COUNT INT;
    BEGIN
        SELECT
            COUNT(VENDORS.VEND_ID) INTO V_COUNT
        FROM VENDORS
        WHERE VEND_ID = V_ID;

        IF V_COUNT > 0 THEN
            SELECT
                COUNT(PRODUCTS.PROD_ID) INTO P_COUNT
            FROM PRODUCTS
            WHERE PROD_ID = new_prod_id;
            IF P_COUNT = 0 THEN
                INSERT INTO PRODUCTS(PROD_ID, VEND_ID, PROD_NAME, PROD_PRICE)
                VALUES(new_prod_id, V_ID, new_prod_name, new_prod_price);
            ELSE
                RAISE PRODUCT_EXIST;
            END IF;
        ELSE
            RAISE NO_VENDOR_FOUND;
        END IF;
        EXCEPTION
            WHEN NO_VENDOR_FOUND THEN DBMS_OUTPUT.PUT_LINE("NO VENDOR FOUND");RETURN NULL;
            WHEN PRODUCT_EXIST THEN  DBMS_OUTPUT.PUT_LINE("PRODUCT ALREADY EXIST");RETURN NULL;
            
    END;
/
