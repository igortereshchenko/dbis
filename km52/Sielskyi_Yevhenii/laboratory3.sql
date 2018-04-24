/*1. Написати PL/SQL код, що додає постачальників, щоб сумарна кількість усіх постачальників була 10. Ключі постачальників vvv1….vvvn. 
Решта значень обов’язкових полів відповідає полям  постачальника з ключем BRS01.
10 балів*/

Declare
    VendCount int := 0;
Begin
    Select count(vend_id) into VendCount from VENDORS;
    VendCount := 10 - VendCount;
    
    For i in 1..VendCount Loop
        INSERT into vendors (
            vend_id,
            vend_name
        ) Values (
            'vvv' || i,
            'BRS01'
        );
    End Loop;
End;    


/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/

Declare
    VendId vendors.vend_id%TYPE;
    VendName vendors.vend_name%TYPE;
    ProdPrice PRODUCTS.PROD_PRICE%TYPE;
    MinProdPrice PRODUCTS.PROD_PRICE%TYPE;
Begin
    Select vend_id, vend_name, prod_price into VendId, VendName, ProdPrice from vendors Left Join products on vendors.vend_id = products.vend_id;
    Select min(prod_price) into MinProdPrice From Products;

    If ProdPrice = MinProdPrice then 
        DBMS_Output.put_line(VendName || ' status - yes');
    Elsif ProdPrice > MinProdPrice then
        DBMS_Output.put_line(VendName || ' status - no');
    Else
        DBMS_Output.put_line(VendName || ' status - unknown');
End;


/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/
 
Create View cust_vend As Select
    vendors.vend_id,
    vendors.vend_country,
    products.prod_id,
    customers.cust_name
From Customers Join Orders 
    on customers.cust_id = ORDERS.CUST_ID
    Join orderitems
    on orders.order_num = ORDERITEMS.ORDER_NUM
    join products
    on ORDERITEMS.PROD_ID = PRODUCTS.PROD_ID
    join vendors
    on PRODUCTS.VEND_ID = VENDORS.VEND_ID;
    
Select vend_id, count(prod_id)
From cust_vend
group by vend_id
Having vend_country = 'Germany';

Select cust_name, count(prod_id)
From cust_vend
Group By cust_name;

