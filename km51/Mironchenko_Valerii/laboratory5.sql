-- LABORATORY WORK 5
-- BY Mironchenko_Valerii

/*Написати функцію, що повертає кіл-сть продуктів постачальника за ім'ям постачальника*/

CREATE OR REPLACE FUNCTION getCountProductsByVendorName(VendName VENDORS.VEND_NAME%TYPE) RETURN Number 
    IS
    products_count NUMBER;
BEGIN
     SELECT COUNT(PRODUCTS.PROD_ID) INTO products_count 
     FROM VENDORS JOIN PRODUCTS
                  ON VENDORS.VEND_ID = PRODUCTS.VEND_ID 
                  AND VENDORS.VEND_NAME = VendName
     GROUP BY VENDORS.VEND_ID;
RETURN (products_count);
end getCountProductsByVendorName;


/*написати процедуру, що за адресою постачальника поверає його ключ, якщо операція не можлива процедура кидає екс*/

CREATE OR REPLACE PROCEDURE getVendKey(address IN VENDORS.VEND_ADDRESS%TYPE, KEY OUT VENDORS.VEND_ID%TYPE)
  IS
BEGIN
    SELECT vend_id INTO KEY 
    FROM VENDORS
    WHERE VEND_ADDRESS = address;
EXCEPTION
    WHEN NOT_DATA_FOUND THEN
      RAISE EXCEPTION;
END getVendKey;


/*написати процедуру, що оновлює назву продукту. Визначити всі необхідні параметри. Якщо продлукт не існує, або продукт продано у 3
замовлення - процедура кидає екс*/

CREATE OR REPLACE PROCEDURE updProdName(prodId PRODUCTS.PROD_ID%TYPE)
  IS
BEGIN
    SELECT PRODUCTS.PROD_NAME, ORDERITEMS.ORDER_ITEM 
    FROM PRODUCTS JOIN ORDERITEMS
                  ON PRODUCTS.PROD_ID = ORDERITEMS.PROD_ID
    WHERE PROD_ID = prodId AND ORDER_ITEM = 3;
EXCEPTION
    WHEN NOT_DATA_FOUND OR THEN
      RAISE EXCEPTION;      
END updProdName;
