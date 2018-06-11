FUNCTION buyersCount (country Varchar)
    RETURN Number
IS
    custCount Number;
BEGIN
    SELECT count(*) INTO custCount FROM Customers
    JOIN Orders
    LEFT JOIN Orderitems
    WHERE Orderitems.ORDER_NUM IS NULL AND Customer.CUST_COUNTRY = country;
RETURN custCount;
END buyersCount;

PROCEDURE getCustKey (email Varchar, custName Varchar, custKey IN OUT Number)
IS
  notValidException EXCEPTION;
BEGIN
    SELECT CUST_ID INTO custKey FROM Customers WHERE CUST_EMAIL = email AND CUST_NAME = custName;
    IF custKey IS NULL THEN
        RAISE notValidException;
    END IF;
END getCustKey;

PROCEDURE addOrder (orderDate DATE, custId Number)
IS
    orderInsertException EXCEPTION;
BEGIN
    IF (SELECT count(*) FROM Orders WHERE ORDER_DATE = orderDate) == 0 THEN
        RAISE orderInsertException;
    END IF;
    IF (SELECT count(*) FROM Customers WHERE CUST_ID = custId) == 0 THEN
        RAISE orderInsertException;
    END IF;
    
    INSERT INTO Orders (ORDER_DATE, CUST_ID) VALUES (orderDate, custId); 
EXCEPTION
    WHEN orderInsertException THEN
        DBMS_OUTPUT.PUT_LINE("orderInsertException raised");
END;
