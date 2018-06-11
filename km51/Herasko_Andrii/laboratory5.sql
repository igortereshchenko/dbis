-- LABORATORY WORK 5
-- BY Herasko_Andrii
CREATE OR REPLACE function get_cust_count(country varchar2)
return number
is
custCount number;
BEGIN
  SELECT
    count(cust_id)
  INTO custCount
  FROM
    Orders left join Customers on Orders.cust_id = Customers.cust_id
  WHERE
    Customers.cust_country = country and Orders.cust_id = null;
   return custCount;
End;




CREATE OR REPLACE Procedure get_customer(email in varchar2, name in varchar2, data out number)
is
custCount number;
BEGIN
  SELECT
    count(*)
  INTO custCount
  FROM
    Customers
  WHERE
    cust_name = name and cust_email = email;
  if custCount = 1 then
    SELECT
    cust_id
    INTO data
    FROM
      Customers
    WHERE
      cust_name = name and cust_email = email;
  else 
    raise_application_error("-20001", "error");
  end if;
End;



CREATE OR REPLACE Procedure add_order(ord_num in number, ord_date in DATE, custId number)
is
countCustomer number;
CountSameDate number;
BEGIN
  SELECT
    Count(*)
  INTO countCustomer
  FROM
    Customers
  WHERE
    cust_id = custId;

  Select
    Count(*)
  into CountSameDate
  from
  Orders
  where 
  order_date = ord_date;
  
  if (countCustomer = 0 or CountSameDate > 1) then
    raise_application_exception("-20001", "error");
  end if;
end;
