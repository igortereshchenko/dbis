/*1. Ќаписати PL/SQL код, що додаЇ продукт постачальнику з ключем BRS01, щоб сумарна к≥льк≥сть його продукт≥в була 4. 
 люч≥ нових продукт≥в   - prod1Еprodn. –ешта обовТ€зкових пол≥в беретьс€ з продукту з ключем BRO1.
10 бал≥в*/
DECLARE 
count_prod int;
pr_name products.prod_name%type;
pr_price products.prod_price%type;
BEGIN
SELECT COUNT(*) into count_prod FROM Products where vend_id='BRS01';
SELECT prod_name, prod_price into pr_name, pr_price FROM products where vend_id='BRO1';
WHILE count_prod<=3 LOOP
INSERT into products ('prod' || count_prod, 'BRO1', pr_name, pr_price);
count_prod:=count_prod +1;
END;
/*2. Ќаписати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ≥м'€ та визначаЇ  його статус.
якщо в≥н купив найдорожчий продукт - статус  = "yes"
якщо в≥н не купив найдорожчий продукт- статус  = "no"
якщо в≥н немаЇ замовленн€ - статус  = "unknown*/
SET AUTOPRINT ON;
SET SERVEROUTPUT ON;
DECLARE
m_prod_price products.prod_price%type;
cust_pre_id customers.cust_id%type;
cust_ex_name customers.cust_name%type;
min_ord_num products.prod_num%type;
max_ord_num products.prod_num%type;
kek bool;
BEGIN
cust_pre_id:=1000000004;
kek:=false;
dbms_output.enable;
SELECT MAX(products.prod_price) into m_prod_price FROM products;
SELECT DISTINCT cust_name into cust_ex_name from prod_cust where cust_id=cust_pre_id;
dbms_output.put_line(cust_ex_name);

select min(order_num)into min_ord_num from orders ;

select max(order_num) into max_ord_num from orders ;

for j in min_ord_num..max_ord_num LOOP
IF (SELECT cust_id from orders where order_num=j)=cust_pre_id 
THEN


(SELECT DISTINCT cust_name 
into cust_ex_name 
from prod_cust 
where cust_id = cust_pre_id;
dbms_output.put_line(cust_ex_name);

IF (SELECT prod_price FROM prod_cust WHERE cust_id=cust_pre_id) = m_prod_price THEN
dbms_output.put_line('yes')
ELSE dbms_output.put_line('no'))

ELSE dbms_output.put_line('unknown');
END;

/*3. —творити представленн€ та використати його у двох запитах:
3.1. ¬ивести назву продукту та загальну к≥льк≥сть його продаж.
3.2. яка сумарна к≥льк≥сть товар≥в була куплена покупц€ми, що проживають в јмериц≥.
6 бал≥в.*/
CREATE VIEW prod_cust AS
SELECT cu.cust_id, cu.cust_name, cu.cust_country, o.order_num, pr.prod_name, pr.prod_price
FROM customers cu join orders o on cu.cust_id=o.cust_id
join orderitems oi on o.order_num=oi.order_num
join products pr on oi.prod_id=pr.prod_id;