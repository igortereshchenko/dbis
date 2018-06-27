-- LABORATORY WORK 3
-- BY Buts_Oleksandr
 dbms_output.enable
/*1. Написати PL/SQL код, що додає продукт з ціною 10 постачальнику з ключем BRS01, щоб сумарна вартість його продуктів була менша 400. 
Ключі нових продуктів   - prod1…prodn. Решта обов’язкових полів береться з продукту з ключем BRO1.
10 балів*/
Declare 
VendorsKey VENDORS.VEND_ID%type;

for i in 1..n loop
insert values()
into table
BEGIN
end;
/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та визначає  його статус.
Якщо він купив два продукти - статус  = "yes"
Якщо він купив більше двох продуктів- статус  = "no"
Якщо він немає замовлення - статус  = "unknown*/
Declare
RES integer:=0;
names Vendors.VEND_name%type;
VENDkey VENDORS.VEND_ID%type;
BEGIN
select  Vendors.VEND_name,VENDORS.VEND_ID  into names,VENDkey from
VENDORS join Products on Products.VEND_ID=VENDORS.VEND_ID
group by Vendors.VEND_name,VENDORS.VEND_ID 

    if RES==2 then 
    DBMS_OUTPUT.PUT_LINE(names||"yes")
    else if RES>2 then
    DBMS_OUTPUT.PUT_LINE("no")
    else 
    DBMS_OUTPUT.PUT_LINE("unknown*/")
    end if;
end;

/*3. Створити представлення та використати його у двох запитах:
3.1. Скільки замовлень було зроблено покупцями з Англії.

create view V1 as select * from CUSTOMERS join orders on CUSTOMERS.CUST_ID=orders.CUST_ID
where Customers.Cust_country='England';
select count(ORDER_NUM) from V1;

3.2. На яку загальну суму продали постачальники товари покупцям з Англії.

create view V2 as select * from CUSTOMERS join orders on CUSTOMERS.CUST_ID=orders.CUST_ID join OrderItems on 
OrderItems.ORDER_NUM= orders.ORDER_NUM join Products on Products.PROD_ID=OrderItems.PROD_ID join
Vendors on Vendors.VEND_ID=Products.PROD_ID
where Customers.Cust_country='England';

select SUM(PROD_PRISE) from V2;
6 балів.*/
