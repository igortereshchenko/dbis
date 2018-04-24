-- LABORATORY WORK 3
-- BY Dreiev_Ihor
/*1. Написати PL/SQL код, що додає замовників, щоб сумарна кількість усіх замовників була 10. Ключі замовників test1….testn. 
Решта значень обов’язкових полів відповідає полям  замовника з ключем 1000000001.
10 балів*/
DECLARE
    count_cust int := 10;
    iter int := 0;
    first_user_name VARCHAR2(50) := ' ';
    first_user_id int := 1000000001;
    
    
BEGIN
    select count(*) into iter 
    FROM CUSTOMERS;
    SELECT
       CUST_NAME into first_user_name
    FROM CUSTOMERS
    WHERE CUSTOMERS.CUST_ID = first_user_id;
    count_cust := count_cust - iter;
    for i in 1..count_cust LOOP
        INSERT INTO CUSTOMERS(
           CUST_ID,
            CUST_NAME
        ) VALUES (
            'test'||i,
            first_user_name
        );
    
    END loop;
    
END;


/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та визначає  його статус.
Якщо він продав найдешевший продукт - статус  = "yes"
Якщо він продав не продавав найдешевший - статус  = "no"
Якщо він не продавав жодного продукту - статус  = "unknown*/


DECLARE
  vendor_pk varchar2(10) := ' ';
  vendor_status varchar2(10) := ' ';
  vendor_name varchar2(10) := ' ';
  
  
BEGIN
    select DISTINCT Products.VEND_ID 
    from Products JOIN ORDERITEMS on Products.PROD_ID = ORDERITEMS.PROD_ID
    where ORDERITEMS.ITEM_PRICE = min(ORDERITEMS.ITEM_PRICE);
    
    
    
 
END;



/*3. Створити представлення та використати його у двох запитах:
3.1. Яку сумарну кількість товарів продали постачальники, що проживають в Германії.
3.2. Вивести ім’я покупця та загальну кількість купленим ним товарів.
6 балів.*/
