-- LABORATORY WORK 5
-- BY Nikolaiev_Dmytro

-- LABORATORY WORK 5
-- BY Nikolaiev_Dmytro


create function emptyorders(cust_id in customers.cust_id%type)
RETURN number
IS retparam number;
BEGIN
Select count(orderitems.order_num) from orderitems into retparam
JOIN orders on orderitems.order_num=orders.order_num
JOIN customers on orders.cust_id=customers.cust_id
WHERE 
customers.cust_id=cust_id AND orders.order_num not in orderitems.order_num;
return retparam;
END;


create procedure returnid(email in customers.cust_email%type, cust_id out customers.cust_id%type)
BEGIN
SELECT customers.cust_id from customers into cust_id
where customers.cust_email=email;

EXCEPTION
WHEN NO_DATA_FOUND THEN
dbms_output.putline('Operation is not possible');
END;

create procedure updatecustname(cust_name IN customers.cust_name%type, newcust_name in customers.cust_name%type)
IS temp_id customers.cust_id%type;
    count_orders number;
alreadyHASorder EXCEPTION;
BEGIN
SELECT customers.cust_id from customers into temp_id
WHERE customers.cust_name=cust_name;

if(
(Select count(*) from customers into count_orders
join orders on customers.cust_id=orders.cust_id;
where customers.cust_name=cust_name and orders.order_num=orderitems.order_num) >=1)
THEN RAISE alreadyHASorder;

UPDATE customers 
SET customers.cust_name=newcust_name;
where customers.cust_name=cust_name


EXCEPTION
WHEN NO_DATA_FOUND then
dmbs_output.putline('NO SUCH CUSTOMER');
WHEN alreadyHASorder THEN
dmbs_output.putline('Already Has Order');
END;
