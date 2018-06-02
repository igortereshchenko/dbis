CREATE function get_item_count(in vendor_id number)
return number
IS
prod_count number;
BEGIN
SELECT COUNT(PROD_ID) into prod_count FROM Product where VEND_ID=VENDOR_ID;
return prod_count;
END

CREATE Procedure get_vend_id(in vend_name varchar, out vendor_id number)
BEGIN
SELECT NVL(VEND_ID, 0) FROM Vendors Where VEND_NAME=vend_name;
IF vendor_id==0
Then
raise_application_error(-2001, "Vendor doesnt exist");
END
END

CREATE Procedute update_price(in price number, in product_id number)
IS 
prod_exist number;
order_exist number;
BEGIN
Select NVL(prod_id, 0) into prod_exist FROM Products Where prod_id=product_id;
if prod_exist==0
then
raise_application_error(-2002, "Product does not exist")
END
SELECT NVL(ORDER_NUM, 0) into ored_exist From OrderItems Where PROD_ID=product_id;
if order_exist
then
raise_application_error(-2002, "For this product exists order")
END
update Product
set PROD_PRICE=price
where PROD_ID=product_id
END
