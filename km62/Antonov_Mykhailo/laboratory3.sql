/*1. Написати PL/SQL код, що по вказаному ключу замовника додає йому замовлення з номерами 1,....n, 
щоб сумарна кількість його замовлень була 10. Дати нових замовлень дорівнюють даті останього замовлення. 
Операція виконується, якщо у замовника є хоча б одне замовлення. 10 балів*/


/*2. Написати PL/SQL код, що по вказаному ключу замовника виводить у консоль його ім'я та изначає  його статус.
Якщо він має 0 замовлень - статус  = "poor"
Якщо він має до 2 замовлень включно - статус  = "common"
Якщо він має більше 2 замовлень - статус  = "rich" 4 бали*/
    
    DECLARE
    status_poor VARCHAR2(5) = "poor"
    status_common VARCHAR2(5) = "common"
    status_rich VARCHAR2(5) = "rich"
    BEGIN
    SELECT CUSTOMERS.CUST_NAME
    FROM CUSTOMERS;



/*3. Створити предсавлення та використати його у двох запитах:
3.1. Вивести ключ покупця та постачальника, що співпрацювали.
3.2. Вивести ім'я покупця та загальну кількість куплених ним продуктів 6 балів.*/

CREATE VIEW new_view AS


SELECT CUSTOM_ID,CUSTOMER_NAME,PRODUCTS.PROD_ID

FROM PRODUCTS JOIN (


SELECT CUSTOM_ID,CUSTOMER_NAME,ORDERITEMS.PROD_ID as product_id

FROM ORDERITEMS JOIN (
SELECT DISTINCT CUSTOMERS.CUST_ID as custom_id,CUSTOMERS.CUST_NAME as customer_name,ORDERS.ORDER_NUM as orders_num
FROM CUSTOMERS JOIN ORDERS
ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID)

ON orders_num = ORDERITEMS.ORDER_NUM)

ON product_id = PRODUCTS.PROD_ID;




