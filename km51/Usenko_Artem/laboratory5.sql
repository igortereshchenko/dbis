--написати функцію що повертає кількість покупців, що мають порожні замовлення і проживають у країні, що передаеться як параметр процедури

Create or Replace Function getCountCustomersByCountry(country CUSTOMERS.CUST_COUNTRY%Type) RETURN Number 
    is
    customers_count NUMBER;
begin
        SELECT Count(CUSTOMERS.CUST_ID) into customers_count FROM 
            CUSTOMERS JOIN ORDERS
                on CUSTOMERS.cust_id = Orders.cust_id and CUSTOMERS.CUST_COUNTRY = country
           and (SELECT COUNT(*) FROM ORDERS, ORDERITEMS WHERE ORDERS.order_num = ORDERITEMS.order_num and ORDERS.CUST_ID = CUSTOMERS.cust_id
  GROUP BY ORDERS.CUST_ID) = 0
  GROUP BY CUSTOMERS.CUST_ID;
RETURN (customers_count);
end getCountCustomersByCountry;


Create or Replace PROCEDURE GETKEY(email IN CUSTOMERS.CUST_EMAIl%Type, name IN CUSTOMERS.CUST_NAME%TYPE, key OUT CUSTOMERS.CUST_ID%TYPE)   as
begin
    SELECT cust_id into key 
     From CUSTOMERS
      where cust_email = email and cust_name = name;
      EXCEPTION
       WHEN NOT_DATA_FOUND then
            RAISE EXCEPTION;
end GETKEY;

Create or Replace PROCEDURE addORDER(custId CUSTOMERS.CUST_ID%type,  order_data ORDERS.order_date%type) as
count Number;
begin
    SELECT cust_name FROM CUSTOMERS where cust_id =custId;
       EXCEPTION
       WHEN NOT_DATA_FOUND then
            RAISE EXCEPTION;
            
end addORDER;

