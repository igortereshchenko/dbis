-- LABORATORY WORK 5
-- BY Lutsyk_Maksym
1/Create or REPLACE Function Count_ord (Order_date in Date, Num_OF_Orders out NUmber (10) )
Return number 
IS
  Num_OF_Orders  NUmber (10)
BEGIN
 Select Count(Orders.ORDER_NUM) INTO Num_OF_Orders
 From ORDERS
 RETURN Num_OF_Orders;
 END Count_ord;
 
 2/Create or REPLACE PROCEDURE CUST_RENAME (CUST_IDISHNIK IN  Customers.Cust_ID%TYPE)
      IS
      Count_ordrs number;
      BEGIN
  Select count(Orders.Cust_id) INTO Count_ordrs FROM CUSTOMERS 
  WHERE CUSTOMERS.CUST_ID = CUST_IDISHNIK;
 UPDATE CUSTOMERS
 SET CUST_NAME = "UNDEFINED"
 WHERE Customers.Cust_ID = CUST_IDISHNIK
 Exception 
    WHEN CUST_IDISHNIK = 0 
    Then dbms_output.put_line(UNEXPECTED)
End CUST_RENAME;

3/ Create or REPLACE PROCEDURE PROD_DEL (VEND_IDISHNIK IN  VENDORS.VEND_ID%TYPE)
IS
 Vend_Crt BOOLEAN 
 
