-- LABORATORY WORK 5
-- BY Buts_Oleksandr
###task1###
create function f(x PRODUCTS.PROD_NAME%TYPE)
return number
is
a NUMBER
begin
    SELECT count(VENDORS.VEND_ID) into a FROM VENDORS join PRODUCTS
on VENDORS.VEND_ID=PRODUCTS.VEND_ID
where PRODUCTS.PROD_NAME=x
return a
end
###task2###
create procedure proc1(oldn in CUSTOMERS.CUST_NAME%TYPE,newn in CUSTOMERS.CUST_NAME%TYPE)
is
z exception
a number
begin
    select count(ORDERS.CUST_ID) into a from CUSTOMERS join ORDERS
on CUSTOMERS.CUST_ID=ORDERS.CUST_ID
where CUSTOMERS.CUST_NAME=oldn
if a!=0 then 
raise z
    update CUSTOMERS set
CUSTOMERS.CUST_NAME=newn
where CUSTOMERS.CUST_NAME=oldn
exception
when z then
dbms.output_line(" have order ")
end
###task3###
create procedure(x in PRODUCTS.PROD_NAME%TYPE,y in VENDORS.VEND_ID%TYPE)
is 
a number
b number
z exception
w exception
begin
    select count(VENDORS.VEND_ID) into a from 
VENDORS where VENDORS.VEND_ID=y
if a==0 then raise z
    select count(PRODUCTS.PROD_NAME) into b from 
PRODUCTS where PRODUCTS.PROD_NAME=x
if a>0 then raise w
    insert into PRODUCTS(VEND_ID,PROD_NAME)
values (y,x)
exception
when z,w then 
dbms.output_line("doesn't work")
end
