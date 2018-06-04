-- LABORATORY WORK 5
-- BY Kovalchuk_Yuliia
Create or REPLACE PROCEDURE delete_vend ( v_id IN Vendors.vend_id)  IS
p_id product.prod_id%type
v_id Vendor_vend_id%type;

BEGIN
vend_id varchar2;
prod_id varchar2;
 SELECT product.prod_id, Vendor_vend_id Into p_id, v_id
  FROM Products  Join  Vendors
  ON Products.vend_id=Vendors.vend_id
  Delete Vendors.v_id 
  Where Vendors.v_id=Vendors.vend_id
EXCeption  when count(v_id)=0
END delete_vend 

----------------------------------------------
Create or REPLACE PROCEDURE rename_cust (  
Cust_name, cust_id in Customers)
)  IS
o_id orders.order_nam%type
cust_nam Customer.cust_name%type
BEGIN
  SELECT orders.order_nam, Customer.cust_name Into o_id, cust_nam
  FROM  Customers Join  orders
  ON Customers.order_nam=orders.order_nam 
If ord_nam = 0 Then
Rename Customer.cust_name=Customer.cust_name2 when Customer.cust_name=Customer.cust_name2
end if
EXCeption Customer.cust_name
END rename_prod 
----------------------------------------------------
Create or REPLACE Function update_order_num ( o_num in Orders.Ordes_num)
o_nam Ordes_num%type
o_date Ordrs_date%type
BEGIN
  SELECT Orde_num, Orde_Date Into o_num, o_date
  FROM  Orders 
END update_order_num
Return o_nam
