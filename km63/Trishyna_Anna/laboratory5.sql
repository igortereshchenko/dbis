-- LABORATORY WORK 5
-- BY Trishyna_Anna
CREATE OR REPLACE FUNCTION prod_id (in cust_id number)
RETURN number
IS
prod_id  number;
BEGIN 
SELECT COUNT(PROD_ID) INTO PROD_COUNT FROM PRODUCT WHERE VEND_ID=VENDOR_ID;
RETURN PROD_ID;
END


CREATE PROCEDURE proc(new_name products.prod_id%Type)
BEGIN
SELECT prod_id into old_name 
FROM products
WHERE prod_id=new_name;
IF (count(prod_id)=1) and filter is not NULL
THEN UPDATE PRODUCTS
SET PRODUCTS prod_id=

CREATE PROCEDURE get_vend_id (in vend_name varchar, out vendor_id number)
BEGIN
SELECT NVL(VEND_ID,0)
FROM VENDORS 
WHERE
VEND_NAME=vend_name;
IF vendor_id==0
THEN 
END IF
END



