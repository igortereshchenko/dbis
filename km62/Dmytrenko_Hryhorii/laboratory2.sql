/*1. Написати PL/SQL код, що по вказаному ключу постачальника додає йому продукти з ключами 1,....n, 
щоб сумарна кількість його продуктів була 10. Назви продуктів = кллюч продукту. Ціна кожного продукту = 1.
Операція виконується, якщо у постачальника є хоча б один продукт. 10 балів*/



/*2. Написати PL/SQL код, що по вказаному ключу постачальника виводить у консоль його ім'я та изначає  його статус.
Якщо він має 0 продуктів - статус  = "poor"
Якщо він має до 2 продуктів включно - статус  = "common"
Якщо він має більше 2 продуктів - статус  = "rich" 4 бали*/

DECLARE 
vendor_status varchar(15) := '';
BEGIN
    CREATE VIEW vendor_poor as
        SELECT vendors.vend_id
        FROM vendors LEFT JOIN products ON
        vendors.vend_id = products.vend_id
        WHERE products.vend_id IS NULL;
        
    CREATE VIEW vendor_common as
        SELECT vendors.vend_id
        FROM vendors LEFT JOIN products ON
        vendors.vend_id = products.vend_id
        WHERE (         
END;       


/*3. Створити представлення та використати його у двох запитах:
3.1. Вивести ключ покупця та та ім'я постачальника, що не співпрацювали.
3.2. Вивести ім'я постачальника та загальну кількість проданих ним продуктів 6 балів.*/

CREATE VIEW not_partners as
SELECT Customers.cust_id, Vendors.vend_name
FROM customers join orders on
    customers.cust_id = orders.cust_id
    orders join orderitems on
    orders.order_num = orderitems.order_num
    orderitems join products on
    orderitems.prod_id = products.prod_id
    products join vendors on
    products.vend_id = vendors.vend_id;
