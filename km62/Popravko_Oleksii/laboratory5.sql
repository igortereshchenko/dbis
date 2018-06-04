-- LABORATORY WORK 5
-- BY Popravko_Oleksii
/*1*/
CREATE OR REPLACE FUNCTION name_ret(
    id Products.PROD_ID%type)
  RETURN vendor_id, vendor_name;
  BEGIN
    id:='BRO1'
    SELECT VENDORS.VEND_NAME,
      VENDORS.VEND_ID
    FROM VENDORS
    LEFT JOIN PRODUCTS
    ON VENDORS.VEND_ID     = Products.PROD_ID
    WHERE Products.PROD_ID = id;
  END name_ret;
/*2*/  
CREATE OR REPLACE PROCEDURE prod_del(
      product_name Products.PROD_NAME%TYPE IN)
  IS
    ORDER:= '0'
  BEGIN
    CREATE VIEW product_del AS
    SELECT Products.PROD_NAME
    FROM Products NATURAL
    JOIN OrderItems
    WHERE PRODUCTS.PROD_NAME = product_name
    AND DISTINCT(OrderItems.ORDER_ITEM)
  END VIEW;
DELETE(PROD_ID,VEND_ID,PROD_NAME,PROD_PRICE)
FROM Products
WHERE Products.PROD_NAME = product_del.prod_name
EXCEPTION DBMS_OUTPUT.put_line('Some exception')
END prod_del;
